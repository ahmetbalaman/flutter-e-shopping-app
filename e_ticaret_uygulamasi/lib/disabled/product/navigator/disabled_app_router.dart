/*import 'package:auto_route/auto_route.dart';
import 'package:e_ticaret_uygulamasi/screens/add_product/add_product_page.dart';
import 'package:e_ticaret_uygulamasi/screens/home_page/home_page.dart';
import 'package:e_ticaret_uygulamasi/screens/login_screen.dart';
import 'package:e_ticaret_uygulamasi/screens/disabled_main_landing_page.dart';
import 'package:e_ticaret_uygulamasi/screens/person/my_information.dart';
import 'package:e_ticaret_uygulamasi/screens/person/orders_page/all_orders_page.dart';
import 'package:e_ticaret_uygulamasi/screens/person/orders_page/my_oders_page/my_orders_page.dart';
import 'package:e_ticaret_uygulamasi/screens/register_page.dart';
import 'package:flutter/material.dart';
import '../../screens/basket/basket_page.dart';
import '../../screens/navigate_page.dart';
import '../../screens/person/person_page.dart';
import '../../screens/search_page.dart';
part 'app_router.gr.dart';      
@MaterialAutoRouter(              
  replaceInRouteName: 'Page,Route',              
  routes: <AutoRoute>[   
    AutoRoute(
      page: LandingPage,
      path: "land",
      children: [
        
      AutoRoute(page: EmptyAllPageRouter,name: 'LoginRouterP',children: [
   AutoRoute(initial: true,page: LoginPage,path: "login kısmı",
   
   
   ),
AutoRoute(page: RegisterPage,path: "register kısmı"),
    ]
    ),
      ]
    ),
    AutoRoute(
      page: NavigatorPage,
      initial: true,
      path: 'navigatePage',
      children: [
        AutoRoute(
          page: EmptyPageRouter,name: "HomeRouter", path: "home", maintainState: true,
          children: [
            AutoRoute(
              page: HomePage,
              initial: true,
              path: 'Home'
            ),
          ]
        ),
        AutoRoute(
          page: SearchPage,
          path: 'search'
        ),
        AutoRoute(
          page: BasketPage,
          path: 'basket'
        ),
        AutoRoute(page: EmptyPersonPageRouter,name: "PersonRouteP", maintainState: true,
            children: [
              AutoRoute(page: PersonPage,path: 'person',initial: true),
              AutoRoute(page: MyInformationPage,path: 'bilgilerim'),
              AutoRoute(page: AddProductPageDetail,path: 'urunekle'),
              AutoRoute(page: MyOrdersPage,path: 'siparislerim'),
              AutoRoute(page: AllOrdersPage,path: 'butunsiparisler'),
            ]),
      ]
    ),
  ],              
)
class AppRouter extends _$AppRouter {}
class EmptyPageRouter extends AutoRouter {
  const EmptyPageRouter({Key? key}) : super(key: key);
}
class EmptyPersonPageRouter extends AutoRouter {
  const EmptyPersonPageRouter({Key? key}) : super(key: key);
}
class EmptyAllPageRouter extends AutoRouter {
  const EmptyAllPageRouter({Key? key}) : super(key: key);
}*/