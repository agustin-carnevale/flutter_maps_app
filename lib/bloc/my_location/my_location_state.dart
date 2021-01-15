part of 'my_location_bloc.dart';

@immutable
class MyLocationState {

  final bool following;
  final bool locationAvailable;
  final LatLng location;

  MyLocationState({
    this.following = true, 
    this.locationAvailable = false, 
    this.location
  });

  MyLocationState copyWith({
    bool following,
    bool locationAvailable,
    LatLng location,
  }) => MyLocationState(
    following: following ?? this.following,
    locationAvailable: locationAvailable ?? this.locationAvailable,
    location: location ?? this.location
  );
}

