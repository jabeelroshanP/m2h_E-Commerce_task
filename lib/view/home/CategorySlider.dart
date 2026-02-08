import 'package:e_commerce/constants/color_consts.dart';
import 'package:e_commerce/controller/e_provider.dart';
import 'package:e_commerce/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySlider extends StatelessWidget {
  const CategorySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EcommerceProvider>(
      builder: (context, value, child) {
        final categories = value.model
            .map((e) => e.category ?? "")
            .where((c) => c.isNotEmpty)
            .toSet()
            .toList();
        categories.insert(0, 'All');
        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final capitalCategory = category.isNotEmpty
                  ? category[0].toUpperCase() + category.substring(1)
                  : category;

              final isSelected = value.selectedCategory.toLowerCase() ==
                  category.toLowerCase();

              return Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? AppColors.mainColor
                        : AppColors.conatinerClr,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onPressed: () {
                    value.filterByCategory(category);
                  },
                  child: AppText(
                    capitalCategory,
                    color:  AppColors.bgColor  ,
                    size: TextSize.small,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
