import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_today/bloc/bottom_navbar_bloc.dart';
import 'package:news_today/screens/tabs/sources_screen.dart';
import 'package:news_today/style/theme.dart' as Style;
import 'package:news_today/screens/source_detail.dart';

// import '../bloc/bottom_navbar_bloc.dart';
import 'tabs/home_screen.dart';
import 'tabs/search_screen.dart';
// import 'tabs/source_detail.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.grey,
          title: const Text(
            "NewsApp",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.HOME:
                return HomeScreen();
              case NavBarItem.SOURCES:
                return SourceScreen();
              case NavBarItem.SEARCH:
                return SearchScreen();
              case null:
                // TODO: Handle this case.
            }
            return SizedBox();
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20,
                unselectedItemColor: Colors.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.fixed,
                fixedColor: Colors.grey,
                currentIndex: snapshot.data!.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: const [
                  BottomNavigationBarItem(
                    icon: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Home",
                            style: TextStyle(fontWeight: FontWeight.w600))),
                    activeIcon: Icon(EvaIcons.home),
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Sources",
                            style: TextStyle(fontWeight: FontWeight.w600))),
                    activeIcon: Icon(EvaIcons.grid),
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Search",
                            style: TextStyle(fontWeight: FontWeight.w600))),

                    activeIcon: Icon(EvaIcons.search),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget testScreen() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Text("Test Screen")],
      ),
    );
  }
}
