import 'package:flutter/material.dart';

class CropRecommendation extends StatefulWidget {
  const CropRecommendation({super.key});

  @override
  State<CropRecommendation> createState() => _CropRecommendationState();
}

class _CropRecommendationState extends State<CropRecommendation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:const  EdgeInsets.all(10.0),
          decoration:const  BoxDecoration(
            color: Color.fromRGBO(204, 0, 0, 100),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: const Column(
            children: [
              Text('Current Location :', style: TextStyle(
                color: Colors.white,
                fontFamily: 'Linotype'
              ),),
              Text('Mashonaland East', style: TextStyle(
                color: Colors.white,
                fontSize: 16.0
              ),)
            ],
          ),
        )
      ],
    );
  }
}