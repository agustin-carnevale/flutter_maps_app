import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/pages/gps_access_page.dart';
import 'package:maps_app/pages/map_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() { 
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if( state == AppLifecycleState.resumed ){
      // GPS active?
      final gpsActive = await Geolocator.isLocationServiceEnabled();
      if( gpsActive ){
        Navigator.pushReplacement(context,navigateMapFadeIn(context, MapPage()));
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGPSAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData){
            return Center(child: Text(snapshot.data));
          }else{
            return Center(child: CircularProgressIndicator(strokeWidth: 5,));
          }
        },
      ),
   );
  }

  Future checkGPSAndLocation(BuildContext context) async{
    // check for permissions
    final gpsPermissionsGranted = await Permission.location.isGranted;
    // GPS active?
    final gpsActive = await Geolocator.isLocationServiceEnabled();
    
    if (gpsPermissionsGranted && gpsActive){
      Navigator.pushReplacement(context,navigateMapFadeIn(context, MapPage()));
      return '';
    }else if (!gpsPermissionsGranted){
      Navigator.pushReplacement(context,navigateMapFadeIn(context, GPSAccessPage()));
      return 'Es necesario dar permisos de GPS';
    }else {
      return 'Active el GPS';
    }
  }
}