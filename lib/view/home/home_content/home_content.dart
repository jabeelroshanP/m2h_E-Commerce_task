import 'package:e_commerce/constants/color_consts.dart';
import 'package:e_commerce/constants/text_consts.dart';
import 'package:e_commerce/controller/addToCartProvider/addToCartProvider.dart';
import 'package:e_commerce/controller/e_provider.dart' hide MyStatus;
import 'package:e_commerce/view/home/details/details.dart';
import 'package:e_commerce/widget/container_Widget.dart';
import 'package:e_commerce/widget/responsive/responsive.dart';
import 'package:e_commerce/widget/text_widget.dart';
import 'package:e_commerce/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EcommerceProvider>(
      builder: (context, value, child) {
        final products = value.filteredProducts;

        final content = value.model
            .map((e) => e.image ?? "")
            .where((img) => img.isNotEmpty)
            .toList();

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.78,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
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
                padding: EdgeInsets.all(2.w),
                child: Column(
                  spacing: 1.h,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppContainer(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.4.h,
                          ),
                          color: AppColors.mainColor,
                          child: Row(
                            children: [
                              AppText(
                                "${product.rating?.rate ?? 0}",
                                size: TextSize.small,
                                color: AppColors.bgColor,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.bgColor,
                                size: 5.r,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    value.status == MyStatus.loading
                        ? CircularProgressIndicator(color: AppColors.mainColor)
                        : SizedBox(
                            height: 8.h,
                            width: double.infinity,
                            child: Image.network(
                                product.image ?? "",
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.photo_camera_back_outlined,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),

                    AppText(
                      product.title ?? "No Title",
                      size: TextSize.small,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${double.tryParse(product.price.toString())?.toStringAsFixed(2) ?? "0.00"}",
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 2.fs,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Consumer<CartProvider>(
                          builder: (context, value, child) {
                            return ElevatedButton(
                              onPressed: () {
                                value.addToCart(product);
                                AppToasts.showSuccess(
                                  "${product.title ?? ""} added to cart!",
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainColor,
                                foregroundColor: AppColors.bgColor,
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                minimumSize: Size(0, 4.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(TextConsts.addToCart),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
