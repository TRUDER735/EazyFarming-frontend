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
    return SafeArea(
        child: Column(
      children: [
        const ListTile(
          leading: Icon(FontAwesomeIcons.arrowLeft),
          title: Center(
            child: Text(
              'My Crop : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          trailing: Icon(FontAwesomeIcons.bell),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 221, 221, 221),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Weather',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 10.0,),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: Icon(FontAwesomeIcons.cloud)),
                        Expanded(child: Text('33',style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),),)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [Text('Precipitation'), Text('0mm')],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [Text('Wind'), Text('2m/s')],
                  ))
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
