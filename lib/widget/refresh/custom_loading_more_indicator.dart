import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/widget/common_widget.dart';
import 'package:flutter_rock_ui/widget/state/busy_state_widget.dart';
import 'package:flutter_rock_ui/widget/state/empty_state_widget.dart';
import 'package:flutter_rock_ui/widget/state/error_state_widget.dart';
import 'package:loading_more_list/loading_more_list.dart';

/// 自定义列表的加载状态
class CustomLoadingMoreIndicator {
  CustomLoadingMoreIndicator(
      {this.listSourceRepository,
      this.isSliver = false,
      this.loadingMoreBusyingWidget,
      this.fullScreenBusyingWidget,
      this.errorWidget,
      this.fullScreenErrorWidget,
      this.noMoreLoadWidget,
      this.emptyWidget,
      this.onTap,
      this.emptyIsFull = true});

  final LoadingMoreBase? listSourceRepository;
  final bool isSliver;
  final Widget? loadingMoreBusyingWidget;
  final Widget? fullScreenBusyingWidget;
  final Widget? errorWidget;
  final Widget? fullScreenErrorWidget;
  final Widget? noMoreLoadWidget;
  final Widget? emptyWidget;
  final GestureTapCallback? onTap;
  final bool emptyIsFull;

  Widget buildYiHuaIndicator(BuildContext context, IndicatorStatus status) {
    //print('buildYiHuaIndicator${status.index}');
    Widget widget;
    switch (status) {
      case IndicatorStatus.none:
        widget = Container(height: 0.0);
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = const BusyStateWidget();
        widget = setBackground(false, widget, 35.0);
        widget = loadingMoreBusyingWidget ?? widget;
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = const BusyStateWidget();
        widget = setBackground(true, widget, double.infinity);
        widget = fullScreenBusyingWidget ?? widget;
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
      case IndicatorStatus.error:
        widget = const ErrorStateWidget();
        widget = setBackground(false, widget, 35.0);
        widget = errorWidget ?? widget;
        widget = GestureDetector(
          onTap: () {
            listSourceRepository?.errorRefresh();
            onTap?.call();
          },
          child: widget,
        );
        break;
      case IndicatorStatus.fullScreenError:
        widget = const ErrorStateWidget();
        widget = setBackground(true, widget, double.infinity);
        widget = fullScreenErrorWidget ?? widget;
        widget = GestureDetector(
          onTap: () {
            listSourceRepository?.errorRefresh();
            onTap?.call();
          },
          child: widget,
        );
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
      case IndicatorStatus.noMoreLoad:
        widget = listLoadAll(top: 20, bottom: 30);
        //widget = setBackground(false, widget, 80.0);
        widget = noMoreLoadWidget ?? widget;
        break;
      case IndicatorStatus.empty:
        widget = const EmptyStateWidget();
        widget = emptyWidget ?? widget;
        widget = GestureDetector(
          onTap: () => listSourceRepository?.errorRefresh(),
          child: widget,
        );
        if (isSliver) {
          if (!emptyIsFull) {
            widget = SliverToBoxAdapter(
              child: widget,
            );
          } else {
            widget = SliverFillRemaining(
              child: widget,
            );
          }
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
    }
    return widget;
  }

  Widget setBackground(bool full, Widget widget, double height, {Color backgroundColor = Colors.white}) {
    widget = Container(
        width: double.infinity,
        height: height,
//        color: backgroundColor ?? Colors.grey[200],
        alignment: Alignment.center,
        child: widget);
    return widget;
  }

  Widget getIndicator(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: 2.0,
      valueColor: AlwaysStoppedAnimation(Color(0xff4080ff)),
    );
  }
}
