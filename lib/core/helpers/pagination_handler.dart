import 'package:cleanarch/core/http/failuire.dart';
import 'package:cleanarch/core/local/hive_service_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/paginated_bloc.dart';
import '../http/either.dart';
import '../services_locator/services_locator.dart';
import 'logger.dart';

class PaginationHandler<T, B extends BlocBase<BaseState<T>>> {
  bool isLoadingMore = false;
  bool hasMoreData = true;
  int currentPage = 1;
  final int pageSize;
  List<T> items = [];
  final B bloc;
  final String? cacheKey;

  PaginationHandler({required this.bloc, this.cacheKey, this.pageSize = 15});
  late final _cache = getIt<IPaginatedCache<T>>();
  Future<void> loadFirstPage(
    PaginateFunc<T> fetchFunction, {
    Map<String, dynamic>? params,
    String? cacheKey,
  }) async {
    if (bloc.state.isLoading) return;
    bloc.emit(
      bloc.state.copyWith(status: Status.loading, items: [], hasMoreData: true),
    );
    items.clear();
    currentPage = 1;
    isLoadingMore = false;
    hasMoreData = true;

    final result = await fetchFunction(currentPage, pageSize, params);
    await result.fold(
      (failure) async {
        // On failure, load from cache
        if (failure is NotFoundFailure) {
          hasMoreData = false;
          bloc.emit(
            bloc.state.copyWith(
              status: Status.success,
              hasMoreData: hasMoreData,
            ),
          );
          return;
        }
        final cached = await _cache.getCachedPage(cacheKey: cacheKey!);
        if (cached.isNotEmpty) {
          items = cached;
          bloc.emit(
            bloc.state.copyWith(
              status: Status.success,
              items: List<T>.from(items),
            ),
          );
        } else {
          bloc.emit(
            bloc.state.copyWith(
              status: Status.failure,
              errorMessage: failure.message,
            ),
          );
        }
      },
      (data) async {
        items.addAll(data);
        if (cacheKey != null) {
          await _cache.cachePage(
            items,
            cacheKey: cacheKey,
          ); // Cache the first page
        }
        if (data.length >= pageSize) {
          currentPage++;
        } else {
          hasMoreData = false;
        }
        bloc.emit(
          bloc.state.copyWith(
            status: Status.success,
            items: List<T>.from(items),
            hasMoreData: hasMoreData,
          ),
        );
      },
    );
  }

  Future<void> fetchData(
    PaginateFunc<T> fetchFunction, {
    Map<String, dynamic>? params,
  }) async {
    if (!hasMoreData || isLoadingMore) {
      logger(
        'Not loading more - hasMoreData: $hasMoreData, isLoadingMore: $isLoadingMore',
      );
      return;
    }

    isLoadingMore = true;
    if (currentPage > 1) {
      bloc.emit(
        bloc.state.copyWith(
          status: Status.isLoadingMore,
          hasMoreData: hasMoreData,
        ),
      );
    }

    final result = await fetchFunction(
      currentPage,
      pageSize,
      params?..removeWhere((key, value) => value == null || value == ''),
    );
    await result.fold(
      (failure) async {
        isLoadingMore = false;
        if (failure is NotFoundFailure) {
          hasMoreData = false;
          bloc.emit(
            bloc.state.copyWith(
              status: Status.success,
              hasMoreData: hasMoreData,
            ),
          );
          return;
        }
        bloc.emit(
          bloc.state.copyWith(
            status: Status.failure,
            errorMessage: failure.message,
            hasMoreData: hasMoreData,
          ),
        );
      },
      (data) async {
        items.addAll(data);
        if (data.length >= pageSize) {
          currentPage++;
          loggerFatal('Loaded more data, currentPage: $currentPage');
        } else {
          hasMoreData = false;
          loggerFatal('No more data to load');
        }
        isLoadingMore = false;
        bloc.emit(
          bloc.state.copyWith(
            status: Status.success,
            items: List<T>.from(items),
            hasMoreData: hasMoreData,
          ),
        );
      },
    );
  }
}

typedef PaginateFunc<T> =
    Future<Either<Failure, List<T>>> Function(
      int page,
      int limit, [
      Map<String, dynamic>? params,
    ]);