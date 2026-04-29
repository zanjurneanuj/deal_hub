import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // =========================
  // 🎯 PRIMARY PALETTE
  // =========================
  static const Color primary = Color(0xFF0A1628);
  static const Color primaryLight = Color(0xFF0F223A);

  //  Improved Accent (more vibrant)
  static const Color accent = Color(0xFF1DD1A1);
  static const Color accentDark = Color(0xFF10AC84);

  static const Color gold = Color(0xFFFFB800);

  // =========================
  // 🎯 BACKGROUND
  // =========================
  //  Light background for contrast (important)
  static const Color background = Color(0xFFF5F7FA);

  static const Color surface = Color(0xFF0F1D2E);

  //  Rich card base
  static const Color cardBg = Color(0xFF0D1B2A);
  static const Color cardBorder = Color(0xFF1B2A3D);

  // =========================
  // 🎯 TEXT COLORS
  // =========================
  static const Color textColor = Colors.black;

  //  Softer white (better UX)
  static const Color textPrimary = Color(0xFFEAF2FF);

  //  More readable secondary text
  static const Color textSecondary = Color(0xFF9FB3C8);

  static const Color textHint = Color(0xFF6B7C93);

  // =========================
  // 🎯 STATUS COLORS
  // =========================
  static const Color success = Color(0xFF1DD1A1);
  static const Color warning = Color(0xFFFFA502);
  static const Color error = Color(0xFFFF4757);
  static const Color info = Color(0xFF4ECDC4);

  // =========================
  // 🎯 RISK COLORS (IMPROVED)
  // =========================
  static const Color lowRisk = Color(0xFF1DD1A1);
  static const Color lowRiskBg = Color(0xFF1DD1A120);

  static const Color mediumRisk = Color(0xFFFFA502);
  static const Color mediumRiskBg = Color(0xFFFFA50220);

  static const Color highRisk = Color(0xFFFF4757);
  static const Color highRiskBg = Color(0xFFFF475720);

  // =========================
  // 🎯 DEAL STATUS
  // =========================
  static const Color open = Color(0xFF1DD1A1);
  static const Color openBg = Color(0xFF1DD1A120);

  static const Color closed = Color(0xFF7F8C8D);
  static const Color closedBg = Color(0xFF7F8C8D20);

  // =========================
  // 🎯 DIVIDER
  // =========================
  static const Color divider = Color(0xFF1E3048);

  // =========================
  // 🎯 GRADIENTS (KEY PART)
  // =========================

  //  Background gradient (optional)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0F223A),
      Color(0xFF080E1A),
    ],
  );

  //  Button / CTA gradient
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF1DD1A1),
      Color(0xFF10AC84),
    ],
  );

  //  FINAL CARD GRADIENT (matches your screenshot)
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0D1B2A), // deep navy
      Color(0xFF1B2A3D), // slightly lighter
    ],
  );
}