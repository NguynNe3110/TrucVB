import 'package:flutter/material.dart';

import '../app.dart';

/// Kiểu dáng hình học của ô nhập (Variant)
enum AppTextFieldVariant {
  /// Kiểu đóng khung viền bo tròn (Mặc định - như trong ảnh 2 & 3)
  outlined,

  /// Kiểu không viền hoặc gạch chân (như trong ảnh 1)
  borderless,
}

/// Component ô nhập chuẩn hóa cho toàn bộ ứng dụng.
/// Tự động xử lý 4 trạng thái:
/// 1. Default (bình thường)
/// 2. Focused (khi người dùng click vào -> viền xanh)
/// 3. Disabled (khi bị vô hiệu hóa -> nền xám mờ)
/// 4. Error (khi có lỗi -> viền đỏ, hiển thị dòng lỗi bên dưới)
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    String? labelText,
    String? title,
    this.hintText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.maxLines = 1,
    this.variant = AppTextFieldVariant.outlined,
    this.borderRadius,
    this.fillColor,
  }) : labelText = labelText ?? title;

  /// Label hiển thị phía trên ô nhập (nếu null sẽ không hiển thị)
  final String? labelText;

  /// Chữ gợi ý hiển thị bên trong (Placeholder)
  final String? hintText;

  /// Nội dung thông báo lỗi (khi có giá trị sẽ tự động bật trạng thái Error)
  final String? errorText;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  /// Icon / Widget nằm ở đầu ô nhập
  final Widget? prefixIcon;

  /// Icon / Widget nằm ở cuối ô nhập
  final Widget? suffixIcon;

  /// Bật chế độ mật khẩu (tự động toggle ẩn/hiện văn bản)
  final bool isPassword;

  /// Cho phép chỉnh sửa hay không (false -> chuyển sang trạng thái Disabled)
  final bool enabled;

  final bool readOnly;
  final bool autofocus;
  final FocusNode? focusNode;
  final int? maxLines;

  /// Kiểu dáng viền (outlined hoặc borderless)
  final AppTextFieldVariant variant;

  final BorderRadius? borderRadius;
  final Color? fillColor;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPassword != widget.isPassword) {
      _obscureText = widget.isPassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = widget.borderRadius ??
        BorderRadius.circular(Dimens.d8.responsive());

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. FIELD LABEL (Nếu có truyền thì hiện, không thì ẩn đi như ảnh 3)
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: widget.enabled
                ? AppTextStyles.s14w600Primary()
                : AppTextStyles.s14w400Disabled(),
          ),
          SizedBox(height: Dimens.d6.responsive()),
        ],

        // 2. INPUT FIELD CHÍNH
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onSubmitted: widget.onFieldSubmitted,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          style: widget.enabled
              ? AppTextStyles.s14w400Primary()
              : AppTextStyles.s14w400Disabled(),
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: AppTextStyles.s14w400Secondary(),
            errorText: widget.errorText,
            errorStyle: AppTextStyles.s12w400Error(),
            filled: true,
            fillColor: widget.enabled
                ? (widget.fillColor ?? AppColors.current.cardBackgroundColor)
                : AppPalette.neutralLight,
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimens.d16.responsive(),
              vertical: Dimens.d14.responsive(),
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.d12.responsive(),
                    ),
                    child: widget.prefixIcon,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 24,
            ),
            suffixIcon: _buildSuffixIcon(),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 24,
            ),
            // Cấu hình các trạng thái viền theo Design System:
            border: _buildBorder(
              color: AppColors.current.borderColor,
              radius: effectiveBorderRadius,
            ),
            enabledBorder: _buildBorder(
              color: AppColors.current.borderColor,
              radius: effectiveBorderRadius,
            ),
            focusedBorder: _buildBorder(
              color: AppColors.current.focusBorderColor,
              width: 1.5,
              radius: effectiveBorderRadius,
            ),
            errorBorder: _buildBorder(
              color: AppColors.current.errorColor,
              width: 1.5,
              radius: effectiveBorderRadius,
            ),
            focusedErrorBorder: _buildBorder(
              color: AppColors.current.errorColor,
              width: 1.5,
              radius: effectiveBorderRadius,
            ),
            disabledBorder: _buildBorder(
              color: AppPalette.neutralLightActive,
              radius: effectiveBorderRadius,
            ),
          ),
        ),
      ],
    );
  }

  /// Tự động xử lý icon đuôi:
  /// Nếu là ô mật khẩu thì hiển thị con mắt bật/tắt
  /// Nếu người dùng truyền suffixIcon thì hiển thị icon của họ
  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.current.secondaryTextColor,
          size: Dimens.d20.responsive(),
        ),
        onPressed: widget.enabled
            ? () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              }
            : null,
      );
    }

    if (widget.suffixIcon != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.d12.responsive()),
        child: widget.suffixIcon,
      );
    }

    return null;
  }

  /// Tạo viền linh hoạt theo variant: Outlined hoặc Borderless
  InputBorder _buildBorder({
    required Color color,
    required BorderRadius radius,
    double width = 1.0,
  }) {
    if (widget.variant == AppTextFieldVariant.borderless) {
      return InputBorder.none;
    }

    return OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}
