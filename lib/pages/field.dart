import 'package:crop/components/field_list_tile.dart';
import 'package:crop/pages/new_field.dart';
import 'package:crop/pages/selected_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Field extends StatefulWidget {
  const Field({super.key});

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewFieldBottomSheet(context),
        child: const Icon(FontAwesomeIcons.plus),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(FontAwesomeIcons.arrowLeft),
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
            FieldListTile(
                onPressed: () => _showFieldBottomSheet(context),
                fieldName: 'Field 1',
                fieldType: 'Maize',
                date: '24 April'),
          ],
        ),
      )),
    );
  }
}

Future _showNewFieldBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context, builder: (context) => const NewField());
}

Future _showFieldBottomSheet(BuildContext context) {
  return showModalBottomSheet<dynamic>(
      context: context,
      builder: (context) => const SelectedField(),
      isScrollControlled: true);
}
