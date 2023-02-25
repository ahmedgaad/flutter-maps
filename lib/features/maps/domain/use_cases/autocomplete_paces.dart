import 'package:dartz/dartz.dart';
import 'package:maps/core/error/failures.dart';
import 'package:maps/features/maps/domain/entities/places.dart';
import 'package:maps/features/maps/domain/repository/places_repo.dart';

class AutoCompletePlacesUsecase {
  final PlacesRepository autoCompletePlacesRepo;

  AutoCompletePlacesUsecase(this.autoCompletePlacesRepo);

  
  Future<Either<Failure, List<Places>>> call(
    String place,
    String sessionToken,
  ) async {
    return await autoCompletePlacesRepo.autoCompletePlacesOnSearch(
      place,
      sessionToken,
    );
  }
}
