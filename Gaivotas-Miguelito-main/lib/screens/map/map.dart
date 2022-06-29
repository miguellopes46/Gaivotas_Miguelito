import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/admin/admin.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  GoogleMapController mapController;
  Set<Marker> markers = new Set<Marker>();
  double lat = 40.45055321730234;
  double long = -8.797889649868011;

  CollectionReference Sos = FirebaseFirestore.instance.collection('Sos');



void _onMapCreated (GoogleMapController controller) {
  mapController = controller;

  LatLng porto = LatLng(40.451351526181575, -8.801396302878857);
  LatLng users= LatLng(40.45162170910973, -8.799650520086288);
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

  void _addMarker(double lat, double lng, String Uname ) {
   // markers.clear();
    var _marker = Marker(
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: InfoWindow(
          title: Uname,
        ),
    );
    setState(() {
      markers.add(_marker);
    });
  }


  Future<void> _MarkerUpdate() async {

    FirebaseFirestore.instance
        .collection('Localizacoes')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _addMarker(doc['Latitude'] , doc['Longitude'] , doc['Nome']);
        print("A atualizar a posição dos clientes!");

      });
    });

  }


  changed(value) {
    setState(() {
      markers.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _MarkerUpdate();

  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Column(
        children: [
          Container(
          height: MediaQuery.of(context).size.height / 1.7,

            child: GoogleMap(
              compassEnabled: true,
              trafficEnabled: true,
              //mapType: MapType.hybrid,
              onMapCreated: _onMapCreated,
              onCameraMove: (data) {
                print(data);
              },
              onTap: (position) {
                print(position);
                print("hello");
              },
              initialCameraPosition: CameraPosition(
                target:LatLng(lat, long),
                zoom:15.50,
              ),

              markers: markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Center(
                child: MaterialButton(

                  height: 30,
                  onPressed: () {

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()));
                  },
                  color: Colors.black12,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Text(
                    "Atualizar Mapa", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,

                  ),
                  ),

                ),

              ),

            ],


          ),


          SizedBox(height: 10,),
          Text('Pedidos de SOS', style:
          TextStyle(fontSize: 25, color: Colors.black)),

          Divider(height: 10,thickness: 1, color: Colors.black,),
          SizedBox(height: 10,),
          Flexible(
            child: new StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Sos').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: new Text('A carregar Reviews...'));
                return new ListView(

                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new SafeArea(
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.green,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.warning, size: 20,),
                                        Text('  O utilizador ', style:
                                        TextStyle(fontSize: 17, color: Colors.black)),
                                        Text(document['Nome'], style:
                                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),
                                        Text(' está a pedir ajuda!', style:
                                        TextStyle(fontSize: 17, color: Colors.black)),

                                      ],
                                    ),

                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),

                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AdminPage()));

              //Navigator.of(context).pushReplacementNamed('/home');
            },
            minWidth: 350,
            color: Colors.black12,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('Ver mais'),

          )

        ],
      )
    );
  }
}
