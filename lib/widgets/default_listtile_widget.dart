import 'package:flutter/material.dart';

class DefaultListTileWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget icon;

  const DefaultListTileWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black87),
      ),
      onTap: onTap,
    );
  }
}
