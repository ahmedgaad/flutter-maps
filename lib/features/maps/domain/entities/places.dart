// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Places extends Equatable {
  final String description;
  final String placeId;

  const Places({
    required this.description,
    required this.placeId,
  });

  @override
  List<Object?> get props => [
        description,
        placeId,
      ];
}
