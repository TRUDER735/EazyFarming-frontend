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
              Column(
                children: [
                  Text('Phosphorus'),
                  Text(
                    '0mm',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(width: 8.0),
              Column(
                children: [
                  Text('Pottasium'),
                  Text(
                    '0mm',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(width: 8.0),
              Column(
                children: [
                  Text('Nitrate'),
                  Text(
                    '0mm',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(width: 8.0),
              Column(
                children: [
                  Text('Humidity'),
                  Text(
                    '2m/s',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
