import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Color? color;
  final double? elevation;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color? shadowColor;

  const CustomCard(
      {super.key,
      this.color,
      this.elevation,
      this.shape,
      this.margin,
      this.child,
      this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color,
        elevation: elevation,
        shape: shape,
        margin: margin,
        shadowColor: shadowColor,
        child: child);
  }
}
