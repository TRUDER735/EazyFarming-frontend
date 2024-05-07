import 'package:flutter/material.dart';

class NewField extends StatefulWidget {
  const NewField({super.key});

  @override
  State<NewField> createState() => _NewFieldState();
}

class _NewFieldState extends State<NewField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'New Field',
              style: TextStyle(
                  fontFamily: "Linotype",
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text("Field Name"),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Enter Field name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text("Crop"),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Enter crop',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text("Soil type"),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Soil Type',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextButton(
            onPressed: () {
              // Add sign-in logic here
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.grey[800],
              minimumSize: const Size(double.infinity, 60),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
