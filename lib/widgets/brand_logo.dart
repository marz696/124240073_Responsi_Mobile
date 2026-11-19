import 'package:flutter/material.dart';

import '../config/constants.dart';

/// Logo cincin sederhana "Keripikroll".
class BrandLogo extends StatelessWidget {
  final double size;

  const BrandLogo({super.key, this.size = 72});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kAccent, width: size * 0.14),
      ),
      child: Center(
        child: Container(
          width: size * 0.28,
          height: size * 0.28,
          decoration: const BoxDecoration(color: kAccent, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
