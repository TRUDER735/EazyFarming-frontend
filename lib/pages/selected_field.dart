import 'package:crop/components/crop_soil_bar.dart';
import 'package:crop/components/weather_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectedField extends StatefulWidget {
  final dynamic field;
  const SelectedField({super.key, required this.field});

  @override
  State<SelectedField> createState() => _SelectedFieldState();
}

class _SelectedFieldState extends State<SelectedField> {
  dynamic _field;

  @override
  void initState() {
    super.initState();
    _field = widget.field;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Center(child: Text("Farm: ${_field['name'].toString()}")),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WeatherBar(),
              const SizedBox(
                height: 20.0,
              ),
              const CropSoilBar(),
              Expanded(child: Container()),
              TextButton(
                onPressed: () {
                  _showBottomModalSheetFertilizerRecommendation(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey[800],
                  minimumSize: const Size(double.infinity, 60),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                child: const Text('Get Fertilizer Recommendation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future _showBottomModalSheetFertilizerRecommendation(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Crop Recommendation",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              "Based on the current soil conditions, we recommend the following fertilizer for your field",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              "DAP for wheat",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
