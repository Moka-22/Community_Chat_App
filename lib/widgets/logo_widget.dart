import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../themes/logo.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          logo,
          color: textColor,
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Community Chat',
              style: TextStyle(
                  fontSize: 32,
                  color: textColor,
                  fontFamily: 'pacifico'),
            ),
          ],
        ),
      ],
    );
  }
}
