import 'package:e_commerce/constants/color_consts.dart';
import 'package:e_commerce/widget/responsive/responsive.dart';
import 'package:e_commerce/widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:nice_overlay/nice_overlay.dart';

class AppToasts {
  static void showSuccess(String message) {
    NiceOverlay.showToast(
      NiceToast(
        message: AppText(
          message,
          color: AppColors.mainColor,
          size: TextSize.small,
          maxLines: 3,
        ),
        backgroundColor: AppColors.bgColor,
        borderRadius: BorderRadius.circular(30),
        margin: EdgeInsets.only(bottom: 8.h, left: 5.w, right: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
        displayDuration: const Duration(seconds: 3),
        niceToastPosition: NiceToastPosition.bottom,
        vibrate: true,
      ),
    );
  }
}
