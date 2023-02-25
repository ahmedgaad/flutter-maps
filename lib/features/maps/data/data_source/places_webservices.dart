// ignore_for_file: unused_local_variable, avoid_print

import 'package:dio/dio.dart';
import 'package:maps/core/utils/constants_manager.dart';
import 'package:maps/features/maps/data/models/places_model.dart';
import 'package:maps/features/maps/domain/entities/places.dart';

class PlacesWebservices {
  late Dio dio;

  //constructor
  PlacesWebservices() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 20 * 1000),
      receiveTimeout: const Duration(seconds: 20 * 1000),
      receiveDataWhenStatusError: true,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getSuggestions(
    String place,
    String sessionToken,
  ) async {
    try {
      Response response = await dio.get(
        AppConstants.suggestionBaseURL,
        queryParameters: {
          'key': AppConstants.googleAPIKey,
          'input': place,
          'types': 'address',
          'sessiontoken': sessionToken,
          'components': 'country:eg',
        },
      );
      print(response.data['predictions']);
      print(response.statusCode);
      return response.data['predictions'];
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}
