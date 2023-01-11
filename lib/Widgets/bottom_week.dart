import 'package:flutter/material.dart';

class BottomWeek extends StatelessWidget {
  final List<Widget> child;

  const BottomWeek({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 60,
      width: size.width,
      color: Colors.red,
      child: Column(
        children: child,
      ),
    );
  }
}

