import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/widget/refresh/custom_refresh_indicator.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'custom_loading_more_base.dart';
import 'custom_loading_more_indicator.dart';

typedef BuildListItemCallBack<A> = Widget Function(BuildContext context, A data, int index);

///
/// 上下拉刷新-适用于普通列表，Sliver列表，NesSliver列表，瀑布流，Grid表格
/// 下拉刷新使用flutter sdk自带，
/// 加载更多使用第三方插件，文档：https://github.com/fluttercandies/loading_more_list/blob/master/README-ZH.md
///
/// 瀑布流，表格，相关回调
///
class SmartRefreshList<T> extends StatefulWidget {
  @override
  SmartRefreshListState<T> createState() => SmartRefreshListState<T>();

  const SmartRefreshList(
      {Key? key,
      required this.loadDataCallBack,
      required this.buildListItemCallBack,
      this.onDataChangeListener,
      this.pageSize = 10,
      this.headSlivers,
      this.bottomSlivers,
      this.isSliver = false,
      this.isNes = false,
      this.haveRefresh = true,
      this.loadingMoreBusyingWidget,
      this.fullScreenBusyingWidget,
      this.errorWidget,
      this.fullScreenErrorWidget,
      this.noMoreLoadWidget,
      this.emptyWidget,
      this.scrollController,
      this.physics,
      this.onlyOneSliver = false,
      this.lastChildLayoutType = LastChildLayoutType.none,
      this.extendedListDelegate,
      this.emptyIsFull = true,
      this.scrollDirection,
      this.clipBehavior = Clip.hardEdge})
      : super(key: key);

  ///数据变化的回调
  final OnDataChangeListener? onDataChangeListener;

  ///加载列表数据的回调
  final LoadDataCallBack loadDataCallBack;

  ///默认一页的数据条数,默认10条
  final int pageSize;

  ///列表item的构建回调
  final BuildListItemCallBack<T> buildListItemCallBack;

  ///是否用于Sliver系列       default=false
  final bool isSliver;

  ///是否用于NestedScrollView    default=false
  final bool isNes;

  ///是否有下拉刷新     default true
  final bool haveRefresh;

  ///裁剪
  final Clip clipBehavior;

  ///只要sliver，不要套成LoadingMoreCustomScrollView
  final bool onlyOneSliver;

  ///加载更多页的loading控件
  final Widget? loadingMoreBusyingWidget;

  ///加载第一页的loading控件
  final Widget? fullScreenBusyingWidget;

  ///加载更多页失败的控件
  final Widget? errorWidget;

  ///加载第一页失败的控件
  final Widget? fullScreenErrorWidget;

  ///没有更多页的控件
  final Widget? noMoreLoadWidget;

  ///为空页的控件
  final Widget? emptyWidget;

  ///列表的头部和底部，仅isSliver=true时才有效,且集合中所有widget也必须属于Sliver系列
  final List<Widget>? headSlivers;

  final List<Widget>? bottomSlivers;

  final ScrollController? scrollController;

  final ScrollPhysics? physics;

  final LastChildLayoutType lastChildLayoutType;

  ///瀑布流才需要传
  final ExtendedListDelegate? extendedListDelegate;

  ///空视图是否撑满屏
  final bool emptyIsFull;

  final Axis? scrollDirection;
}

class SmartRefreshListState<T> extends State<SmartRefreshList<T>> with AutomaticKeepAliveClientMixin {
  ///数据源
  late CustomLoadingMoreBase<T> listSource;

  ///列表的加载状态指示器
  late CustomLoadingMoreIndicator _loadingIndicator;

  ///下拉刷新的State Key
  late GlobalKey<CustomRefreshIndicatorState>? _refreshKey;

