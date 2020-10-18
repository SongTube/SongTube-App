import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> navigationItems;
  final int currentIndex;
  final Function(int) onItemTap;
  AppBottomNavigationBar({
    @required this.navigationItems,
    @required this.currentIndex,
    @required this.onItemTap
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [                                                               
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            spreadRadius: 0.1,
            blurRadius: 10
          ),
        ],                                                                         
      ), 
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).cardColor,
        currentIndex: currentIndex,
        iconSize: 22,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        elevation: 8,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) => onItemTap(index),
        items: navigationItems
      ),
    );
  }
}