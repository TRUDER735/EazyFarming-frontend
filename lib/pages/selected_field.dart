import 'package:crop/components/crop_soil_bar.dart';
import 'package:crop/components/weather_bar.dart';
import 'package:flutter/material.dart';

class SelectedField extends StatefulWidget {
  const SelectedField({super.key});

  @override
  State<SelectedField> createState() => _SelectedFieldState();
}

class _SelectedFieldState extends State<SelectedField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Field Name",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const WeatherBar(),
            const SizedBox(
              height: 20.0,
            ),
            const CropSoilBar(),
            const SizedBox(
              height: 20.0,
            ),
            TextButton(
              onPressed: () {
                // Add sign-in logic here
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey[800],
                minimumSize: const Size(double.infinity, 60),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
              child: const Text('Recommended Fertilizer'),
            ),
          ],
        ),
    );
  }
}
