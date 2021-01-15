import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _mapController;

  Polyline _myRoute = Polyline(
    polylineId: PolylineId('mi_ruta'),
    color: Colors.red[300],
    width: 5,
  );

  void initMap(GoogleMapController controller){
    if(!state.mapIsReady){
      this._mapController = controller;
      this._mapController.setMapStyle(json.encode(uberMapTheme));

      add(OnMapReady());
    }
  }

  void moveCamera(LatLng destination){
    final cameraUpdate = CameraUpdate.newLatLng(destination);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if(event is OnMapReady){
      print('Map is READY!!');
      yield state.copyWith(mapIsReady: true);
    } else if (event is OnLocationChanged){
      yield* _onLocationChanged(event);
    }else if (event is OnShowRoute){
      yield* _onShowRoute(event);
    }else if (event is OnCameraFollowMe){
      yield* _onCameraFollowMe(event);
    }else if (event is OnMapFocusMoved){
      // print('MAP CENTRAL POSITION: ${event.location}');
      yield* _onMapFocusMoved(event);
    }
  }

  Stream<MapState> _onLocationChanged(OnLocationChanged event) async*{
    final List<LatLng> points = [...this._myRoute.points, event.location];
    this._myRoute = this._myRoute.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._myRoute;

    if(state.cameraFollowMe){
      this.moveCamera(event.location);
    }

    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapState> _onShowRoute(OnShowRoute event) async*{
    if(!state.drawRoute){
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.red[300]);
    } else {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._myRoute;

    yield state.copyWith(
      drawRoute: !state.drawRoute,
      polylines: currentPolylines
    );
  }

  Stream<MapState> _onCameraFollowMe(OnCameraFollowMe event) async*{
    if(!state.cameraFollowMe){
      this.moveCamera(this._myRoute.points.last);
    }
    yield state.copyWith(cameraFollowMe: !state.cameraFollowMe);
  }

  Stream<MapState> _onMapFocusMoved(OnMapFocusMoved event) async*{
    yield state.copyWith(mapCentralPosition: event.location);
  }
}
