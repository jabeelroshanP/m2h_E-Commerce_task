import 'package:e_commerce/constants/color_consts.dart';
import 'package:e_commerce/constants/text_consts.dart';
import 'package:e_commerce/controller/FavProvider/FavProvider.dart';
import 'package:e_commerce/controller/e_provider.dart';
import 'package:e_commerce/widget/container_Widget.dart';
import 'package:e_commerce/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  @override
  void initState() {
    super.initState();
    final products = context.read<EcommerceProvider>().model;
    context.read<Favprovider>().withProducts(products);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.bgColor,
        child: Consumer<Favprovider>(
          builder: (context, favProvider, child) {
            final favorites = favProvider.favorites;

            if (favorites.isEmpty) {
              return Center(
                child: Text(
                  TextConsts.noFavoritesYet,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AppContainer(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            product.image ?? "",
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported),
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
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "\$${product.price?.toStringAsFixed(2) ?? "0.00"}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            favProvider.tapFav(product);
                            AppToasts.showSuccess(
                              "${product.title ?? ""}${TextConsts.removedFromFavorites}",
                            );
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
