import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firestoreUsers.dart';


class UsersAdmin extends StatefulWidget {





  @override
  _UsersAdminState createState() => _UsersAdminState();
}

class _UsersAdminState extends State<UsersAdmin> {

  var idUser;
  Future<void> _showDialog(idReview) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tem a certeza que pretende eliminar?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('A Review será apagada permanentemente do sistema.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Center(child: Text('Sim')),
              onPressed: () {
                FirestoreUserDelete(idUser);
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

          Flexible(
            child: new StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Utilizadores').orderBy('Estado',descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: new Text('A carregar Reviews...'));
                return new ListView(

                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new SafeArea(
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.green,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                                child: Container(
                                  width: 80,
                                  height: 80,
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
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          Text(document['Nome'], style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),


                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Text(document['Email'], style: TextStyle(fontSize: 15, color: Colors.black),),
                                      SizedBox(height: 5,),
                                      Text('Criado a '+document['Criado'], style: TextStyle(fontSize: 15, color: Colors.black),),
                                      SizedBox(height: 5,),
                                      Text('Último acesso a '+document['ultimoLogin'], style: TextStyle(fontSize: 15, color: Colors.black),),
                                      SizedBox(height: 5,),
                                      if(document['Estado'] == 'Online') Text(document['Estado'], style: TextStyle(fontSize: 15, color: Colors.green),),
                                      if (document['Estado'] == 'Offline')Text(document['Estado'], style: TextStyle(fontSize: 15, color: Colors.red),),
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

Widget OnlineUsers(){
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 25,),

        Flexible(
          child: new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Utilizadores').where('Estado',isEqualTo: 'Online').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Center(child: new Text('A carregar Reviews...'));
              return new ListView(

                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new SafeArea(
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.green,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                              child: Container(
                                width: 80,
                                height: 80,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Text(document['Nome'], style:
                                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                      ),


                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Text(document['Email'], style: TextStyle(fontSize: 15, color: Colors.black),),
                                  SizedBox(height: 5,),
                                  Text('Criado a '+document['Criado'], style: TextStyle(fontSize: 15, color: Colors.black),),
                                  SizedBox(height: 5,),
                                  Text('Último acesso a '+document['ultimoLogin'], style: TextStyle(fontSize: 15, color: Colors.black),),
                                  SizedBox(height: 5,),
                                  Text(document['Estado'], style: TextStyle(fontSize: 15, color: Colors.green),),

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

Widget OfflineUsers(){
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 25,),

        Flexible(
          child: new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Utilizadores').where('Estado',isEqualTo: 'Offline').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Center(child: new Text('A carregar Utilizadores...'));
              return new ListView(

                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new SafeArea(
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.green,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                              child: Container(
                                width: 80,
                                height: 80,
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
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Text(document['Nome'], style:
                                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),


                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Text(document['Email'], style: TextStyle(fontSize: 15, color: Colors.black),),
                                    SizedBox(height: 5,),
                                    Text('Criado a '+document['Criado'], style: TextStyle(fontSize: 15, color: Colors.black),),
                                    SizedBox(height: 5,),
                                    Text('Último acesso a '+document['ultimoLogin'], style: TextStyle(fontSize: 15, color: Colors.black),),
                                    SizedBox(height: 5,),
                                    Text(document['Estado'], style: TextStyle(fontSize: 15, color: Colors.red),),

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
