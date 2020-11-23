import 'package:flutter/material.dart';

class HomePageCategoryList extends SliverPersistentHeaderDelegate {
  
  HomePageCategoryList({
    @required this.minHeight,
    @required this.maxHeight,
  });

  final double minHeight;
  final double maxHeight;

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
    return ListView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(width: 8),
        // Recommended
        categoryTile(
          context: context,
          title: "Recommended",
          onTap: () {
            
          }
        ),
        // Recommended
        categoryTile(
          context: context,
          title: "Trending",
          onTap: () {

          }
        ),
        // Recommended
        categoryTile(
          context: context,
          title: "Music",
          onTap: () {

          }
        ),
        // Recommended
        categoryTile(
          context: context,
          title: "Favorites",
          onTap: () {

          }
        ),
        // Recommended
        categoryTile(
          context: context,
          title: "Playlists",
          onTap: () {

          }
        ),
        SizedBox(width: 8)
      ],
    );
  }

  Widget categoryTile({
    BuildContext context,
    String title,
    Function onTap
  }) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12
              ),
            )
          ),
        ),
      ),
    );
  }

}