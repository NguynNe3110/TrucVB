import 'package:flutter/material.dart';

import '../app.dart';

/// Vị trí của nhãn so với Switch (trái hoặc phải)
enum AppSwitchLabelPosition {
  left,
  right,
}

/// Component Toggle Switch chuẩn hóa (❖ Checkbox Toggle trong Figma)
/// Hỗ trợ:
/// 1. Hiển thị dấu checkmark ✓ chìm trong rãnh trượt khi bật ON
/// 2. Hỗ trợ 4 trạng thái:
///    - Enabled ON (Rãnh xanh + icon check trắng + thumb trắng)
///    - Enabled OFF (Rãnh xám + thumb trắng)
///    - Disabled ON (Rãnh xám mờ + icon check mờ)
///    - Disabled OFF (Rãnh xám mờ + thumb mờ)
/// 3. Ghép nối linh hoạt với nhãn (Label) bên trái hoặc bên phải
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    required this.value,
    required this.onChanged,
    super.key,
    this.label,
    this.labelPosition = AppSwitchLabelPosition.right,
    this.labelStyle,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
  });

  /// Trạng thái bật (true) hay tắt (false)
  final bool value;

  /// Callback khi người dùng gạt switch
  final ValueChanged<bool>? onChanged;

  /// Nhãn văn bản đi kèm (ví dụ: "Ghi nhớ mật khẩu", "Field Label")
  final String? label;

  /// Vị trí hiển thị của nhãn (mặc định bên phải)
  final AppSwitchLabelPosition labelPosition;

  final TextStyle? labelStyle;

  /// Cho phép tương tác hay khóa (Disabled)
  final bool enabled;

  final Color? activeColor;
  final Color? inactiveColor;

  bool get _isInteractive => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final trackWidth = Dimens.d46.responsive();
    final trackHeight = Dimens.d26.responsive();
    final thumbSize = Dimens.d20.responsive();
    final padding = Dimens.d3.responsive();

    final Color effectiveActiveTrackColor =
        activeColor ?? AppColors.current.switchActiveColor;
    final Color effectiveInactiveTrackColor =
        inactiveColor ?? AppPalette.neutralLightActive;

    final Color currentTrackColor;
    final Color currentThumbColor;

    if (!_isInteractive) {
      currentTrackColor = AppPalette.neutralNormal;
      currentThumbColor = AppPalette.neutralLight;
    } else if (value) {
      currentTrackColor = effectiveActiveTrackColor;
      currentThumbColor = AppPalette.white;
    } else {
      currentTrackColor = effectiveInactiveTrackColor;
      currentThumbColor = AppPalette.white;
    }

    final Widget switchWidget = GestureDetector(
      onTap: _isInteractive ? () => onChanged!(!value) : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: trackWidth,
        height: trackHeight,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(trackHeight / 2),
          color: currentTrackColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Icon check ✓ chìm trong rãnh bên trái khi ON
            if (value)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: Dimens.d4.responsive()),
                  child: Icon(
                    Icons.check,
                    size: Dimens.d14.responsive(),
                    color: _isInteractive
                        ? AppPalette.white
                        : AppPalette.neutralNormalHover,
                  ),
                ),
              ),

            // Nút tròn trượt (Thumb)
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: thumbSize,
                height: thumbSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentThumbColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (label == null) {
      return switchWidget;
    }

    final effectiveLabelStyle = labelStyle ??
        (_isInteractive
            ? AppTextStyles.s14w400Primary()
            : AppTextStyles.s14w400Disabled());

    return GestureDetector(
      onTap: _isInteractive ? () => onChanged!(!value) : null,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (labelPosition == AppSwitchLabelPosition.left) ...[
            Text(label!, style: effectiveLabelStyle),
            SizedBox(width: Dimens.d8.responsive()),
            switchWidget,
          ] else ...[
            switchWidget,
            SizedBox(width: Dimens.d8.responsive()),
            Text(label!, style: effectiveLabelStyle),
          ],
        ],
      ),
    );
  }
}
