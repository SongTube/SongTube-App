import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/screens/home/home_downloads/pages/canceled.dart';
import 'package:songtube/screens/home/home_downloads/pages/completed.dart';
import 'package:songtube/screens/home/home_downloads/pages/queue.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/components/custom_inkwell.dart';
import 'package:songtube/ui/text_styles.dart';

class HomeDownloads extends StatefulWidget {
  const HomeDownloads({Key? key}) : super(key: key);

  @override
  State<HomeDownloads> createState() => _HomeDownloadsState();
}

class _HomeDownloadsState extends State<HomeDownloads> with TickerProviderStateMixin {

  // TabBar Controller
  late TabController tabController = TabController(length: 3, vsync: this,
    initialIndex: Provider.of<DownloadProvider>(context, listen: false).queue.isEmpty ? 1 : 0);

  // Keyboard Visibility
  KeyboardVisibilityController keyboardController = KeyboardVisibilityController();

  // Downloads Search Controllers
  TextEditingController searchController = TextEditingController();
  FocusNode node = FocusNode();

  @override
  void initState() {
    keyboardController.onChange.listen((event) {
      if (!event && node.hasFocus) {
        node.unfocus();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top+8),
          SizedBox(
            height: kToolbarHeight,
            child: _appBar()),
          _tabs(),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () {
        node.requestFocus();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardColor
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              const SizedBox(width: 16),
              const AppAnimatedIcon(Iconsax.search_normal, size: 18, opacity: 0.8),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: searchController,
                  focusNode: node,
                  style: subtitleTextStyle(context).copyWith(fontWeight: FontWeight.w500),
                  decoration: InputDecoration.collapsed(
                    hintStyle: smallTextStyle(context, opacity: 0.4).copyWith(fontWeight: FontWeight.w500),
                    hintText: Languages.of(context)!.labelSearchDownloads),
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 16),
              if (searchController.text.isNotEmpty)
              CustomInkWell(
                onTap: () {
                  searchController.clear();
                  node.unfocus();
                  setState(() {});
                },
                child: Icon(Icons.clear, color: Theme.of(context).iconTheme.color, size: 18),
              ),
              const SizedBox(width: 16),
            ],
          ),
        )
      ),
    );
  }

  Widget _tabs() {
    return SizedBox(
      height: kToolbarHeight,
      child: TabBar(
        padding: const EdgeInsets.only(left: 8),
        controller: tabController,
        isScrollable: true,
        labelColor: Provider.of<MediaProvider>(context).currentColors.vibrant,
        unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.4),
        labelStyle: tabBarTextStyle(context, opacity: 1),
        unselectedLabelStyle: tabBarTextStyle(context, bold: false),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.transparent,
        tabs: [
          // Queue
          Tab(child: Text(Languages.of(context)!.labelQueue)),
          // Completed
          Tab(child: Text(Languages.of(context)!.labelCompleted)),
          // Canceled
          Tab(child: Text(Languages.of(context)!.labelCancelled)),
        ],
      ),
    );
  }

  Widget _body() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: TabBarView(
        controller: tabController,
        children: [
          // Queue
          const DownloadsQueuePage(),
          // Completed
          DownloadsCompletedPage(searchQuery: searchController.text),
          // Canceled
          const DownloadsCanceledPage()
        ]
      ),
    );
  }

}