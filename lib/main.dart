import 'package:e_commerce/controller/FavProvider/FavProvider.dart';
import 'package:e_commerce/controller/addToCartProvider/addToCartProvider.dart';
import 'package:e_commerce/controller/bottomNavProvider/bottomNavProvider.dart';
import 'package:e_commerce/controller/details_provider/details_provider.dart';
import 'package:e_commerce/controller/e_provider.dart';
import 'package:e_commerce/controller/home_providers/home_provider.dart';
import 'package:e_commerce/view/Splash/splashPage.dart';
import 'package:e_commerce/view/bottomNavBar/bottomNav.dart';
import 'package:e_commerce/view/home/home.dart';
import 'package:e_commerce/widget/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:nice_overlay/nice_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    NiceOverlay.init(navigatorKey);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => EcommerceProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
        ChangeNotifierProvider(create: (_) => Favprovider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            SizeConfig.init(context);
            return const Splashpage();
          },
        ),
      ),
    );
  }
}
