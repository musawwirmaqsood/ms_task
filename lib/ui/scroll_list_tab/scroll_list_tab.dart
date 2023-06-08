library scrollable_list_tabview;

import 'package:flutter/material.dart';
import 'package:ms_task/domain/entities/report_details.dart';
import 'package:ms_task/ui/widgets/header_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'model/scrollable_list_tab.dart';

export 'model/list_tab.dart';
export 'model/scrollable_list_tab.dart';

const Duration _kScrollDuration = Duration(milliseconds: 150);
const EdgeInsetsGeometry _kTabMargin =
    EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0);

class ScrollableListTabView extends StatefulWidget {
  /// Create a new [ScrollableListTabView]
  const ScrollableListTabView(
      {required this.tabs,
      required this.reportDetails,
      this.tabHeight = kToolbarHeight,
      this.tabAnimationDuration = _kScrollDuration,
      this.bodyAnimationDuration = _kScrollDuration,
      this.tabAnimationCurve = Curves.decelerate,
      this.bodyAnimationCurve = Curves.decelerate});

  /// List of tabs to be rendered.
  final List<ScrollableListTab> tabs;

  final ReportDetails reportDetails;

  /// Height of the tab at the top of the view.
  final double tabHeight;

  /// Duration of tab change animation.
  final Duration tabAnimationDuration;

  /// Duration of inner scroll view animation.
  final Duration bodyAnimationDuration;

  /// Animation curve used when animating tab change.
  final Curve tabAnimationCurve;

  /// Animation curve used when changing index of inner [ScrollView]s.
  final Curve bodyAnimationCurve;

  @override
  _ScrollableListTabViewState createState() => _ScrollableListTabViewState();
}

class _ScrollableListTabViewState extends State<ScrollableListTabView> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);

  final ItemScrollController _bodyScrollController = ItemScrollController();
  final ItemPositionsListener _bodyPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController _tabScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    _bodyPositionsListener.itemPositions.addListener(_onInnerViewScrolled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                pinned: false,
                delegate: _SliverStickyHeaderDelegate(
                  child: HeaderWidget(
                    report: widget.reportDetails,
                  ),
                  minExtent: 320,
                  maxExtent: 400,
                )),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverStickyHeaderDelegate(
                minExtent: 60,
                maxExtent: 60,
                child: Container(
                  height: widget.tabHeight,
                  color: Theme.of(context).cardColor,
                  child: ScrollablePositionedList.builder(
                    itemCount: widget.tabs.length,
                    scrollDirection: Axis.horizontal,
                    itemScrollController: _tabScrollController,
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    itemBuilder: (context, index) {
                      return ValueListenableBuilder<int>(
                          valueListenable: _index,
                          builder: (_, i, __) {
                            var selected = index == i;
                            return TextButton(
                              child: _buildTab(index, selected),
                              onPressed: () => _onTabPressed(index),
                            );
                          });
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ScrollablePositionedList.builder(
                shrinkWrap: true,
                itemScrollController: _bodyScrollController,
                itemPositionsListener: _bodyPositionsListener,
                itemCount: widget.tabs.length,
                itemBuilder: (_, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: _kTabMargin.add(const EdgeInsets.all(5.0)),
                      child: _buildInnerTab(index),
                    ),
                    Flexible(
                      child: widget.tabs[index].body,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInnerTab(int index) {
    var tab = widget.tabs[index].tab;

    return Builder(
      builder: (_) {
        return DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tab.label,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(int index, bool isActive) {
    var tab = widget.tabs[index].tab;

    return Text(
      tab.label.toUpperCase(),
      style: TextStyle(
          color: Colors.transparent,
          decorationColor:
              isActive ? Theme.of(context).primaryColor : Colors.transparent,
          shadows: [
            Shadow(
                color:
                    isActive ? Theme.of(context).primaryColor : Colors.black87,
                offset: const Offset(0, -10))
          ],
          decoration: TextDecoration.underline,
          decorationThickness: 3),
    );
  }

  void _onInnerViewScrolled() async {
    var positions = _bodyPositionsListener.itemPositions.value;

    /// Target [ScrollView] is not attached to any views and/or has no listeners.
    if (positions.isEmpty) return;

    print('_onInnerViewScrolled:positions: $positions ');

    /// Capture the index of the first [ItemPosition]. If the saved index is same
    /// with the current one do nothing and return.
    var firstIndex =
        _bodyPositionsListener.itemPositions.value.elementAt(0).index;
    if (_index.value == firstIndex) return;

    /// A new index has been detected.
    await _handleTabScroll(firstIndex);
  }

  Future<void> _handleTabScroll(int index) async {
    _index.value = index;
    await _tabScrollController.scrollTo(
        index: _index.value,
        duration: widget.tabAnimationDuration,
        curve: widget.tabAnimationCurve);
  }

  /// When a new tab has been pressed both [_tabScrollController] and
  /// [_bodyScrollController] should notify their views.
  void _onTabPressed(int index) async {
    await _tabScrollController.scrollTo(
        index: index,
        duration: widget.tabAnimationDuration,
        curve: widget.tabAnimationCurve);
    await _bodyScrollController.scrollTo(
        index: index,
        duration: widget.bodyAnimationDuration,
        curve: widget.bodyAnimationCurve);
    _index.value = index;
  }

  @override
  void dispose() {
    _bodyPositionsListener.itemPositions.removeListener(_onInnerViewScrolled);
    return super.dispose();
  }
}

class _SliverStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverStickyHeaderDelegate({
    required this.child,
    required this.minExtent,
    required this.maxExtent,
  });

  final Widget child;
  @override
  final double minExtent;
  @override
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverStickyHeaderDelegate oldDelegate) {
    return false;
  }
}
