import 'dart:async';

import 'package:collection/collection.dart';
import 'package:crop/components/field_list_tile.dart';
import 'package:crop/pages/new_field.dart';
import 'package:crop/pages/selected_field.dart';
import 'package:crop/services/field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FieldPage extends StatefulWidget {
  final String id;
  const FieldPage({super.key, required this.id});

  @override
  State<FieldPage> createState() => _FieldState();
}

class _FieldState extends State<FieldPage> {
  List data = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer to refresh the data every 1 second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _refreshData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  final StreamController<List<dynamic>> _streamController =
      StreamController<List<dynamic>>.broadcast();

  Future<List> _getFields() async {
    print(widget.id);
    Field field = Field();
    dynamic data = await field.get(widget.id);
    return data;
  }

  Future<void> _refreshData() async {
    final newData = await _getFields();
    Function deepEq = const DeepCollectionEquality().equals;
    if (!deepEq(newData, data)) {
      setState(() {
        data = newData;
      });
      _streamController.add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewField(context),
        child: const Icon(FontAwesomeIcons.plus),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const ListTile(
              title: Center(
                child: Text(
                  'My Fields : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              trailing: Icon(FontAwesomeIcons.bell),
            ),
            const SizedBox(
              height: 20.0,
            ),
            StreamBuilder<Object>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<dynamic> fields = snapshot.data as List<dynamic>;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: fields.length,
                      itemBuilder: (context, index) {
                        dynamic field = fields[index];
                        return Column(
                          children: [
                            FieldListTile(
                                onPressed: () => _showField(context, field),
                                fieldName: field['name'],
                                fieldType: field['id'].toString(),
                                date: field['name']),
                            const SizedBox(height: 16.0),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

Future _showNewField(BuildContext context) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => const NewField()));
}

Future _showField(BuildContext context, dynamic field) {
  return Navigator.push(context,
      MaterialPageRoute(builder: (context) => SelectedField(field: field)));
}
