import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NeonchikAnswer extends StatelessWidget {
  const NeonchikAnswer({
    required this.answer,
    required this.width,
    required this.onPressed,
    super.key,
  });

  final String answer;

  final double width;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            answer,
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
          SvgPicture.asset(
            'assets/svg/neonchik.svg',
            width: width,
          ),
        ],
      ),
    );
  }
}
