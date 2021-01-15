import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/bloc/map/map_bloc.dart';
import 'package:maps_app/bloc/my_location/my_location_bloc.dart';
import 'package:maps_app/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    context.read<MyLocationBloc>().initLocalization();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MyLocationBloc>().cancelLocalization();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<MyLocationBloc, MyLocationState>(
          builder: (_, state) => _buildMap(state),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnLocation(),
          BtnFollowLocation(),
          BtnShowRoute(),
        ],
      ),
    );
  }

  Widget _buildMap(MyLocationState state){
    final locationAvailable = state.locationAvailable;
    final location = state.location;
    if (!locationAvailable){
      return Text('No esta disponible la ubicacion');
    }

    final initialCameraPosition = CameraPosition(
      target: location,
      zoom: 16
    );
    final mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.add(OnLocationChanged(location));

    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: mapBloc.initMap,
      polylines: mapBloc.state.polylines.values.toSet(),
      onCameraMove: (cameraPosition){
        //cameraPosition target = LatLng central del map
        mapBloc.add(OnMapFocusMoved(cameraPosition.target));
      },
      // onCameraIdle: (){}, -> al soltar el mapa
    );
  }
}
