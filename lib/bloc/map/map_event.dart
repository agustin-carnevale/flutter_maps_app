part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapReady extends MapEvent {}

class OnShowRoute extends MapEvent {}

class OnCameraFollowMe extends MapEvent {}

class OnLocationChanged extends MapEvent {
  final LatLng location;

  OnLocationChanged(this.location);
}

class OnMapFocusMoved extends MapEvent {
  final LatLng location;

  OnMapFocusMoved(this.location);
}
