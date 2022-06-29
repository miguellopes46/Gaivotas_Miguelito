import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/auth/login.dart';
import 'package:flutter_app/screens/auth/signup.dart';
import 'package:flutter_app/screens/home/homeClient.dart';
import 'package:flutter_app/screens/photo/uploadFoto.dart';
import 'package:flutter_app/screens/welcome.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:LandingPage(),

      debugShowCheckedModeBanner: false,

      //initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/sign': (context) => SignupPage(),
        '/welcome': (context) => Welcome(),
        'upload' : (context) => UploadFoto(),
        'admin' : (context) => HomePageClient(),

      },
    );
  }
}

class LandingPage extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;

                if (user == null) {
                  print('O utilizador está desconectado!');
                  return Welcome();
                } else {
                  print('O utilizador está conectado!');
                  return HomePageClient();
                }
              }
              return Scaffold(
                body: Center(
                  child: Text("A verificar a conexão..."),
                ),
              );
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: Text("A conectar a aplicação..."),
          ),
        );
      },
    );
  }
}


