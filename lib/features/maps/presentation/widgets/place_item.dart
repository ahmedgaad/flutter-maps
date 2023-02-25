// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:maps/core/utils/color_manager.dart';
import 'package:maps/features/maps/data/models/places_model.dart';

class PlaceItem extends StatelessWidget {
  final PlacesSuggestionModel suggestionModel;
  const PlaceItem({super.key, required this.suggestionModel});

  @override
  Widget build(BuildContext context) {
    var subTitle = suggestionModel.description
        .replaceAll(suggestionModel.description.split(',')[0], '');
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorManager.lightBlue),
              child: const Icon(
                Icons.place,
                color: ColorManager.blue,
              ),
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${suggestionModel.description.split(',')[0]}\n',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: subTitle.substring(2),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0
                    )
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
