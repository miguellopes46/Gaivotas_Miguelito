import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/auth/signup.dart';
import 'package:flutter_app/screens/auth/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(

          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(

                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: ()async {
                        const url = 'https://www.facebook.com/gaivotasmiguelito';
                        if (await canLaunch(url)) {
                          await launch(url);
                        }else {
                          throw 'Could not launch $url';
                        }

                      },
                      icon: FaIcon(FontAwesomeIcons.facebook,size: 40,color: Colors.blue,),
                    ),
                    IconButton(
                      onPressed: ()async {
                        const url = 'https://www.instagram.com/gaivotasmiguelito/';
                        if (await canLaunch(url)) {
                        await launch(url);
                        }else {
                        throw 'Could not launch $url';
                        }

                      },
                      icon: FaIcon(FontAwesomeIcons.instagram,size: 40,color: Colors.pinkAccent,),
                    ),
                  ],
                ),

              ),
              SizedBox(
                height: 150,
              ),


              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png")
                    )
                ),
              ),


              Column(
                children: <Widget>[
                  // the login button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

                    },
                    // defining the shape
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text(
                      "Iniciar sessão",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                      ),
                    ),
                  ),
                  // creating the signup button
                  SizedBox(height:20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));

                    },
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text(
                      "Criar conta",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                      ),
                    ),
                  ),
                DoubleBackToCloseApp(
                        snackBar: const SnackBar(
                          content: Text('Pressione novamente para sair!'),
                        ),
                        child: Center(
                          child: MaterialButton(

                            onPressed:(){

                              WidgetsBinding.instance.handlePopRoute;

                          }
                          ),
                        ),
                      ),

                ],
              ),


            ],
          ),
        ),
      ),
    );
  }

}
