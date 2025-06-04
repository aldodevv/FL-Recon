import 'package:flutter/material.dart';

class ItemtermsWidget extends StatelessWidget {
  final String alfabet;
  final String title;

  const ItemtermsWidget({super.key, required this.alfabet, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$alfabet. ', style: const TextStyle(fontSize: 14)),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}