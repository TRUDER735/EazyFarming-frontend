import 'package:crop/components/crop_soil_bar.dart';
import 'package:crop/components/weather_bar.dart';
import 'package:crop/pages/add_crop.dart';
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
          },
        ),
        title: Center(child: Text("Farm: ${_field['name'].toString()}")),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WeatherBar(),
              const SizedBox(height: 20.0),
              _field['current_crop'] == null
                  ? TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCrop(field: _field),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey[800],
                        minimumSize: const Size(double.infinity, 60),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: const Text('Add crop'),
                    )
                  : CropSoilBar(field: _field),
              const Spacer(),
              if (_field['crop'] == null)
                TextButton(
                  onPressed: () {
                    _showFertilizerRecommendationModal(context,
                        region: _field['area'],
                        soil: _field['soil_type'],
                        crop: _field['current_crop'].toString());
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(double.infinity, 60),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: const Text('Get Fertilizer Recommendation'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showFertilizerRecommendationModal(BuildContext context,
      {required String region, required String soil, required String crop}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) =>
          FertRecommendation(region: region, soil: soil, crop: crop),
    );
  }
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
  bool isLoading = false;

  Future<void> _getRecommendation() async {
    setState(() {
      isLoading = true;
    });
    try {
      Fert fert = Fert();
      dynamic response = await fert.fertRec({
        "Region_Name": widget.region,
        "Soil_color": widget.soil,
        "Crop": widget.crop,
      });
      setState(() {
        value = response["The best fertilizer to use is"];
      });
    } catch (e) {
      setState(() {
        value = "Error getting recommendation.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Fertiliser Recommendation",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 16.0),
            value.isNotEmpty
                ? const Text(
                    "Based on the current soil conditions, we recommend the following fertilizer for your field:",
                    style: TextStyle(fontSize: 16.0),
                  )
                : const Text(
                    "Press Get Recommendations to get fertilizer recommendations for your field based on the soil type and location.",
                    style: TextStyle(fontSize: 16.0),
                  ),
            const SizedBox(height: 16.0),
            value.isNotEmpty
                ? Text(
                    value,
                    style: const TextStyle(fontSize: 16.0),
                  )
                : const SizedBox(),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isLoading)
                  TextButton(
                    onPressed: _getRecommendation,
                    child: const Text("Get Recommendations"),
                  ),
                if (isLoading) const CircularProgressIndicator(),
                const SizedBox(width: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
