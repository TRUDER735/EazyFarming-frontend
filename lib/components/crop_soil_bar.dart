import 'package:flutter/material.dart';

class CropSoilBar extends StatefulWidget {
  const CropSoilBar({super.key});

  @override
  State<CropSoilBar> createState() => _CropSoilBarState();
}

class _CropSoilBarState extends State<CropSoilBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 221, 221, 221),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expected Crop Stage',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '33',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Soil Status',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SoilPropertyTile(heading: "Phosphorus", value: "0%"),
              SoilPropertyTile(heading: "Pottasium", value: "0%",),
              SoilPropertyTile(heading: "Nitrate", value: "0%"),
              SoilPropertyTile(heading: "Humidity", value: "0%"),
            ],
          )
        ],
      ),
    );
  }
}

class SoilPropertyTile extends StatelessWidget {
  final String heading;
  final String value;

  const SoilPropertyTile({
    super.key,
    required this.heading,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(heading),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
