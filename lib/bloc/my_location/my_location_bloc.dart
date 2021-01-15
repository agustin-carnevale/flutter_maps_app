import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:geolocator/geolocator.dart' as gl;
import 'package:meta/meta.dart';

part 'my_location_event.dart';
part 'my_location_state.dart';

class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {
  MyLocationBloc() : super(MyLocationState());

  //GeoLocator
  StreamSubscription<gl.Position> _positionSubscription;

  void initLocalization(){
    _positionSubscription = gl.Geolocator.getPositionStream( 
      desiredAccuracy: gl.LocationAccuracy.high,
      distanceFilter: 10
    ).listen((gl.Position position) {
      print(position);
      final location = LatLng(position.latitude, position.longitude);
      add(OnLocationChange(location));
    });
  }

  void cancelLocalization(){
    _positionSubscription?.cancel();
  }

  @override
  Stream<MyLocationState> mapEventToState(
    MyLocationEvent event,
  ) async* {
    
    if (event is OnLocationChange){
      yield state.copyWith(
        locationAvailable: true,
        location: event.location
      );
    }
  }
}
