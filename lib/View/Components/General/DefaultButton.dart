import 'package:flutter/material.dart';

// ------------ DEFAULT BUTTON COMPONENT ------------ //
class DefaultButton extends StatelessWidget {
  const DefaultButton({required this.tap, required this.icon});

  final VoidCallback tap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 40,
        height: 40,
        child: Center(child: GestureDetector(onTap: tap, child: icon)));
  }
}
