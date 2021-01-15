part of 'widgets.dart';

class BtnShowRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = context.watch<MapBloc>();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.more_horiz, color: Colors.black87,),
          onPressed: (){
            mapBloc.add(OnShowRoute());
          },
        ),
      ),
    );
  }
}