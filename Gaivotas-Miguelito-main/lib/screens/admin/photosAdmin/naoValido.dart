import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firestorePhoto.dart';


class NaoValido extends StatefulWidget {
  const NaoValido({Key key}) : super(key: key);

  @override
  _NaoValidoState createState() => _NaoValidoState();
}
enum Opcoes {Validar, Apagar }
var selecao;
class _NaoValidoState extends State<NaoValido> {
//CONFIRMAÇÃO APAGAR FOTOS

  var idFoto;

  Future<void> _showDialog(idFoto) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tem a certeza que pretende validar esta fotografia?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('A fotografia será validada e disponibilizada a todos os utilizadores.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Center(child: Text('Sim')),
              onPressed: () {
                FirestorePhotoValidar(idFoto);
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
          SizedBox(height: 25,),


          //NÃO VALIDAS
          Flexible(
            child: new StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Fotos').where('Valido',isEqualTo: 'Nao').snapshots(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${document['Url']}"),

                                      )

                                  ),
                                ),
                              ),
                              Column(

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
                                  SizedBox(height: 5),
                                  Text(document['Criado'], style: TextStyle(fontSize: 15, color: Colors.black),),
                                  SizedBox(height: 25),


                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _showDialog(document.id);
                                    },
                                    minWidth: 50,
                                    color: Colors.green,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text('Validar', style: TextStyle(color: Colors.white),),

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