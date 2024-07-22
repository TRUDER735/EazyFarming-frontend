import 'package:crop/components/field_map.dart';
import 'package:crop/pages/add_crop.dart';
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
      'soil_type': soilType,
      'owner': Provider.of<UserProvider>(context, listen: false).id.toString(),
      // 'location': _selectedLocation.toString(),
    };
    dynamic response = await field.create(body);
    if (response != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AddCrop(
                    field: response,
                  )));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create field'),
        ),
      );
    }
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
            const Text("Select Region"),
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
            _selectedLocation == null
                ? const Text("Select Location on Map")
                : const Text("Location Selected"),
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
