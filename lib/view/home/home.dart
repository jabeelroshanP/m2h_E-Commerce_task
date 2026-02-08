import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/constants/color_consts.dart';
import 'package:e_commerce/controller/FavProvider/FavProvider.dart';
import 'package:e_commerce/controller/addToCartProvider/addToCartProvider.dart'
    hide MyStatus;
import 'package:e_commerce/controller/e_provider.dart' hide MyStatus;
import 'package:e_commerce/controller/home_providers/home_provider.dart';
import 'package:e_commerce/view/home/CategorySlider.dart';
import 'package:e_commerce/view/home/details/details.dart';
import 'package:e_commerce/view/home/home_content/home_content.dart';
import 'package:e_commerce/widget/container_Widget.dart';
import 'package:e_commerce/widget/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/text_consts.dart';
import '../../widget/text_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Consumer<EcommerceProvider>(builder: (context, value, child) {
              Widget fullScreenCenter(Widget child) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - kToolbarHeight - 24,
                  child: Center(child: child),
                );
              }

              if (value.status == MyStatus.loading) {
                return fullScreenCenter(
                  const CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
              } else if (value.status == MyStatus.error) {
                return fullScreenCenter(
                  AppText(
                    value.errorMessage,
                    size: TextSize.medium,
                    color: Colors.red,
                  ),
                );
              } else if (value.model.isEmpty) {
                return fullScreenCenter(
                  const CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
              }
            return Column(
                spacing: 1.h,
                children: [
                  SizedBox(height: 5.h),

                  AppText(
                    TextConsts.discover,
                    size: TextSize.title,
                    fontWeight: FontWeight.w700,
                  ),

                  Consumer<HomeProvider>(
                    builder: (context, homeProvider, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (homeProvider.isSearchOpen)
                            Expanded(
                              child: AppContainer(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: TextConsts.searchHint,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),

                          if (homeProvider.isSearchOpen) SizedBox(width: 2.w),

                          GestureDetector(
                            onTap: () {
                              homeProvider.toggleSearch();
                            },
                            child: AppContainer(
                              child: Icon(
                                homeProvider.isSearchOpen
                                    ? Icons.close
                                    : Icons.search,
                                color: AppColors.bgColor,
                              ),
                              color: AppColors.mainColor,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  Consumer<EcommerceProvider>(
                    builder: (context, value, child) {
                      if (value.status == MyStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                          ),
                        );
                      }
                      if (value.status == MyStatus.error) {
                        return AppText(
                          value.errorMessage,
                          size: TextSize.medium,
                          color: Colors.red,
                        );
                      }
                      if (value.model.isEmpty) {
                        return const AppText(
                          TextConsts.noProductsFound,
                          size: TextSize.medium,
                          color: AppColors.mainColor,
                        );
                      }
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 20.h,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.7,
                        ),
                        items: value.model.map((product) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(product: product),
                                ),
                              );
                            },
                            child: AppContainer(
                              color: AppColors.bgColor,
                              width: double.infinity,
                              child: Image.network(
                                product.image ?? "",
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  CategorySlider(),
                  HomeContent(),
                ],
              );}
            ),
          ),
        ),
      ),
    );
  }
}
