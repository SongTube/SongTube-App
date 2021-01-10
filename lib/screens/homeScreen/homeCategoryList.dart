import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';

class HomePageCategoryList extends SliverPersistentHeaderDelegate {
  
  HomePageCategoryList({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.onCategoryTap,
  });

  final double minHeight;
  final double maxHeight;
  final Function(HomeScreenTab) onCategoryTap;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent
  ) {
    return new SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0,3),
              blurRadius: 8,
              color: Colors.black.withOpacity(0.04)
            )
          ]
        ),
        child: categoryList(context)
      )
    );
  }

  @override
  bool shouldRebuild(HomePageCategoryList oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        categoryList != oldDelegate.categoryList;
  }

  Widget categoryList(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return ListView(
      
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(width: 8),
        // Home Page
        categoryTile(
          context: context,
          selected: manager.currentHomeTab == HomeScreenTab.Home
            ? true : false,
          title: "Home Page",
          onTap: () => onCategoryTap(HomeScreenTab.Home)
        ),
        // Trending
        categoryTile(
          context: context,
          selected: manager.currentHomeTab == HomeScreenTab.Trending
            ? true : false,
          title: "Trending",
          onTap: () => onCategoryTap(HomeScreenTab.Trending)
        ),
        // Music
        categoryTile(
          context: context,
          selected: manager.currentHomeTab == HomeScreenTab.Music
            ? true : false,
          title: "Music",
          onTap: () => onCategoryTap(HomeScreenTab.Music)
        ),
        // Favorites
        categoryTile(
          context: context,
          selected: manager.currentHomeTab == HomeScreenTab.Favorites
            ? true : false,
          title: "Favorites",
          onTap: () => onCategoryTap(HomeScreenTab.Favorites)
        ),
        // Watch Later
        categoryTile(
          context: context,
          selected: manager.currentHomeTab == HomeScreenTab.WatchLater
            ? true : false,
          title: "Watch Later",
          onTap: () => onCategoryTap(HomeScreenTab.WatchLater)
        ),
        SizedBox(width: 8)
      ],
    );
  }

  Widget categoryTile({
    BuildContext context,
    String title,
    bool selected,
    Function onTap
  }) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 60,
          decoration: BoxDecoration(
            color: selected
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.only(
            bottom: 8,
            top: 8,
            left: 12,
            right: 12
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                letterSpacing: 0.3,
                color: selected
                  ? Theme.of(context).textTheme.bodyText1.color
                  : Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
                fontSize: 12,
                fontFamily: 'YTSans',
                fontWeight: selected
                  ? FontWeight.w600
                  : FontWeight.normal
              ),
            )
          ),
        ),
      ),
    );
  }

}