import 'package:flutter/material.dart';
class AppColors {
  AppColors._();
  static const Color primary = Color(0xFF0A1628);
  static const Color primaryLight = Color(0xFF0F223A);
  static const Color accent = Color(0xFF1DD1A1);
  static const Color accentDark = Color(0xFF10AC84);
  static const Color gold = Color(0xFFFFB800);
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFF0F1D2E);
  static const Color cardBg = Color(0xFF0D1B2A);
  static const Color cardBorder = Color(0xFF1B2A3D);
  static const Color textColor = Colors.black;
  static const Color textPrimary = Color(0xFFEAF2FF);
  static const Color textSecondary = Color(0xFF9FB3C8);
  static const Color textHint = Color(0xFF6B7C93);
  static const Color success = Color(0xFF1DD1A1);
  static const Color warning = Color(0xFFFFA502);
  static const Color error = Color(0xFFFF4757);
  static const Color info = Color(0xFF4ECDC4);
  static const Color lowRisk = Color(0xFF1DD1A1);
  static const Color lowRiskBg = Color(0xFF1DD1A120);
  static const Color mediumRisk = Color(0xFFFFA502);
  static const Color mediumRiskBg = Color(0xFFFFA50220);
  static const Color highRisk = Color(0xFFFF4757);
  static const Color highRiskBg = Color(0xFFFF475720);
  static const Color open = Color(0xFF1DD1A1);
  static const Color openBg = Color(0xFF1DD1A120);
  static const Color closed = Color(0xFF7F8C8D);
  static const Color closedBg = Color(0xFF7F8C8D20);
  static const Color divider = Color(0xFF1E3048);
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0F223A),
      Color(0xFF080E1A),
    ],
  );
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF1DD1A1),
      Color(0xFF10AC84),
    ],
  );
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0D1B2A), 
      Color(0xFF1B2A3D), 
    ],
  );
}