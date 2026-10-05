// ignore_for_file: avoid_hard_coded_colors
import 'package:flutter/material.dart';

import '../../app.dart';

/// Lớp quản lý màu theo ngữ cảnh (Semantic Theme Colors).
/// Tự động đổi màu khi người dùng chuyển Light/Dark mode.
class AppColors {
  const AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.backgroundColor,
    required this.cardBackgroundColor,
    required this.borderColor,
    required this.focusBorderColor,
    required this.errorColor,
    required this.errorBackgroundColor,
    required this.successColor,
    required this.warningColor,
    required this.infoColor,
    required this.darkButtonColor,
    required this.switchActiveColor,
    required this.switchInactiveColor,
    required this.primaryGradient,
  });

  static late AppColors current;

  // --- Brand colors ---
  final Color primaryColor;
  final Color secondaryColor;

  // --- Background & Surface ---
  final Color backgroundColor;
  final Color cardBackgroundColor;

  // --- Typography ---
  final Color primaryTextColor;
  final Color secondaryTextColor;

  // --- Borders & Inputs ---
  final Color borderColor;
  final Color focusBorderColor;

  // --- Semantic Feedback ---
  final Color errorColor;
  final Color errorBackgroundColor;
  final Color successColor;
  final Color warningColor;
  final Color infoColor;

  // --- UI Elements ---
  final Color darkButtonColor;
  final Color switchActiveColor;
  final Color switchInactiveColor;

  // --- Gradients ---
  final LinearGradient primaryGradient;

  /// Cấu hình màu cho LIGHT THEME
  static const defaultAppColor = AppColors(
    primaryColor: AppPalette.primaryNormal, // Cam #F69405
    secondaryColor: AppPalette.secondaryNormal, // Tím nhạt #A7A6DD
    backgroundColor: AppPalette.white,
    cardBackgroundColor: AppPalette.white,
    primaryTextColor: AppPalette.neutralDarker, // Đen #292A2A
    secondaryTextColor: AppPalette.neutralNormal, // Xám #747779
    borderColor: AppPalette.neutralLightActive, // Viền xám #D4D5D5
    focusBorderColor: AppPalette.blue6, // Viền xanh khi focus #18B3E7
    errorColor: AppPalette.red6, // Đỏ báo lỗi #C21515
    errorBackgroundColor: AppPalette.red1, // Nền đỏ nhạt #F9E8E8
    successColor: AppPalette.green6, // Xanh lá #09B92A
    warningColor: AppPalette.yellow6, // Vàng #F9F900
    infoColor: AppPalette.blue6, // Xanh dương #18B3E7
    darkButtonColor: AppPalette.neutralDarkActive, // Nút Google đen #343636
    switchActiveColor: AppPalette.blue6, // Switch ON #18B3E7
    switchInactiveColor: AppPalette.neutralLightActive, // Switch OFF #D4D5D5
    primaryGradient: LinearGradient(
      colors: [AppPalette.white, AppPalette.primaryNormal],
    ),
  );

  /// Cấu hình màu cho DARK THEME
  static const darkThemeColor = AppColors(
    primaryColor: AppPalette.primaryNormal,
    secondaryColor: AppPalette.secondaryDark,
    backgroundColor: AppPalette.neutralDarker, // Nền đen #292A2A
    cardBackgroundColor: AppPalette.neutralDarkActive, // #343636
    primaryTextColor: AppPalette.white,
    secondaryTextColor: AppPalette.neutralLightActive,
    borderColor: AppPalette.neutralDark,
    focusBorderColor: AppPalette.blue5,
    errorColor: AppPalette.red5,
    errorBackgroundColor: AppPalette.red10,
    successColor: AppPalette.green5,
    warningColor: AppPalette.yellow5,
    infoColor: AppPalette.blue5,
    darkButtonColor: AppPalette.neutralDark,
    switchActiveColor: AppPalette.blue5,
    switchInactiveColor: AppPalette.neutralDark,
    primaryGradient: LinearGradient(
      colors: [AppPalette.neutralDarker, AppPalette.primaryDark],
    ),
  );

  static AppColors of(BuildContext context) {
    final appColor = Theme.of(context).appColor;
    current = appColor;
    return current;
  }

  AppColors copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? backgroundColor,
    Color? cardBackgroundColor,
    Color? borderColor,
    Color? focusBorderColor,
    Color? errorColor,
    Color? errorBackgroundColor,
    Color? successColor,
    Color? warningColor,
    Color? infoColor,
    Color? darkButtonColor,
    Color? switchActiveColor,
    Color? switchInactiveColor,
    LinearGradient? primaryGradient,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      errorColor: errorColor ?? this.errorColor,
      errorBackgroundColor: errorBackgroundColor ?? this.errorBackgroundColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      infoColor: infoColor ?? this.infoColor,
      darkButtonColor: darkButtonColor ?? this.darkButtonColor,
      switchActiveColor: switchActiveColor ?? this.switchActiveColor,
      switchInactiveColor: switchInactiveColor ?? this.switchInactiveColor,
      primaryGradient: primaryGradient ?? this.primaryGradient,
    );
  }
}
