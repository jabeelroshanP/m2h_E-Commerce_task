import 'package:e_commerce/constants/color_consts.dart';
import 'package:e_commerce/controller/FavProvider/FavProvider.dart';
import 'package:e_commerce/controller/addToCartProvider/addToCartProvider.dart';
import 'package:e_commerce/controller/e_provider.dart';
import 'package:e_commerce/view/bottomNavBar/bottomNav.dart';
import 'package:e_commerce/widget/responsive/responsive.dart';
import 'package:e_commerce/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  void initState() {
    super.initState();
    initializeData();

     Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavPage()),
      );
    });
  }

  Future<void> initializeData() async {
    await context.read<EcommerceProvider>().getProducts();
    final products = context.read<EcommerceProvider>().model;
    context.read<Favprovider>().withProducts(products);
    context.read<CartProvider>().syncWithProducts(products);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.shopping_bag_outlined,
              color: AppColors.mainColor,
              size: 20.h,
            ),
          ),
          AppText(
            "Shopsy",
            color: AppColors.mainColor,
            size: TextSize.title,
          )
        ],
      ),
    );
  }
}
