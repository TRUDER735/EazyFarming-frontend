import 'package:flutter/material.dart';

class FieldListTile extends StatelessWidget {
  const FieldListTile(
      {super.key,
      required this.fieldName,
      required this.fieldType,
      required this.date,
      required this.onPressed,
      });

  final String fieldName;
  final String fieldType;
  final String date;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(color: Colors.green[50], boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 221, 221, 221),
                blurRadius: 5.0,
                spreadRadius: 2.0,
                offset: Offset(0, 2))
          ]),
          padding: const EdgeInsets.all(10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fieldName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        fieldType,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(date, style: const TextStyle(fontSize: 16.0)),
              ]),
        ));
  }
}
