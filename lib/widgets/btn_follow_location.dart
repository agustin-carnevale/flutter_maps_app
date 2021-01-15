part of 'widgets.dart';

class BtnFollowLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = context.watch<MapBloc>();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            mapBloc.state.cameraFollowMe 
            ? Icons.directions_run
            : Icons.accessibility_new, 
            color: Colors.black87,
          ),
          onPressed: (){
            mapBloc.add(OnCameraFollowMe());
          },
        ),
      ),
    );
  }
}