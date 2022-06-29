import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void>LocationMarker (String localId) async{
  void _addMarker(double lat, double lng) {
    var _marker = Marker(
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    );

  }

  GoogleMapController mapController;
  Set<Marker> markers = new Set<Marker>();
  double lat = 40.45055321730234;
  double long = -8.797889649868011;

  void _onMapCreated (GoogleMapController controller) {


    mapController = controller;

    LatLng porto = LatLng(40.451351526181575, -8.801396302878857);
    final Marker marker = Marker(
        markerId: new MarkerId("porto"),
        position: porto,
        infoWindow: InfoWindow(
          title: "Gaivotas Miguelito",
          snippet: "Ponto de Partida",
        )
    );


  }

  FirebaseFirestore.instance.collection('Sos').doc(localId).get().then((data) {

    _addMarker(data['Latitude'] , data['Longitude'] );

    return Scaffold(
        appBar: AppBar(
          title: Text('GM - Administração'),
        ),

        body: Column(
          children: [
            Container(

              child: GoogleMap(


                onCameraMove: (data) {
                  //print(data);

                },
                onTap: (position) {
                  print(position);
                  print("Estou na localização");

                },
                initialCameraPosition: CameraPosition(
                  target:LatLng(lat, long),
                  zoom:15.50,
                ),

                markers: markers,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,


              ),
            ),


          ],

        )
    );


  });

}

class SosMap extends StatefulWidget {
  const SosMap({Key key}) : super(key: key);

  @override
  _SosMapState createState() => _SosMapState();
}

class _SosMapState extends State<SosMap> {


  void _addMarker(double lat, double lng) {
    var _marker = Marker(
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    );
    setState(() {
      markers.add(_marker);
    });
  }


  Future<void> MarkerUpdate() async {

    FirebaseFirestore.instance
        .collection('Sos')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _addMarker(doc['Latitude'] , doc['Longitude'] );
        print("Esta a atualizar a posição dos clientes!");

      });
    });

  }

  changed(value) {
    setState(() {
      markers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GM - Administração'),
        ),

        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.50,
              child: GoogleMap(


                onCameraMove: (data) {
                  //print(data);

                },
                onTap: (position) {
                  print(position);
                  print("Estou na localização");

                },
                initialCameraPosition: CameraPosition(
                  target:LatLng(lat, long),
                  zoom:15.50,
                ),

                markers: markers,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,


              ),
            ),


          ],

        )
    );
  }
  GoogleMapController mapController;
  Set<Marker> markers = new Set<Marker>();
  double lat = 40.45055321730234;
  double long = -8.797889649868011;

  void _onMapCreated (GoogleMapController controller) {


    mapController = controller;

    LatLng porto = LatLng(40.451351526181575, -8.801396302878857);
    final Marker marker = Marker(
        markerId: new MarkerId("porto"),
        position: porto,
        infoWindow: InfoWindow(
          title: "Gaivotas Miguelito",
          snippet: "Ponto de Partida",
        )
    );
    setState(() {
      markers.add(marker);
    });

  }
}
