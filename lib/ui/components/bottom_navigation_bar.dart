import 'package:flutter/material.dart';
import 'package:songtube/ui/text_styles.dart';

class SongTubeNavigation extends StatefulWidget {
  final List<NavigationDestination> destinations;
  final NavigationDestinationLabelBehavior? labelBehavior;
  final int selectedIndex;
  final void Function(int index) onItemTap;
  final Color? backgroundColor;

  const SongTubeNavigation({
    Key? key,
    required this.onItemTap,
    required this.destinations,
    this.selectedIndex = 0,
    this.backgroundColor,
    this.labelBehavior,
  }) : super(key: key);

  @override
  State<SongTubeNavigation> createState() => _SongTubeNavigationState();
}

class _SongTubeNavigationState extends State<SongTubeNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: MaterialStateTextStyle.resolveWith((states) {
          return tinyTextStyle(context).copyWith(letterSpacing: 0.4);
        }),
        indicatorColor: Theme.of(context).primaryColor
      ),
      child: NavigationBar(
        elevation: 0,
        labelBehavior: widget.labelBehavior,
        backgroundColor: widget.backgroundColor,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int tappedIndex) {
          setState(() {
            _selectedIndex = tappedIndex;
          });
    
          widget.onItemTap(tappedIndex);
        },
        destinations: widget.destinations,
      ),
    );
  }
}