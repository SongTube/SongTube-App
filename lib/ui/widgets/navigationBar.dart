import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> navigationItems;
  final TabController controller;
  final Function(int) onItemTap;
  AppBottomNavigationBar({
    @required this.navigationItems,
    @required this.controller,
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
        currentIndex: controller.index,
        selectedFontSize: 14,
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