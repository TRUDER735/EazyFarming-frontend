import 'package:crop/services/soil.dart';
import 'package:flutter/material.dart';

class CropSoilBar extends StatefulWidget {
  const CropSoilBar({super.key});

  @override
  State<CropSoilBar> createState() => _CropSoilBarState();
}

class _CropSoilBarState extends State<CropSoilBar> {
  Future<dynamic> getSoilStatus() async {
    dynamic response = await Soil().get();
    return response;
  }

  @override
  Widget build(BuildContext context) {
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
                    'Expected Crop Stage',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Row(
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
                      SoilPropertyTile(heading: "Phosphorus", value: soil['P']),
                      SoilPropertyTile(heading: "Pottasium", value: soil['K']),
                      SoilPropertyTile(heading: "Nitrate", value: soil['N']),
                      SoilPropertyTile(heading: "pH", value: double.parse(soil['pH']).toStringAsFixed(2)),
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
