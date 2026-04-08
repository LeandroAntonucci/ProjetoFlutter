import 'package:flutter/material.dart';

class AppTextStyles {
  // =========================
  // 🅰️ H1 – Título principal
  // =========================
  static const h1 = TextStyle(
    fontFamily: 'MontserratAlternates',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // =========================
  // 🅰️ H2 – Seções
  // =========================
  static const h2 = TextStyle(
    fontFamily: 'MontserratAlternates',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  // =========================
  // 🅰️ H3 – Sub-seções
  // =========================
  static const h3 = TextStyle(
    fontFamily: 'MontserratAlternates',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // =========================
  // 📄 Texto padrão
  // =========================
  static const body = TextStyle(
    fontFamily: 'MontserratAlternates',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  // =========================
  // 📄 Texto auxiliar
  // =========================
  static const helper = TextStyle(
    fontFamily: 'MontserratAlternates',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  // =========================
  // 🔘 Botões
  // =========================
  static const button = TextStyle(
    fontFamily: 'MontserratAlternates',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // =========================
  // 🧾 Inputs
  // =========================
  static const inputText = TextStyle(
    fontFamily: 'MontserratAlternates',
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const inputPlaceholder = TextStyle(
    fontFamily: 'MontserratAlternates',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}