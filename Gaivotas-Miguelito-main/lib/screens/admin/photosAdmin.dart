import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firestorePhoto.dart';


class PhotosAdmin extends StatefulWidget {
  const PhotosAdmin({Key key}) : super(key: key);

  @override
  _PhotosAdminState createState() => _PhotosAdminState();
}

class _PhotosAdminState extends State<PhotosAdmin> {
//CONFIRMAÇÃO APAGAR FOTOS

  var idFoto;
  Future<void> _showDialog(idFoto) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tem a certeza que pretende eliminar?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('A fotografia será apagada permanentemente do sistema.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Center(child: Text('Sim')),
              onPressed: () {
                FirestorePhotoDelete(idFoto);
                Navigator.of(context).pop();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15,),

          //TODAS AS FOTOGRAFIAS
          Flexible(
            child: new StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Fotos').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: new Text('A carregar fotos...'));
                return new ListView(

                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new SafeArea(
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${document['Url']}"),

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



                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    IconButton(icon: Icon(
                                        Icons.delete,
                                        color: Colors.grey,
                                        size: 35),
                                      onPressed: () {
                                        _showDialog(document.id) ;
                                        // _showDialog('${document.id}');
                                      },
                                    ),
                                    SizedBox(height: 5),

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

        ],
      ),
    );
  }
}

