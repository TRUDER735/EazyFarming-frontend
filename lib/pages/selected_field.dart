import 'package:crop/components/crop_soil_bar.dart';
import 'package:crop/components/weather_bar.dart';
import 'package:crop/services/fert.dart';
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
                  _showBottomModalSheetFertilizerRecommendation(context,
                      region: _field['area'],
                      soil: _field['soil_type'],
                      crop: _field['current_crop'].toString());
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

Future _showBottomModalSheetFertilizerRecommendation(BuildContext context,
    {required String region, required String soil, required String crop}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) =>
        FertRecommendation(region: region, soil: soil, crop: crop),
  );
}

class FertRecommendation extends StatefulWidget {
  final String region;
  final String soil;
  final String crop;

  const FertRecommendation(
      {super.key,
      required this.region,
      required this.soil,
      required this.crop});

  @override
  State<FertRecommendation> createState() => _FertRecommendationState();
}

class _FertRecommendationState extends State<FertRecommendation> {
  String value = "";
  void getRecommendation() async {
    Fert fert = Fert();
    dynamic response = await fert.fertRec({
      "Region_Name": widget.region,
      "Soil_color": widget.soil,
      "Crop": widget.crop
    });
    print(response);
    // setState(() {
    //   value = response;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            value != ""
                ? const Text(
                    "Based on the current soil conditions, we recommend the following fertilizer for your field",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const Text(
                    "Press Get Recommendations to get fertilizer recommendations for your field based on the soil type and location.",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
            const SizedBox(
              height: 16.0,
            ),
            value != ""
                ? Text(
                    value.toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      getRecommendation();
                    },
                    child: const Text("Get Recommendations")),
                const SizedBox(
                  width: 16.0,
                ),
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
    );
  }
}
