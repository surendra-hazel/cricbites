import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends AppBar {
  CommonAppBar({
    super.key,
    required String titleText,
    bool super.centerTitle = true,
    bool showBackButton = false,
    super.actions,
    Color? backgroundColor,
    super.bottom,
    VoidCallback? onBack,
  }) : super(
          title: Text(
            titleText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.white
            ),
          ),
          backgroundColor: AppColors.black,
          elevation: 0,
          leading: showBackButton
              ? Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                    ),
                    onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  ),
                )
              : null,
        );
}
