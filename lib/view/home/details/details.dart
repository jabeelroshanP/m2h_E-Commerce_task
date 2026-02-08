import 'package:e_commerce/Models/e_commerce_model.dart';
import 'package:e_commerce/constants/color_consts.dart';
import 'package:e_commerce/constants/text_consts.dart';
import 'package:e_commerce/controller/FavProvider/FavProvider.dart';
import 'package:e_commerce/controller/details_provider/details_provider.dart';
import 'package:e_commerce/controller/e_provider.dart';
import 'package:e_commerce/view/cart/cart.dart';
import 'package:e_commerce/widget/container_Widget.dart';
import 'package:e_commerce/widget/responsive/responsive.dart';
import 'package:e_commerce/widget/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_overlay/nice_overlay.dart';
import 'package:provider/provider.dart';

import '../../../controller/addToCartProvider/addToCartProvider.dart';
import '../../../widget/text_widget.dart';

class DetailsPage extends StatelessWidget {
  final ECommerceModel product;

  const DetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Consumer<EcommerceProvider>(
        builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.conatinerClr,
                expandedHeight: 5.h,
                pinned: true,
                actions: [
                  Consumer<Favprovider>(
                    builder: (context, favProvider, child) {
                      final isFav = favProvider.isFavorite(product);

                      return IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: AppColors.mainColor,
                          size: 28,
                        ),
                        onPressed: () {
                          favProvider.tapFav(product);
                          AppToasts.showSuccess(
                            isFav
                                ? "removed from favorites"
                                : "added to favorites",
                          );
                        },
                      );
                    },
                  ),

                  SizedBox(width: 3.w),
                ],

                leading: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.mainColor,
                    child: BackButton(color: AppColors.bgColor),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    spacing: 1.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppContainer(
                        child: SizedBox(
                          height: 45.h,
                          width: double.infinity,
                          child: Image(
                            image: Image.network(product.image ?? "").image,
                          ),
                        ),
                        color: AppColors.conatinerClr,
                      ),
                      AppText(product.title ?? "", fontWeight: FontWeight.w600),
                      SizedBox(height: 5),
                      Text(
                        product.description ?? "No Title",
                        style: TextStyle(
                          fontSize: 2.fs,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Consumer<DetailsProvider>(
                        builder: (context, value, child) {
                          double basePrice =
                              double.tryParse(product.price.toString()) ?? 0.0;
                          double totalPrice = basePrice * value.count;
                          return Row(
                            children: [
                              AppContainer(
                                color: AppColors.mainColor,
                                child: AppText(
                                  "\$${totalPrice.toStringAsFixed(2)}",
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.bgColor,
                                ),
                              ),
                              Spacer(),
                              AppContainer(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (value.count > 1) {
                                          value.decrement();
                                        } else {
                                          AppToasts.showSuccess(
                                            "Minimum limit is 1",
                                          );
                                        }
                                      },

                                      icon: const Icon(
                                        Icons.remove,
                                        color: AppColors.bgColor,
                                        size: 20,
                                      ),
                                    ),

                                    AppText(
                                      int.tryParse(
                                            value.count.toString(),
                                          )?.toString() ??
                                          "0",
                                      color: AppColors.bgColor,
                                      fontWeight: FontWeight.w600,
                                      size: TextSize.medium,
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        value.increment();
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: AppColors.bgColor,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

      bottomNavigationBar: BottomAppBar(
        color: AppColors.bgColor,
        padding: EdgeInsets.zero,
        elevation: 0,
        child: AppContainer(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 2.5.h,
                backgroundColor: AppColors.mainColor.withOpacity(0.2),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage(showBackButton: true,)),
                    );
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.mainColor,
                  ),
                ),
              ),

              const Spacer(),
              Consumer2<DetailsProvider, CartProvider>(
                builder: (context, detailsProvider, cartProvider, child) {
                  return SizedBox(
                    width: 60.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        minimumSize: Size(0, 6.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        cartProvider.addToCart(
                          product,
                          quantity: detailsProvider.count,
                        );

                        AppToasts.showSuccess(
                          "${product.title ?? ""} added to cart!",
                        );

                         detailsProvider.count = 1;
                      },
                      child: AppText(
                        TextConsts.addToCart,
                        color: AppColors.bgColor,
                        size: TextSize.medium,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
