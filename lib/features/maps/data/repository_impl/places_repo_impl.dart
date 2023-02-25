// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:maps/core/error/exceptions.dart';

import 'package:maps/core/error/failures.dart';
import 'package:maps/core/network/network_info.dart';
import 'package:maps/features/maps/data/data_source/places_webservices.dart';
import 'package:maps/features/maps/domain/entities/places.dart';
import 'package:maps/features/maps/domain/repository/places_repo.dart';

import '../models/places_model.dart';

// class PlacesRepositoryImpl implements PlacesRepository {
//   final NetworkInfo networkInfo;
//   final PlacesWebservices placesWebservices;
//   PlacesRepositoryImpl({
//     required this.networkInfo,
//     required this.placesWebservices,
//   });

//   @override
//   Future<Either<Failure, List<Places>>> autoCompletePlacesOnSearch(
//       String place, String sessionToken) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final suggestions =
//             await placesWebservices.getSuggestions(place, sessionToken);
//       } on ServerException {
//         return Left(ServerFailure());
//       }
//     }
//   }
// }

class PlacesRepository {
  // final NetworkInfo networkInfo;
  final PlacesWebservices placesWebservices;
  PlacesRepository(
    this.placesWebservices,
  );

  Future<List<dynamic>> getSuggestions(
    String place,
    String sessionToken,
  ) async {
    final suggestions = await placesWebservices.getSuggestions(
      place,
      sessionToken,
    );

    return suggestions
        .map((suggestion) => PlacesSuggestionModel.fromJson(suggestion))
        .toList();
  }
}