  @override
  void initState() {
    super.initState();

    if (widget.haveRefresh == true) {
      _refreshKey = GlobalKey();
    }

    listSource = CustomLoadingMoreBase(
        loadDataCallBack: widget.loadDataCallBack,
        pageSize: widget.pageSize,
        onDataChangeListener: widget.onDataChangeListener);

    _loadingIndicator = CustomLoadingMoreIndicator(
        listSourceRepository: listSource,
        loadingMoreBusyingWidget: widget.loadingMoreBusyingWidget,
        fullScreenBusyingWidget: widget.fullScreenBusyingWidget,
        errorWidget: widget.errorWidget,
        fullScreenErrorWidget: widget.fullScreenErrorWidget,
        noMoreLoadWidget: widget.noMoreLoadWidget,
        emptyWidget: widget.emptyWidget,
        isSliver: widget.isSliver,
        emptyIsFull: widget.emptyIsFull
        //emptyIconColor: Color(),
        //emptyMsgColor: Color(),
        );
  }

  ThemeData? themeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeData = Theme.of(context); // Save reference to the Theme here.
  }

  @override
  void dispose() {
    listSource.dispose();
    print('Theme brightness: ${themeData?.brightness}');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget loadMoreList = widget.isSliver == true ? _buildJustLoadMoreList4Sliver() : _buildJustLoadMoreList();

    if (widget.haveRefresh == false) return loadMoreList;

    if (widget.isNes == true) {
      return getAppDefaultRefreshIndicator(
        key: _refreshKey,
        onRefresh: onRefresh,
        child: loadMoreList,
      );
    }

    return getAppDefaultRefreshIndicator(
      key: _refreshKey,
      onRefresh: onRefresh,
      child: loadMoreList,
    );
  }

  Future<void> onRefresh() async {
    await listSource.refresh(false);
  }

  /// 公开方法：回到顶部
  void goTop() async {
    widget.scrollController?.jumpTo(0);
  }

  /// 公开方法：主动刷新，参数为是否显示指示器
  void refresh({bool showIndicator = false, bool clearBeforeRequest = true}) async {
    if (showIndicator == true) {
      _refreshKey?.currentState?.show();
    } else {
      listSource.refresh(clearBeforeRequest);
    }
  }

  /// 根据下标删除列表中某个元素
  void deleteItemByIndex({int index = -1}) {
    if (index == -1 || index >= listSource.length) {
      return;
    }
    listSource.removeAt(index);
    if (listSource.isEmpty) {
      listSource.indicatorStatus = IndicatorStatus.empty;
    }
    listSource.setState();
  }

  /// 拿到当前列表所有数据
  List<T> getListData() {
    return listSource;
  }

  /// 普通的加载更多列表
  Widget _buildJustLoadMoreList() {
    return LoadingMoreList<T>(
      ListConfig<T>(
          controller: widget.scrollController,
          shrinkWrap: true,
          showGlowTrailing: false,
          showGlowLeading: false,
          physics: widget.physics,
          indicatorBuilder: _loadingIndicator.buildYiHuaIndicator,
          itemBuilder: widget.buildListItemCallBack,
          sourceList: listSource,
          clipBehavior: widget.clipBehavior,
          lastChildLayoutType: widget.lastChildLayoutType,
          extendedListDelegate: widget.extendedListDelegate,
          scrollDirection: widget.scrollDirection ?? Axis.vertical),
    );
  }

  ///Sliver系列的加载更多列表
  Widget _buildJustLoadMoreList4Sliver() {
    var list = LoadingMoreSliverList<T>(
      SliverListConfig<T>(
        indicatorBuilder: _loadingIndicator.buildYiHuaIndicator,
        itemBuilder: widget.buildListItemCallBack,
        sourceList: listSource,
        lastChildLayoutType: widget.lastChildLayoutType,
        extendedListDelegate: widget.extendedListDelegate,
      ),
    );

    if (widget.onlyOneSliver) {
      return list;
    }

    var slivers = <Widget>[];

    /// 添加头部，如果有的话
    if ((widget.headSlivers?.length ?? 0) > 0) {
      slivers.addAll(widget.headSlivers!);
    }

    /// 添加列表
    slivers.add(list);

    /// 添加底部
    if ((widget.bottomSlivers?.length ?? 0) > 0) {
      slivers.addAll(widget.bottomSlivers!);
    }

    return LoadingMoreCustomScrollView(
      showGlowLeading: false,
      showGlowTrailing: false,
      controller: widget.scrollController,
      physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
      slivers: slivers,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
