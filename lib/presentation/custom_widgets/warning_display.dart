import 'package:flutter/material.dart';

class WarningDisplay extends StatelessWidget {
  final String message;

  const WarningDisplay({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(message, style: const TextStyle(
          color: Colors.black54),),
      ),
    );
  }
}
