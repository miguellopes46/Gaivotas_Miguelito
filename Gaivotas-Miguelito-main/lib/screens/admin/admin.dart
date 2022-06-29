import 'package:flutter/material.dart';
import 'package:flutter_app/screens/admin/photosAdmin.dart';
import 'package:flutter_app/screens/admin/photosAdmin/naoValido.dart';
import 'package:flutter_app/screens/admin/photosAdmin/valido.dart';
import 'package:flutter_app/screens/admin/reviewsAdmin.dart';
import 'package:flutter_app/screens/admin/sosAdmin.dart';
import 'package:flutter_app/screens/admin/usersAdmin.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();


              },
              icon: Icon(Icons.arrow_back_ios,

                color: Colors.black,
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              //controller: _tabController,
              isScrollable: true,
              tabs: [
                Tab(icon: Icon(Icons.warning_amber_outlined), text: 'Pedidos de SOS'),
                Tab(icon: Icon(Icons.account_circle_outlined), text: 'Utilizadores',),
                Tab(icon: Icon(Icons.rate_review_outlined), text: 'Reviews'),
                Tab(icon: Icon(Icons.photo_camera_outlined), text: 'Fotos'),

              ],
            ),
            centerTitle: true,
            title: Text('Administração', style: TextStyle(color: Colors.black,),),
          ),
          body: TabBarView(
            children: [
              Container(
                child: SosAdmin(),

              ),

              Container(
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      toolbarHeight: 50,
                      toolbarTextStyle: TextStyle(color: Colors.black),
                      backgroundColor: Colors.blue.shade300,


                      bottom: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,

                        tabs: [

                          Tab( text: 'Online',),
                          Tab( text: 'Offline'),
                          Tab( text: 'Todos'),
                        ],
                      ),
                    ),
                    body: TabBarView(

                      children: [
                        Container(
                          child: OnlineUsers(),

                        ),
                        Container(
                          child: OfflineUsers(),

                        ),
                        Container(
                          child: UsersAdmin(),

                        ),


                      ],
                    ),

                  ),
                )

              ),


              Container(
                child: ReviewsAdmin(),

              ),
              Container(
                  child: DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      extendBodyBehindAppBar: true,
                      appBar: AppBar(
                        toolbarHeight: 50,
                        toolbarTextStyle: TextStyle(color: Colors.black),
                        backgroundColor: Colors.blue.shade300,


                        bottom: TabBar(
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          isScrollable: true,
                          tabs: [
                            Tab( text: 'Não validadas'),
                            Tab( text: 'Validadas'),
                            Tab( text: 'Todas'),
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          Container(
                            child: NaoValido(),

                          ),
                          Container(
                            child: Valido(),

                          ),
                          Container(
                            child: PhotosAdmin(),

                          ),


                        ],
                      ),

                    ),
                  )

              ),

            ],
          ),
        ),
      ),
    );
  }

}

