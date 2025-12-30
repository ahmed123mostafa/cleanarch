import 'package:equatable/equatable.dart';

class PaginationParams extends Equatable {
  final int page;
  final int limit;
  const PaginationParams({required this.page, this.limit = 15});
  Map<String, dynamic> toJson() => {'page': page, 'pageSize': limit};
  @override
  List<Object?> get props => [page, limit];
}

class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];
}