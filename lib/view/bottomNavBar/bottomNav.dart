import 'package:e_commerce/constants/color_consts.dart';
import 'package:e_commerce/controller/bottomNavProvider/bottomNavProvider.dart';
import 'package:e_commerce/view/cart/cart.dart';
import 'package:e_commerce/view/fav/fav.dart';
import 'package:e_commerce/view/home/home.dart';
import 'package:e_commerce/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({super.key});

  final List<Widget> pages = const [
    HomePage(),
    FavoritePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, bottomNav, child) {
        return Scaffold(
          body: pages[bottomNav.currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BottomNavigationBar(
                currentIndex: bottomNav.currentIndex,
                onTap: (index) {
                  bottomNav.changeIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.bgColor,
                selectedItemColor: AppColors.mainColor,
                unselectedItemColor: AppColors.conatinerClr,
                showUnselectedLabels: true,
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                elevation: 5,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: "Favorite",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: "Cart",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
