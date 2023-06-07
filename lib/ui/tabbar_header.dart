import 'package:flutter/material.dart';

class TabBarHeader extends SliverPersistentHeaderDelegate {
  TabBarHeader({required this.minExtent, required this.maxExtent});
  final double maxExtent;
  final double minExtent;

  @override
  Widget build(Object context, double shrinkOffset, bool overlapsContent) {
    throw UnimplementedError();
  }


  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
