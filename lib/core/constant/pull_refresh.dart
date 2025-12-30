import 'dart:io';

import 'package:cleanarch/core/animation/bouncing_and_all_refresh_indicator.dart';
import 'package:flutter/material.dart';

import '../helpers/logger.dart';

class PullToRefresh extends StatefulWidget {
  final Widget Function(ScrollController controller) builder;
  final bool enableRefresh;
  final bool enableLoadMore;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  final Widget? refreshIndicator;
  final Widget? loadingIndicator;
  final double refreshTriggerDistance;
  final double loadMoreTriggerOffset;
  final double? topPadding;
  final Duration minLoadMoreIndicatorDuration;

  const PullToRefresh({
    super.key,
    required this.builder,
    this.enableRefresh = true,
    this.enableLoadMore = false,
    this.onRefresh,
    this.onLoadMore,
    this.refreshIndicator,
    this.loadingIndicator,
    this.topPadding,
    this.refreshTriggerDistance = 100.0,
    this.loadMoreTriggerOffset = 100.0,
    this.minLoadMoreIndicatorDuration = const Duration(milliseconds: 800),
  }) : assert(
         enableRefresh || enableLoadMore,
         'At least one of enableRefresh or enableLoadMore must be true',
       );

  @override
  State<PullToRefresh> createState() => _PullToRefreshState();
}

class _PullToRefreshState extends State<PullToRefresh> {
  final ScrollController _scrollController = ScrollController();
  double _dragOffset = 0.0;
  bool _isRefreshing = false;
  bool _isLoadingMore = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (widget.enableLoadMore &&
        widget.onLoadMore != null &&
        !_isLoadingMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent -
                widget.loadMoreTriggerOffset) {
      _handleLoadMore();
    }
  }

  Future<void> _handleRefresh() async {
    if (!widget.enableRefresh || _isRefreshing || widget.onRefresh == null) {
      return;
    }
    setState(() => _isRefreshing = true);
    await widget.onRefresh!();
    if (context.mounted) {
      setState(() {
        _isRefreshing = false;
        _dragOffset = 0.0;
      });
    }
  }

  Future<void> _handleLoadMore() async {
    if (!widget.enableLoadMore || _isLoadingMore || widget.onLoadMore == null) {
      return;
    }
    setState(() => _isLoadingMore = true);
    final DateTime start = DateTime.now();
    await widget.onLoadMore!();
    final int elapsedMs = DateTime.now().difference(start).inMilliseconds;
    final int minMs = widget.minLoadMoreIndicatorDuration.inMilliseconds;
    if (elapsedMs < minMs) {
      await Future.delayed(Duration(milliseconds: minMs - elapsedMs));
    }
    if (mounted) {
      setState(() => _isLoadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final refreshProgress = (_dragOffset / widget.refreshTriggerDistance).clamp(
      0.0,
      1.0,
    );

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // if (notification is UserScrollNotification &&
        //     notification.direction == ScrollDirection.forward) {
        //   return true; // Block the notification
        // }

        // loggerWarn("notification ==========> ${notification.runtimeType}");
        // logger(notification is OverscrollNotification);
        // logger(!_isRefreshing);
        // logger(widget.enableRefresh);
        // logger(_dragOffset);

        bool isOverScroll = false;
        double overscroll = 0;
        if (Platform.isIOS) {
          if (notification is ScrollUpdateNotification) {
            final maxScroll = notification.metrics.maxScrollExtent;
            final minScroll = notification.metrics.minScrollExtent;
            final currentScroll = notification.metrics.pixels;
            overscroll = currentScroll - minScroll;
            loggerInfo("overscroll =========> $overscroll");
            if ((currentScroll - minScroll) > -100) {
              isOverScroll = true;
            } else if (currentScroll > maxScroll) {
              loggerInfo("Bounced at bottom (iOS-style overscroll)");
            }
          }
          // return true;
        } else {
          isOverScroll = notification is OverscrollNotification;
          if (isOverScroll) overscroll = notification.overscroll;
        }

        if (isOverScroll && !_isRefreshing && widget.enableRefresh) {
          // logger("overscrolled");
          setState(() {
            _dragOffset -= overscroll;
          });
        }
        if (notification is ScrollEndNotification) {
          if (widget.enableRefresh &&
              _dragOffset >= widget.refreshTriggerDistance) {
            // logger("overscrolled scroll ended");
            _handleRefresh();
          }
          setState(() => _dragOffset = 0.0);
        }
        return false;
      },
      child: Stack(
        children: [
          // Pass our internal controller into the list
          widget.builder(_scrollController),

          // Load more indicator (overlayed near bottom; customizable via loadingIndicator)
          if (_isLoadingMore && widget.enableLoadMore)
            Positioned(
              bottom: (MediaQuery.of(context).padding.bottom) + 20,
              left: 0,
              right: 0,
              child: Center(
                child:
                    widget.loadingIndicator ??
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
              ),
            ),

          // Pull-to-refresh indicator
          if ((widget.enableRefresh && (_dragOffset > 0 || _isRefreshing)))
            Positioned(
              top: widget.topPadding ?? 20,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: _isRefreshing ? 1.0 : refreshProgress,
                  duration: const Duration(milliseconds: 200),
                  child:
                      widget.refreshIndicator ??
                      BouncingBallRefreshIndicator(
                        progress: refreshProgress,
                        isRefreshing: _isRefreshing,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}