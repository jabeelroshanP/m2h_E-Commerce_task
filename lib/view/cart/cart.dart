import 'package:e_commerce/constants/color_consts.dart';
import 'package:e_commerce/constants/text_consts.dart';
import 'package:e_commerce/controller/addToCartProvider/addToCartProvider.dart';
import 'package:e_commerce/widget/container_Widget.dart';
 import 'package:e_commerce/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    TextConsts.cartEmpty,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];
                      final product = item.product;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppContainer(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              cart.status == MyStatus.loading
                                  ? CircularProgressIndicator(
                                      color: AppColors.mainColor,
                                    )
                                  : SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Image.network(
                                        product.image ?? "",
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(
                                              Icons.image_not_supported,
                                            ),
                                      ),
                                    ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "\$${product.price?.toStringAsFixed(2) ?? "0.00"}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  AppContainer(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            cart.decrementQuantity(product);
                                            if (item.quantity == 1) {
                                              AppToasts.showSuccess(
                                                TextConsts.itemRemoved,
                                              );
                                            }
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                            color: AppColors.bgColor,
                                            size: 18,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Text(
                                            '${item.quantity}',
                                            style: const TextStyle(
                                              color: AppColors.bgColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              cart.incrementQuantity(product),
                                          child: const Icon(
                                            Icons.add,
                                            color: AppColors.bgColor,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  InkWell(
                                    onTap: () {
                                      cart.removeFromCart(product);
                                      AppToasts.showSuccess(
                                        TextConsts.itemRemoved,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AppContainer(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.conatinerClr,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            TextConsts.totalItems,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${cart.totalItems}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            TextConsts.totalPrice,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${cart.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            AppToasts.showSuccess(TextConsts.comingSoon);
                          },
                          child: const Text(
                            TextConsts.placeOrder,
                            style: TextStyle(
                              color: AppColors.bgColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
