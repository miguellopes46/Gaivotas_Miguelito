import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/sos/sosMap.dart';
import 'package:flutter_app/services/firestoreReviews.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'sosMap.dart';

class SosPage extends StatefulWidget {
  const SosPage({Key key}) : super(key: key);

  @override
  _SosPageState createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {

  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference Sos = FirebaseFirestore.instance.collection('Sos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido de Socorro',style: TextStyle(fontSize: 25, color: Colors.black)
        ),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();

          },
          icon: Icon(Icons.arrow_back_ios,

            color: Colors.black,
          ),
        ),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(

            child: SizedBox(height: 30,),

          ),
          Flexible(
            child:  StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Sos').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: Text('A carregar Pedidos de Socorro...'));
                return ListView(

                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return SafeArea(
                      child:  Padding(
                        padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.green,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${document['Foto']}"),
                                      )
                                  ),
                                ),
                              ),
                              Container(
                                child: Expanded(
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      SizedBox(height: 15),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(document['Nome'], style:
                                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),


                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(document['Data']+' '+document['Hora'], style: TextStyle(fontSize: 16, color: Colors.black54),),
                                      SizedBox(height: 5),
                                      MaterialButton(
                                          onPressed: () {

                                            String localId= document['Id'];
                                            LocationMarker(localId);


                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (BuildContext context) => SosMap()));

                                          },
                                          child:
                                              Text(
                                                  'Ver Mapa'
                                              ),

                                      ),
                                    ],
                                  ),
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



        ],
      ),
    );
  }

}
