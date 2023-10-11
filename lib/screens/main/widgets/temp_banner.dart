import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TempBanner extends StatelessWidget {
  const TempBanner({
    super.key,
    required this.temp,
    required this.style,
    required this.width, required this.circleWidth, required this.right, required this.top,
  });

  final String temp;
  final TextStyle style;
  final double width;
  final double circleWidth;
  final double right;
  final double top;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Text(temp, style: style),
        Positioned(
          right: right,
          top: top,
          child: Container(
            height: width,
            width: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: circleWidth),
            ),
          ),
        ),
      ],
    );
  }
}
