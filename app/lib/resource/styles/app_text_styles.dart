// ignore_for_file: avoid_hard_coded_text_style
import 'package:flutter/material.dart';

import '../../app.dart';

/// AppTextStyle format as follows:
/// s[fontSize][fontWeight][Color]
/// Example: s18w400Primary

class AppTextStyles {
  AppTextStyles._();
  static const _defaultLetterSpacing = 0.03;

  static const _baseTextStyle = TextStyle(
    letterSpacing: _defaultLetterSpacing,
    fontFamily: 'SegoeUI',
    // height: 1.0,
  );

  static TextStyle s24w700Primary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontSize: Dimens.d24.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w700,
        color: AppColors.current.primaryTextColor,
      ));

  static TextStyle s14w400Primary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontSize: Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.primaryTextColor,
      ));

  static TextStyle s14w600Primary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontSize: Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w600,
        color: AppColors.current.primaryTextColor,
      ));

  static TextStyle s16w600Primary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontSize: Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w600,
        color: AppColors.current.primaryTextColor,
      ));

  static TextStyle s14w400Secondary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontSize: Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.secondaryTextColor,
      ));

  static TextStyle s12w400Error({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontSize: Dimens.d12.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.errorColor,
      ));

  static TextStyle s14w400Disabled({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontSize: Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppPalette.neutralNormalHover,
      ));
}
