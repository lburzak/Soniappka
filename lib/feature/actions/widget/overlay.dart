import 'package:flutter/material.dart';

class Overlay extends StatelessWidget {
  const Overlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints.expand(),
          color: Colors.white70,
          child: Container(
            child: const Icon(
              Icons.done,
              size: 60,
              color: Colors.green,
            ),
          )),
    );
  }
}
