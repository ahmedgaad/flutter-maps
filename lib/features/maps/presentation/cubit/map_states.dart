abstract class MapStates {}

class MapInitial extends MapStates {}

class AutoCompletePlacesSuccessfullyState extends MapStates {
  final List<dynamic> places;
  AutoCompletePlacesSuccessfullyState(this.places);
}

class AutoCompletePlacesErrorState extends MapStates {
  final String error;
  AutoCompletePlacesErrorState(this.error);
}
