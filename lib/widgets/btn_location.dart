part of 'widgets.dart';

class BtnLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = context.watch<MapBloc>();
    final myLocationBloc = context.watch<MyLocationBloc>();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black87,),
          onPressed: (){
            mapBloc.moveCamera(myLocationBloc.state.location);
          },
        ),
      ),
    );
  }
}