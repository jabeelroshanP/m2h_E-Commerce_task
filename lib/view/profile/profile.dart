import 'package:e_commerce/constants/color_consts.dart';
import 'package:e_commerce/constants/text_consts.dart';
import 'package:e_commerce/widget/container_Widget.dart';
import 'package:e_commerce/widget/responsive/responsive.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 6.h,
                      backgroundColor: AppColors.bgColor,
                      child: CircleAvatar(
                        radius: 5.5.h,
                        backgroundImage: NetworkImage(
                          'https://avatar.iran.liara.run/public/42',
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    Text(
                      TextConsts.userName,
                      style: TextStyle(
                        color: AppColors.bgColor,
                        fontSize: 2.5.fs,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      TextConsts.userEmail,
                      style: TextStyle(
                        color: AppColors.bgColor.withOpacity(0.8),
                        fontSize: 1.8.fs,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.bgColor,
                        foregroundColor: AppColors.mainColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 1.5.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        TextConsts.editProfile,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 1.8.fs,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextConsts.account,
                      style: TextStyle(
                        fontSize: 2.fs,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 2.h),

                    buildProfileTile(
                      icon: Icons.person_outline,
                      title: TextConsts.personalInformation,
                      onTap: () {},
                    ),
                    buildProfileTile(
                      icon: Icons.shopping_bag_outlined,
                      title: TextConsts.myOrders,
                      onTap: () {},
                    ),
                    buildProfileTile(
                      icon: Icons.favorite_border,
                      title: TextConsts.wishlist,
                      onTap: () {},
                    ),
                    buildProfileTile(
                      icon: Icons.location_on_outlined,
                      title: TextConsts.shippingAddress,
                      onTap: () {},
                    ),
                    buildProfileTile(
                      icon: Icons.payment_outlined,
                      title: TextConsts.paymentMethods,
                      onTap: () {},
                    ),

                    AppContainer(
                      color: Colors.red.shade50,
                      child: ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title: Text(
                          TextConsts.logout,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 1.8.fs,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.red,
                        ),
                        onTap: () {},
                      ),
                    ),

                    SizedBox(height: 3.h),
                    Center(
                      child: Text(
                        TextConsts.version,
                        style: TextStyle(color: Colors.grey, fontSize: 1.5.fs),
                      ),
                    ),

                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: AppContainer(
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppColors.mainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.mainColor, size: 24),
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 1.8.fs),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 1.5.fs),
                )
              : null,
          trailing:
              trailing ??
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}
