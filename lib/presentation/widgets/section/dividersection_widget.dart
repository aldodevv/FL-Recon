import 'package:flutter/material.dart';
import 'package:recon/core/constants/colors_const.dart';

class DividersectionWidget extends StatelessWidget {
  final double size;
  final EdgeInsetsGeometry? margin;

  const DividersectionWidget({
    super.key,
    this.size = 1.0,
    this.margin,
  });

  Color _resolveColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? MainColors.lightNeutral60 : MainColors.darkNeutral60;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8.0),
      color: _resolveColor(context).withAlpha(40), // tambahkan sedikit transparansi jika perlu
    );
  }
}