import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GPSAccessPage extends StatefulWidget {

  @override
  _GPSAccessPageState createState() => _GPSAccessPageState();
}

class _GPSAccessPageState extends State<GPSAccessPage> with WidgetsBindingObserver {
  bool _popup = false;

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
    if( state == AppLifecycleState.resumed && !_popup){
      final isGranted = await Permission.location.isGranted;
      if( isGranted ){
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario el accesso al GPS para usar esta app!!'),
            SizedBox(height: 15.0,),
            MaterialButton(
              child: Text(
                'Solicitar Acceso',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              shape: StadiumBorder(),
              color: Colors.black,
              splashColor: Colors.transparent,
              elevation: 0,
              onPressed: () async{
                _popup = true;
                final status = await Permission.location.request();
                await this.gpsAccess(status);
                _popup = false;
              }
            )
          ],
        ),
     ),
   );
  }

  Future gpsAccess(PermissionStatus status) async {
    switch(status){
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, 'loading');
        break;

      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}