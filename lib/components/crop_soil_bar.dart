import 'package:crop/services/crop.dart';
import 'package:crop/services/soil.dart';
import 'package:flutter/material.dart';

class CropSoilBar extends StatefulWidget {
  final dynamic field;
  const CropSoilBar({
    super.key,
    required this.field,
  });

  @override
  State<CropSoilBar> createState() => _CropSoilBarState();
}

class _CropSoilBarState extends State<CropSoilBar> {
  Future<dynamic> getSoilStatus() async {
    dynamic response = await Soil().get(); 
    return response;
  }

  Future<dynamic> getCropName() async {
    dynamic response = await Crop().get(widget.field['current_crop']);
    return response['name'];
  }

  @override
  Widget build(BuildContext context) {
    String crop = widget.field['current_crop'];
    return FutureBuilder(
        future: getSoilStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            dynamic soil = snapshot.data;
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crop Stage',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '1 day',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Crop Name: $crop',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Soil Status',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SoilPropertyTile(
                          heading: "Phosphorus",
                          value: double.parse(soil['P']).toStringAsFixed(2)),
                      SoilPropertyTile(
                          heading: "Pottasium",
                          value: double.parse(soil['K']).toStringAsFixed(2)),
                      SoilPropertyTile(
                          heading: "Nitrate",
                          value: double.parse(soil['N']).toStringAsFixed(2)),
                      SoilPropertyTile(
                          heading: "pH",
                          value: double.parse(soil['pH']).toStringAsFixed(2)),
                    ],
                  )
                ],
              ),
            );
          }
        });
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
