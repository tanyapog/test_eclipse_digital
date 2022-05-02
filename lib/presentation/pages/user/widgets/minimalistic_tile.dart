import 'package:flutter/material.dart';

class MinimalisticTile extends StatelessWidget {
  final IconData leadingIcon;
  final String text;
  final TextStyle? style;

  const MinimalisticTile({
    Key? key,
    required this.leadingIcon,
    required this.text,
    this.style = const TextStyle(fontSize: 13),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(leadingIcon, size: 18, color: Colors.black45,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text, style: style,),
        ),
      ],
    );
  }
}
