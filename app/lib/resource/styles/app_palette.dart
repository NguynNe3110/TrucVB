// ignore_for_file: avoid_hard_coded_colors
import 'package:flutter/material.dart';

/// Toàn bộ mã màu gốc (Design Tokens / Primitive Palette) được bóc tách từ Figma
class AppPalette {
  const AppPalette._();

  // ==================== 1. MÀU CHỦ ĐẠO (PRIMARY) ====================
  static const Color primaryLight = Color(0xFFFEF4E6);
  static const Color primaryLightHover = Color(0xFFFEEFDA);
  static const Color primaryLightActive = Color(0xFFFCDEB2);
  static const Color primaryNormal = Color(0xFFF69405);
  static const Color primaryNormalHover = Color(0xFFDD8505);
  static const Color primaryNormalActive = Color(0xFFC57604);
  static const Color primaryDark = Color(0xFFB96F04);
  static const Color primaryDarkHover = Color(0xFF945903);
  static const Color primaryDarkActive = Color(0xFF6F4302);
  static const Color primaryDarker = Color(0xFF563402);

  // ==================== 2. MÀU PHỤ (SECONDARY) ====================
  static const Color secondaryLight = Color(0xFFF6F6FC);
  static const Color secondaryLightHover = Color(0xFFF2F2FA);
  static const Color secondaryLightActive = Color(0xFFE4E3F4);
  static const Color secondaryNormal = Color(0xFFA7A6DD);
  static const Color secondaryNormalHover = Color(0xFF9695C7);
  static const Color secondaryNormalActive = Color(0xFF8685B1);
  static const Color secondaryDark = Color(0xFF7D7DA6);
  static const Color secondaryDarkHover = Color(0xFF646485);
  static const Color secondaryDarkActive = Color(0xFF4B4B63);
  static const Color secondaryDarker = Color(0xFF3A3A4D);

  // ==================== 3. MÀU BẬC BA (TERTIARY) ====================
  static const Color tertiaryLight = Color(0xFFF5F7F9);
  static const Color tertiaryLightHover = Color(0xFFF0F3F6);
  static const Color tertiaryLightActive = Color(0xFFE0E5ED);
  static const Color tertiaryNormal = Color(0xFF9CACC5);
  static const Color tertiaryNormalHover = Color(0xFF8C9BB1);
  static const Color tertiaryNormalActive = Color(0xFF7D8A9E);
  static const Color tertiaryDark = Color(0xFF758194);
  static const Color tertiaryDarkHover = Color(0xFF5E6776);
  static const Color tertiaryDarkActive = Color(0xFF464D59);
  static const Color tertiaryDarker = Color(0xFF373C45);

  // ==================== 4. MÀU TRUNG TÍNH (NEUTRAL) ====================
  static const Color neutralLight = Color(0xFFF1F1F2);
  static const Color neutralLightHover = Color(0xFFEAEBEB);
  static const Color neutralLightActive = Color(0xFFD4D5D5);
  static const Color neutralNormal = Color(0xFF747779);
  static const Color neutralNormalHover = Color(0xFF686B6D);
  static const Color neutralNormalActive = Color(0xFF5D5F61);
  static const Color neutralDark = Color(0xFF57595B);
  static const Color neutralDarkHover = Color(0xFF464749);
  static const Color neutralDarkActive = Color(0xFF343636);
  static const Color neutralDarker = Color(0xFF292A2A);

  // ==================== 5. FEEDBACK - ERROR (RED) ====================
  static const Color red1 = Color(0xFFF9E8E8);
  static const Color red2 = Color(0xFFF0C7C7);
  static const Color red3 = Color(0xFFE59A9A);
  static const Color red4 = Color(0xFFD96C6C);
  static const Color red5 = Color(0xFFCD3F3F);
  static const Color red6 = Color(0xFFC21515); // Màu báo lỗi chuẩn
  static const Color red7 = Color(0xFFA51212);
  static const Color red8 = Color(0xFF8A0F0F);
  static const Color red9 = Color(0xFF6F0C0C);
  static const Color red10 = Color(0xFF570909);

  // ==================== 6. FEEDBACK - SUCCESS (GREEN) ====================
  static const Color green1 = Color(0xFFE6F8EA);
  static const Color green2 = Color(0xFFC4EECC);
  static const Color green3 = Color(0xFF95E1A3);
  static const Color green4 = Color(0xFF64D379);
  static const Color green5 = Color(0xFF35C650);
  static const Color green6 = Color(0xFF09B92A); // Màu thành công chuẩn
  static const Color green7 = Color(0xFF089D24);
  static const Color green8 = Color(0xFF06831E);
  static const Color green9 = Color(0xFF056918);
  static const Color green10 = Color(0xFF045313);

  // ==================== 7. FEEDBACK - WARNING (YELLOW) ====================
  static const Color yellow1 = Color(0xFFFEFEE6);
  static const Color yellow2 = Color(0xFFFEFEC2);
  static const Color yellow3 = Color(0xFFFCFC91);
  static const Color yellow4 = Color(0xFFFBFB5E);
  static const Color yellow5 = Color(0xFFFAFA2E);
  static const Color yellow6 = Color(0xFFF9F900); // Màu cảnh báo chuẩn
  static const Color yellow7 = Color(0xFFD4D400);
  static const Color yellow8 = Color(0xFFB1B100);
  static const Color yellow9 = Color(0xFF8E8E00);
  static const Color yellow10 = Color(0xFF707000);

  // ==================== 8. FEEDBACK - INFO (BLUE) ====================
  static const Color blue1 = Color(0xFFE8F7FD);
  static const Color blue2 = Color(0xFFC8EDF9);
  static const Color blue3 = Color(0xFF9CDEF5);
  static const Color blue4 = Color(0xFF6DCFF0);
  static const Color blue5 = Color(0xFF42C1EB);
  static const Color blue6 = Color(0xFF18B3E7); // Màu thông tin / link / focus chuẩn
  static const Color blue7 = Color(0xFF1498C4);
  static const Color blue8 = Color(0xFF117FA4);
  static const Color blue9 = Color(0xFF0E6684);
  static const Color blue10 = Color(0xFF0B5168);

  // ==================== 9. COMMON BASIC COLORS ====================
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
}
