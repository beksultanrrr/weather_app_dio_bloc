import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgWidget extends StatelessWidget {
  final String path;
  final double? size;
  final Color? color;
  final bool absolutePath;
  final Color? fillColor;
  final EdgeInsets padding;
  final int? rotationTurns;

  const SvgWidget(
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
    final svg = SvgPicture.asset(
      '$path.svg',
      width: size,
      height: size,
      alignment: Alignment.center,
      fit: BoxFit.contain,
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );

    return Container(
      padding: padding,
      decoration: BoxDecoration(shape: BoxShape.circle, color: fillColor),
      child: rotationTurns != null ? RotatedBox(quarterTurns: rotationTurns!, child: svg) : svg,
    );
  }
}
