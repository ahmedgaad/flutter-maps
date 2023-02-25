// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps/features/maps/data/repository_impl/places_repo_impl.dart';
import 'package:maps/features/maps/presentation/cubit/map_states.dart';

class MapCubit extends Cubit<MapStates> {
  MapCubit(
    this.placesRepository,
  ) : super(MapInitial());
  final PlacesRepository placesRepository;

  static MapCubit get(context) => BlocProvider.of(context);
  void showPlacesSuggestions(
    String place,
    String sessionToken,
  ) {
    placesRepository.getSuggestions(place, sessionToken).then((suggestion) {
      emit(AutoCompletePlacesSuccessfullyState(suggestion));
    }).catchError((error) {
      emit(AutoCompletePlacesErrorState(error));
    });
  }
}
