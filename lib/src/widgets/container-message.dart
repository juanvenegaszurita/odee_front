// ignore: file_names
import 'package:flutter/material.dart';

class ContainerMessage extends StatelessWidget {
  const ContainerMessage(
      {super.key,
      required this.icon,
      required this.message,
      required this.height});

  final Icon icon;
  final String message;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        /* color: const Color.fromARGB(255, 184, 207, 255), */
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      height: height,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
