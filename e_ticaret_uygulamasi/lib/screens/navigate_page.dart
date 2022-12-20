import 'package:e_ticaret_uygulamasi/screens/person/person_page.dart';
import 'package:e_ticaret_uygulamasi/screens/search_page.dart';
import 'package:flutter/material.dart';
import '../components/alert_bar.dart';
import 'basket/basket_page.dart';
import 'home_page/home_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);
  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

int index = 0;
PageController globalController = PageController(initialPage: 0);

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  void initState() {
    super.initState();
    index = 0;
    globalController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    globalController.dispose();
    index = 0;

    globalController = PageController(initialPage: 0);
  }

  Future<bool> geriTusBasma() async {
    return alertDailogAreYouSure(
        context, "Uygulamadan çıkmak istediğinizden emin misiniz?", () {
      Navigator.pop(context, true);
      return null;
    }).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: geriTusBasma,
      child: Scaffold(
        body: PageView(
          controller: globalController,
          onPageChanged: (page) {
            index = page;
            setState(() {});
          },
          children: const [
            HomePage(),
            SearchPage(),
            BasketPage(),
            PersonPage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme:
              const IconThemeData(color: Colors.blue, opacity: 1),
          unselectedIconTheme:
              const IconThemeData(color: Colors.black87, opacity: 1),
          selectedItemColor: Colors.blue,
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Ana Sayfa",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Arama",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: "Sepet",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil",
            ),
          ],
          currentIndex: index,
          onTap: (indeks) {
            globalController.animateToPage(indeks,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          },
        ),
      ),
    );
  }
}
/*

    */
/*
    return AutoTabsRouter.tabBar(routes: [HomeRouter(),SearchRoute(),BasketRoute(),PersonRouteP()],
    builder:  (context, child, tabController) {
WillPopScope(
      onWillPop: geriTusBasma,
        child: Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: context.tabsRouter.activeIndex,
            onTap: context.tabsRouter.setActiveIndex,
            selectedIconTheme:
                const IconThemeData(color: Colors.blue, opacity: 1),
            unselectedIconTheme:
                const IconThemeData(color: Colors.black87, opacity: 1),
            selectedItemColor: Colors.blue,
            showSelectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Ana Sayfa",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Arama",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: "Sepet",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profil",
              ),
          ]
          ),
          
          ),
      );});
    */