import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/managerProvider.dart';

class HomePageAppBar extends StatefulWidget {
  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> with TickerProviderStateMixin {

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    if (manager.showSearchBar)
      _animationController.forward();
    else
      _animationController.reverse();
    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: Theme.of(context).cardColor,
      title: Row(
        children: [
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.fastLinearToSlowEaseIn,
            vsync: this,
            child: manager.showSearchBar ? Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  if (manager.youtubeSearch == null) {
                    FocusScope.of(context).unfocus();
                  } else {
                    manager.youtubeSearch = null;
                    manager.searchController.clear();
                    manager.setState();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, top: 12, bottom: 12),
                  child: Icon(
                    EvaIcons.arrowBack,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ) : Container(),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 18, right: 18),
              height: kToolbarHeight*0.9,
              decoration: BoxDecoration(
                color: Theme.of(context).iconTheme.color
                  .withOpacity(0.03),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Stack(
                children: [
                  FadeTransition(
                    opacity: Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.fastOutSlowIn,
                      reverseCurve: Curves.fastOutSlowIn
                    )),
                    child: _searchBarTextField(),
                  ),
                  FadeTransition(
                    opacity: Tween<double>(
                      begin: 1.0,
                      end: 0.0,
                    ).animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.fastOutSlowIn,
                      reverseCurve: Curves.easeInQuart
                    )),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: Offset(0.2, 0.0)
                      ).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.fastOutSlowIn,
                        reverseCurve: Curves.easeInQuart
                      )),
                      child: _searchBarLogo()
                    ),
                  ),
                ],
              )
            ),
          ),
        ],
      )
    );
  }

  Widget _searchBarLogo() {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return GestureDetector(
      onTap: () {
        manager.searchController.clear();
        manager.searchBarFocusNode.requestFocus();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                DateTime.now().month == 12
                  ? 'assets/images/logo_christmas.png'
                  : 'assets/images/ic_launcher.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            Expanded(
              child: IgnorePointer(
                ignoring: true,
                child: Text(
                  "SongTube",
                    style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBarTextField() {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: TextFormField(
        controller: manager.searchController,
        focusNode: manager.searchBarFocusNode,
        onTap: () => manager.searchBarFocusNode.requestFocus(),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
          fontSize: 14
        ),
        decoration: InputDecoration(
          hintText: Languages.of(context).labelSearchYoutube,
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0, 
              style: BorderStyle.none,
            ),
          ),
        ),
        onFieldSubmitted: (String query) {
          manager.searchYoutube(query: query, forceReload: true);
          FocusScope.of(context).unfocus();
          if (query.length > 1) {
            Future.delayed(Duration(milliseconds: 400), () =>
              config.addStringtoSearchHistory(query.trim()
            ));
          }
        },
        onChanged: (_) {
          manager.setState();
        },
      ),
    );
  }

}

