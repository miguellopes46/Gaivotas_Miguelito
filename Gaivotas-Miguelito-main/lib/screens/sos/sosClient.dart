import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/homeClient.dart';
import 'package:flutter_app/services/firestoreSos.dart';

class SosClientPage extends StatefulWidget {
  const SosClientPage({Key key}) : super(key: key);

  @override
  _SosClientPageState createState() => _SosClientPageState();
}

class _SosClientPageState extends State<SosClientPage> {

  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference Sos = FirebaseFirestore.instance.collection('Sos');




  var idSOS;
  Future<void> _showDialog(idSOS) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pedido de SOS'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('O pedido de SOS será cancelado! Tem a certeza?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Center(child: Text('Sim')),
              onPressed: () {
                FirestoreSosDelete(idSOS);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SosClientPage()));
              },
            ),
            TextButton(
              child: Center(child: const Text('Cancelar')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pedido de Socorro", style: TextStyle(color: Colors.black, fontSize: 24),),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => HomePageClient()));
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

          FutureBuilder<DocumentSnapshot>(
            future: Sos.doc(uid).get(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

              if (snapshot.hasError) {
                return Text("Algo correu mal");
              }

              if (snapshot.hasData && !snapshot.data.exists) {
                return Container(child: Column(children: [Center(child: Text("Sem nenhum pedido de socorro")),],),);
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                return Container(

                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 15.0),
                                child: Container(

                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${data['Foto']}"),
                                      )
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Text(data['Nome'], style:
                                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),


                                        SizedBox(height: 20),

                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Text('Data: '+data['Data'], style: TextStyle(fontSize: 16, color: Colors.black),),
                                    SizedBox(height: 5,),
                                    Text('Hora: '+data['Hora'], style: TextStyle(fontSize: 16, color: Colors.black),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:15.0),
                            child: IconButton(icon: Icon(
                                Icons.delete,
                                color: Colors.grey,
                                size: 35),
                              onPressed: () {
                                _showDialog(uid);
                                // _showDialog('${document.id}');
                              },
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                );
              }
              return Center(child: Text("A carregar..."));
            },
          ),

        ],
      ),
    );
  }
}


