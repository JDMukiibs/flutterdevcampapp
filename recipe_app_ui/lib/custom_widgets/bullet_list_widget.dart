import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  final List<String> strings;
  final int colorIndex;

  const BulletList({
    super.key,
    required this.strings,
    required this.colorIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  str,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6),
                    height: 1.55,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
