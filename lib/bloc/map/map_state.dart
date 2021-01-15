part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapIsReady;
  final bool drawRoute;
  final bool cameraFollowMe;
  final LatLng mapCentralPosition;

  //Polylines
  final Map<String, Polyline> polylines;

  MapState({
    this.mapIsReady = false,
    this.drawRoute = true,
    this.cameraFollowMe = false,
    this.mapCentralPosition,
    Map<String, Polyline> polylines
  }) : this.polylines = polylines ?? Map();

  MapState copyWith({
    bool mapIsReady,
    bool drawRoute,
    bool cameraFollowMe,
    LatLng mapCentralPosition,
    Map<String, Polyline> polylines
  }) => MapState(
    mapIsReady: mapIsReady ?? this.mapIsReady,
    polylines: polylines ?? this.polylines,
    mapCentralPosition: mapCentralPosition ?? this.mapCentralPosition,
    drawRoute: drawRoute ?? this.drawRoute,
    cameraFollowMe: cameraFollowMe ?? this.cameraFollowMe
  );
}
