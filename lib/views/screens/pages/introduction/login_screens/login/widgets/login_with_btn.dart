import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class LoginWithButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final Function() onTap;
  const LoginWithButton(
      {super.key,
      required this.imagePath,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff8875FF), width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Color.fromARGB(222, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
