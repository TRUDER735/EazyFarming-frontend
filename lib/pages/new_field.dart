import 'package:crop/components/field_map.dart';
import 'package:crop/services/crop.dart';
import 'package:crop/services/field.dart';
import 'package:crop/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class NewField extends StatefulWidget {
  const NewField({super.key});
  @override
  State<NewField> createState() => _NewFieldState();
}

class _NewFieldState extends State<NewField> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cropController = TextEditingController();

  String soilType = "Black";
  LatLng? _selectedLocation;
  String region = "Region1";

  List<DropdownMenuItem<String>> regions = [
    const DropdownMenuItem(
      value: 'Region1',
      child: Text('Region 1'),
    ),
    const DropdownMenuItem(
      value: 'Region2',
      child: Text('Region 2'),
    ),
    const DropdownMenuItem(
      value: 'Region3',
      child: Text('Region 3'),
    ),
    const DropdownMenuItem(
      value: 'Region4',
      child: Text('Region 4'),
    ),
    const DropdownMenuItem(
      value: 'Region5',
      child: Text('Region 5'),
    ),
  ];

  List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem(
      value: 'Black',
      child: Text('Black'),
    ),
    const DropdownMenuItem(
      value: 'LightBrown',
      child: Text('Light brown'),
    ),
    const DropdownMenuItem(
      value: 'ReddishBrown',
      child: Text('Reddish brown'),
    ),
    const DropdownMenuItem(
      value: 'Red',
      child: Text('Red'),
    ),
    const DropdownMenuItem(
      value: 'DarkBrown',
      child: Text('Dark brown'),
    ),
  ];

  _createField(String name, String crop) async {
    Field field = Field();
    dynamic body = {
      'name': name,
      'area': region,
      'crop': crop,
      'soil_type': soilType,
      'owner': Provider.of<UserProvider>(context, listen: false).id.toString(),
      // 'location': _selectedLocation.toString(),
    };
    dynamic response = await field.create(body);
    return response;
  }

  void selectLocation(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
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
          'New Field',
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
            const Text("Field Name"),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Enter Field name',
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
            const Text("Soil type"),
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
                    items: items,
                    onChanged: (
                      String? value,
                    ) {
                      setState(() {
                        soilType = value!;
                      });
                    },
                    value: soilType,
                    hint: const Text('Select Soil Type')),
              ),
            ),
            const SizedBox(
              height: 16.0,
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
                    items: regions,
                    onChanged: (
                      String? value,
                    ) {
                      setState(() {
                        region = value!;
                      });
                    },
                    value: region,
                    hint: const Text('Select Region')),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text("Selected Location: $_selectedLocation"),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: FieldMap(
                selectLocation: selectLocation,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextButton(
              onPressed: () {
                _createField(_nameController.text, _cropController.text);
                _nameController.clear();
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
