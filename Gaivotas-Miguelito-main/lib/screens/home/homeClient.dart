import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/ficha.dart';
import 'package:flutter_app/screens/map/mapClient.dart';
import 'package:flutter_app/screens/photo/allPhotos.dart';
import 'package:flutter_app/screens/profile/profile.dart';
import 'package:flutter_app/screens/reviews/reviewsClient.dart';
import 'package:flutter_app/screens/sos/sosClient.dart';
import 'package:flutter_app/screens/welcome.dart';
import 'package:flutter_app/services/FirestoreLocations.dart';
import 'package:flutter_app/services/firestoreUsers.dart';



class HomePageClient extends StatefulWidget {
  const HomePageClient({Key key}) : super(key: key);

  @override
  _HomePageClientState createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {

  String _userName = FirebaseAuth.instance.currentUser.displayName;
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference utilizadores = FirebaseFirestore.instance.collection('Utilizadores');


  //String _dateLastSigned = DateFormat('MM-dd-yyyy – kk:mm').format(FirebaseAuth.instance.currentUser.metadata.lastSignInTime);


  Future<void>exitDialog(){
    return showDialog(context: context,
      builder: (context) => new AlertDialog(title: Text('Tem a certeza que pretende sair?'),
        actions: [
          MaterialButton(
              onPressed: (){
                _logoutuser();
              },
              child:Text('Sim')
          ),
          MaterialButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child:Text('Cancelar')
          ),

        ],
      ),
    );

  }

  Future<void> _logoutuser() async {

    //Firestore offline
    OfflineUser();

    //Sair FirebaseAuth
    await FirebaseAuth.instance.signOut();

    //Apagar Localização
    FirestoreLocationDelete(uid);

    //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext contex) => Welcome()));
    //Navigator.popUntil(context, ModalRoute.withName('/welcome'));
    Navigator.pushNamedAndRemoveUntil(context, "/welcome", (Route<dynamic> route) => false);



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [

            UserAccountsDrawerHeader(
              currentAccountPicture:FutureBuilder<DocumentSnapshot>(
                future: utilizadores.doc(uid).get(),
                builder:
                    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data.exists) {
                    return Text("Document does not exist");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data.data();
                    return Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  //color: Theme.of(context).backgroundColor
                                ),

                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("${data['Foto']}"),
                                )
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Text("A carregar...");
                },
              ),
              accountName: Text(
                'Bem-vindo '+_userName,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),

              ),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              subtitle: Text('Página principal'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePageClient()));
                print('home');
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Minha conta',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              subtitle: Text('Perfil e definições de conta'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Profile()));
                print('Conta');
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              leading: Icon(Icons.rate_review_outlined),
              title: Text('Reviews',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ReviewsClient()));
                print('Review');
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              leading: Icon(Icons.photo_camera_outlined),
              title: Text('Fotos',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AllPhotos()));
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              leading: Icon(Icons.warning_amber_outlined),
              title: Text('SOS',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              subtitle: Text('Pedidos de sos à empresa'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SosClientPage()));
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              subtitle: Text('Finalizar sessão'),
              onTap: () async {
                print('Sair');
                exitDialog();
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,

          title: Text("Gaivotas Miguelito",
            style: TextStyle(color: Colors.black, fontSize: 24),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Ficha()));

              },
              icon: Icon(Icons.info_outline, size: 30 ,
              ),
            ),
          ),
        ],
      ),

      body: MapPageClient(),

    );
  }
}
