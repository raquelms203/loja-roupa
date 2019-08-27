import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:loja/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if (!UserModel.of(context).isLoggedIn()) {
       return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    top: 16,
                  )),
                  Text(
                    "Faça login para acompanhar!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    top: 16,
                  )),
                  FlatButton(  
                    child: Text("Entrar", 
                    style: TextStyle(  
                      fontSize: 18,
                      color: Colors.white
                    ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(  
                        builder: (context) => LoginScreen()
                      ));
                    },
                  )
                ],
              ),
            );
    } else {
      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(  
        future: Firestore.instance.collection("users").document(uid).collection("orders").getDocuments(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) 
            return Center(  
              child: CircularProgressIndicator(),
            );
            else {
              return ListView(  
                children: snapshot.data.documents.map(
                  (doc) => OrderTile(doc.documentID)).toList().reversed.toList()
                );
            }
            }
        
      );
    }
    
  }
}