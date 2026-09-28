import 'package:flutter/material.dart';
import 'package:to_do_app/core/app_constants/app_colors.dart';

class AppFonts {
  static const black24Bold = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: .bold
  );
  static const secondryTextColor18Bold = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 18,
    fontWeight: .w300
  );
  static const gray16Light = TextStyle(
    color: AppColors.textHint,
    fontSize: 16,
    fontWeight: .w200
  );
    static const gray12Bold = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
    fontWeight: .bold
  );
  static const blue12Bold = TextStyle(
    color: AppColors.primaryBlue,
    fontSize: 12,
    fontWeight: .bold
  );
    static const blue18MediumWithThroughLine = TextStyle(
    color: Color(0x80046AFB),
    fontSize: 18,
    fontWeight: .w500,
    decoration: TextDecoration.lineThrough,
    decorationColor: Color(0x80046AFB)
  );
  static const lightGray12Light = TextStyle(
    fontSize: 12,
    fontWeight: .w300,
    color: AppColors.lightGray
  );
}