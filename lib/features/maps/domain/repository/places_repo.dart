import 'package:dartz/dartz.dart';
import 'package:maps/core/error/failures.dart';
import 'package:maps/features/maps/domain/entities/places.dart';

abstract class PlacesRepository {
  Future<Either<Failure, List<Places>>> autoCompletePlacesOnSearch(
    String place,
    String sessionToken,
  );
}
