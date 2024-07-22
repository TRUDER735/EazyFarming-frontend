import 'package:crop/pages/home.dart';
import 'package:crop/services/crop.dart';
import 'package:crop/services/field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCrop extends StatefulWidget {
  final dynamic field;

  const AddCrop({super.key, required this.field});

  @override
  State<AddCrop> createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop> {
  final Map<String, int> rainfall = {
    "Region1": 100,
    "Region2": 200,
    "Region3": 300,
    "Region4": 400,
    "Region5": 500,
    "Region6": 600,
  };

  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _cropController = TextEditingController();

  String crop = "Maize";
  String durationUnit = "month";

  final List<DropdownMenuItem<String>> crops = [
    const DropdownMenuItem(value: 'Maize', child: Text('Maize')),
    const DropdownMenuItem(value: 'Millet', child: Text('Millet')),
    const DropdownMenuItem(value: 'Wheat', child: Text('Wheat')),
    const DropdownMenuItem(value: 'Groundnut', child: Text('Groundnuts')),
    const DropdownMenuItem(value: 'Sugarcane', child: Text('Sugarcane')),
    const DropdownMenuItem(value: 'Tobacco', child: Text('Tobacco')),
    const DropdownMenuItem(value: 'Oil seeds', child: Text('Oil seeds')),
    const DropdownMenuItem(value: 'Soyabeans', child: Text('Soybeans')),
  ];

  final List<DropdownMenuItem<String>> durationUnits = [
    const DropdownMenuItem(value: 'month', child: Text('Months')),
    const DropdownMenuItem(value: 'week', child: Text('Weeks')),
  ];

  Future<void> _addCrop(
      String duration, String durationUnit, String crop) async {
    try {
      Field field = Field();
      dynamic body = {
        'duration': duration,
        'duration_unit': durationUnit,
        'name': crop,
      };
      await field.update(body, widget.field['id'].toString());
    } catch (e) {
      print('Failed to add crop: $e');
    }
  }

  Future<String> _getRecommendation() async {
    try {
      Crop crop = Crop();
      dynamic response =
          await crop.recommendation(rainfall[widget.field['area']]!);
      return _capitalize(response["The best crop to cultivate is "].toString());
    } catch (e) {
      print('Failed to get recommendation: $e');
      return "Maize"; // Default value if the recommendation fails
    }
  }

  String _capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(FontAwesomeIcons.arrowLeft),
        ),
        title: const Text(
          'Add crop',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: FutureBuilder<String>(
          future: _getRecommendation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data');
            }

            crop = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                const Text("Crop Name (Default value is the recommended crop)"),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      elevation: 16,
                      iconSize: 24,
                      items: crops,
                      onChanged: (String? value) {
                        setState(() {
                          crop = value!;
                        });
                      },
                      value: crop,
                      hint: const Text('Select Crop'),
                    ),
                  ),
                ),
                const Text("Duration of crop"),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _durationController,
                  decoration: InputDecoration(
                    labelText: 'Crop duration',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text("Duration unit of crop"),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      elevation: 16,
                      iconSize: 24,
                      items: durationUnits,
                      onChanged: (String? value) {
                        setState(() {
                          durationUnit = value!;
                        });
                      },
                      value: durationUnit,
                      hint: const Text('Select duration unit'),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () async {
                    await _addCrop(
                        _durationController.text, durationUnit, crop);
                    _durationController.clear();
                    _cropController.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home()));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(double.infinity, 60),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
