import 'package:flutter/material.dart';

import '../app.dart';

/// Mục đích ngữ cảnh / Màu sắc của nút bấm
enum AppButtonType {
  /// Nút chính: Màu cam thương hiệu (Primary Fill), chữ trắng
  primary,

  /// Nút phụ tối màu: Nền đen #343636, chữ trắng (dùng cho Google, Dark action)
  secondary,

  /// Nút viền: Nền trong suốt/trắng, có viền bo ngoài
  outline,

  /// Nút dạng chữ: Không nền, không viền (Ghost / Text button)
  ghost,

  /// Nút cảnh báo / nguy hiểm: Nền đỏ #C21515, chữ trắng (Xóa, Hủy)
  destructive,

  /// Nút thành công: Nền xanh lá #09B92A, chữ trắng
  success,
}

/// Kích cỡ chiều cao của nút bấm
enum AppButtonSize {
  /// Chiều cao 36dp (dùng cho dialog, card nhỏ)
  small,

  /// Chiều cao 44dp (dùng cho form thông thường)
  medium,

  /// Chiều cao 52dp (dùng cho các hành động chính toàn màn hình, Auth)
  large,
}

/// Component Nút bấm chuẩn hoá cho toàn bộ dự án.
/// Hỗ trợ:
/// 1. Tự đổi màu theo Type (Primary, Secondary, Outline, Destructive...)
/// 2. Hỗ trợ Leading Icon (bên trái) và Trailing Icon (bên phải)
/// 3. Tự động xử lý trạng thái Disabled khi onPressed == null
/// 4. Tự động hiển thị CircularProgressIndicator khi isLoading == true
class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.width,
    this.height,
    this.borderRadius,
  });

  /// Factory tiện ích cho nút Đăng nhập với Google
  factory AppButton.google({
    required VoidCallback? onPressed,
    Key? key,
    String text = 'Đăng nhập với Google',
    bool isLoading = false,
    bool isFullWidth = true,
    AppButtonSize size = AppButtonSize.large,
  }) =>
      AppButton(
        key: key,
        text: text,
        onPressed: onPressed,
        type: AppButtonType.secondary,
        size: size,
        isFullWidth: isFullWidth,
        leadingIcon: Assets.images.icGoogle.svg(width: 20, height: 20),
        isLoading: isLoading,
      );

  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isLoading;
  final bool isFullWidth;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? _resolveHeight();
    final effectiveRadius = borderRadius ??
        BorderRadius.circular(Dimens.d8.responsive());

    final Widget content = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: Dimens.d20.responsive(),
            height: Dimens.d20.responsive(),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(_resolveTextColor()),
            ),
          )
        else ...[
          // Icon đầu (Leading Icon)
          if (leadingIcon != null) ...[
            leadingIcon!,
            SizedBox(width: Dimens.d8.responsive()),
          ],

          // Chữ hiển thị
          Text(
            text,
            style: _resolveTextStyle(),
          ),

          // Icon đuôi (Trailing Icon)
          if (trailingIcon != null) ...[
            SizedBox(width: Dimens.d8.responsive()),
            trailingIcon!,
          ],
        ],
      ],
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: effectiveHeight,
      child: Material(
        color: _resolveBackgroundColor(),
        borderRadius: effectiveRadius,
        child: InkWell(
          onTap: _isEnabled ? onPressed : null,
          borderRadius: effectiveRadius,
          splashColor: _resolveSplashColor(),
          highlightColor: _resolveHighlightColor(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _resolveHorizontalPadding(),
            ),
            decoration: BoxDecoration(
              borderRadius: effectiveRadius,
              border: _resolveBorder(),
            ),
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ),
    );
  }

  double _resolveHeight() {
    switch (size) {
      case AppButtonSize.small:
        return Dimens.d36.responsive();
      case AppButtonSize.medium:
        return Dimens.d44.responsive();
      case AppButtonSize.large:
        return Dimens.d52.responsive();
    }
  }

  double _resolveHorizontalPadding() {
    switch (size) {
      case AppButtonSize.small:
        return Dimens.d12.responsive();
      case AppButtonSize.medium:
        return Dimens.d16.responsive();
      case AppButtonSize.large:
        return Dimens.d20.responsive();
    }
  }

  Color _resolveBackgroundColor() {
    if (!_isEnabled) {
      if (type == AppButtonType.outline || type == AppButtonType.ghost) {
        return Colors.transparent;
      }
      return AppPalette.neutralNormalHover;
    }

    switch (type) {
      case AppButtonType.primary:
        return AppColors.current.primaryColor;
      case AppButtonType.secondary:
        return AppColors.current.darkButtonColor;
      case AppButtonType.destructive:
        return AppColors.current.errorColor;
      case AppButtonType.success:
        return AppColors.current.successColor;
      case AppButtonType.outline:
      case AppButtonType.ghost:
        return Colors.transparent;
    }
  }

  Color _resolveTextColor() {
    if (!_isEnabled) {
      if (type == AppButtonType.outline || type == AppButtonType.ghost) {
        return AppPalette.neutralNormal;
      }
      return AppPalette.white.withValues(alpha: 0.7);
    }

    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.secondary:
      case AppButtonType.destructive:
      case AppButtonType.success:
        return AppPalette.white;
      case AppButtonType.outline:
        return AppColors.current.primaryColor;
      case AppButtonType.ghost:
        return AppColors.current.primaryColor;
    }
  }

  TextStyle _resolveTextStyle() {
    final textColor = _resolveTextColor();
    switch (size) {
      case AppButtonSize.small:
        return TextStyle(
          fontFamily: 'SegoeUI',
          fontSize: Dimens.d12.responsive(),
          fontWeight: FontWeight.w600,
          color: textColor,
        );
      case AppButtonSize.medium:
        return TextStyle(
          fontFamily: 'SegoeUI',
          fontSize: Dimens.d14.responsive(),
          fontWeight: FontWeight.w600,
          color: textColor,
        );
      case AppButtonSize.large:
        return TextStyle(
          fontFamily: 'SegoeUI',
          fontSize: Dimens.d16.responsive(),
          fontWeight: FontWeight.w600,
          color: textColor,
        );
    }
  }

  Border? _resolveBorder() {
    if (type == AppButtonType.outline) {
      final borderColor = _isEnabled
          ? AppColors.current.primaryColor
          : AppPalette.neutralLightActive;
      return Border.all(color: borderColor, width: 1.5);
    }
    return null;
  }

  Color _resolveSplashColor() {
    switch (type) {
      case AppButtonType.primary:
        return AppPalette.primaryDarkActive.withValues(alpha: 0.2);
      case AppButtonType.outline:
      case AppButtonType.ghost:
        return AppColors.current.primaryColor.withValues(alpha: 0.1);
      default:
        return Colors.white10;
    }
  }

  Color _resolveHighlightColor() {
    switch (type) {
      case AppButtonType.primary:
        return AppPalette.primaryNormalActive;
      case AppButtonType.secondary:
        return AppPalette.neutralDarker;
      case AppButtonType.destructive:
        return AppPalette.red7;
      case AppButtonType.success:
        return AppPalette.green7;
      default:
        return Colors.transparent;
    }
  }
}
