import 'package:flutter/material.dart';

class MainButtons extends StatelessWidget {
  final String name;
  final Function buttonPressed;
  const MainButtons(
      {super.key, required this.name, required this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        buttonPressed(name);
      },
      child: Container(
        color: Colors.transparent,
        height: double.infinity,
        width: double.infinity,
        child: Center(
            child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w600),
                ))),
      ),
    );
  }
}
