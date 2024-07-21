import 'package:crop/services/crop.dart';
import 'package:crop/services/field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCrop extends StatefulWidget {
  const AddCrop({super.key});
  @override
  State<AddCrop> createState() => _AddCrop();
}

class _AddCrop extends State<AddCrop> {
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _cropController = TextEditingController();

  String crop = "Maize";
  String duration = "";
  String durationUnit = "Months";

  List<DropdownMenuItem<String>> crops = [
    const DropdownMenuItem(
      value: 'Maize',
      child: Text('Maize'),
    ),
    const DropdownMenuItem(
      value: 'Millet',
      child: Text('Millet'),
    ),
    const DropdownMenuItem(
      value: 'Wheat',
      child: Text('Wheat'),
    ),
    const DropdownMenuItem(
      value: 'Groundnuts',
      child: Text('Groundnuts'),
    ),
    const DropdownMenuItem(
      value: 'Sugarcane',
      child: Text('Sugarcane'),
    ),
    const DropdownMenuItem(
      value: 'Tobacco',
      child: Text('Tobacco'),
    ),
    const DropdownMenuItem(
      value: 'Oil seeds',
      child: Text('Oil seeds'),
    ),
    const DropdownMenuItem(
      value: 'Soyabean',
      child: Text('Soybeans'),
    ),
  ];

  List<DropdownMenuItem<String>> durationUnits = [
    const DropdownMenuItem(
      value: 'Months',
      child: Text('Months'),
    ),
    const DropdownMenuItem(
      value: 'Weeks',
      child: Text('Weeks'),
    ),
  ];

  _addCrop(String duration,String durationUnit ,String crop) async {
    Field field = Field();
    dynamic body = {
      'duration': duration,
     'durationUnit': durationUnit,
      'crop': crop,
    };
    dynamic response = await field.create(body);
    return response;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomModalSheetCropRecommendation(context),
        child: const Icon(FontAwesomeIcons.lightbulb),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            const Text("Crop Name"),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    isExpanded: true,
                    elevation: 16,
                    iconSize: 24,
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    items: crops,
                    onChanged: (
                      String? value,
                    ) {
                      setState(() {
                        crop = value!;
                      });
                    },
                    value: crop,
                    hint: const Text('Select Soil Type')),
              ),
            ),
            const Text("Duration of crop"),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                  labelText: 'Crop duration',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text("Crop"),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _cropController,
              decoration: InputDecoration(
                  labelText: 'Enter crop',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text("Duration unit of crop"),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    isExpanded: true,
                    elevation: 16,
                    iconSize: 24,
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    items: durationUnits,
                    onChanged: (
                      String? value,
                    ) {
                      setState(() {
                        durationUnit = value!;
                      });
                    },
                    value: durationUnit,
                    hint: const Text('Select duration unit')),
              ),
            ),
            const SizedBox(height: 16.0,),
            TextButton(
              onPressed: () {
                _addCrop(duration, durationUnit, crop);
                _durationController.clear();
                _cropController.clear();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey[800],
                minimumSize: const Size(double.infinity, 60),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}

Future _showBottomModalSheetCropRecommendation(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => const RecommendationContent(),
  );
}

class RecommendationContent extends StatefulWidget {
  const RecommendationContent({
    super.key,
  });

  @override
  State<RecommendationContent> createState() => _RecommendationContentState();
}

class _RecommendationContentState extends State<RecommendationContent> {
  String value = "";
  void getRecommendation() async {
    Crop crop = Crop();
    dynamic response = await crop.recommendation();
    setState(() {
      value = response["The best crop to cultivate is "];
    });
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
            value == ""
                ? const Text(
                    "Press Get Recommendations to get crop recommendations for your field based on the soil type and location.",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const Text(
                    "Recommended Crop based on soil type and location: "),
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
                  child: const Text("Get Recommendations"),
                ),
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

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
