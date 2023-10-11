import 'package:flutter/material.dart';

class PngWidget extends StatelessWidget {
  final String path;
  final double? size;
  final Color? color;
  final bool absolutePath;
  final Color? fillColor;
  final EdgeInsets padding;
  final int? rotationTurns;

  const PngWidget(
    this.path, {
    Key? key,
    this.size,
    this.color,
    this.absolutePath = false,
    this.fillColor,
    this.padding = const EdgeInsets.all(10.0),
    this.rotationTurns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final png = Image.asset(
      '$path.png',
      width: size,
      height: size,
      alignment: Alignment.center,
      fit: BoxFit.contain,
    );

    return Container(
      padding: padding,
      decoration: BoxDecoration(shape: BoxShape.circle, color: fillColor),
      child: rotationTurns != null
          ? RotatedBox(quarterTurns: rotationTurns!, child: png)
          : png,
    );
  }
}
