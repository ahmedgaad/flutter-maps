
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/features/maps/presentation/cubit/map_states.dart';


class MapCubit extends Cubit<MapStates> {
  MapCubit() : super(MapInitial());
}
