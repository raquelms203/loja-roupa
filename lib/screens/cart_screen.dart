import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/cart_model.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/pages/widgets/cart_price.dart';
import 'package:loja/pages/widgets/discount_card.dart';
import 'package:loja/pages/widgets/ship_card.dart';
import 'package:loja/tiles/cart_tile.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        centerTitle: true,
        actions: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 8),
              child: ScopedModelDescendant<CartModel>(
                  builder: (context, child, model) {
                int tam = model.products.length;
                return Text(
                  "${tam ?? 0} ${tam == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17),
                );
              }))
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    top: 16,
                  )),
                  Text(
                    "Faça login para adicionar produtos!",
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
          } else if (model.products == null || model.products.length == 0) {
            return Center(  
              child: Text("Nenhum produto no carrinho!", 
              style: TextStyle(  
                fontSize: 20,
                fontWeight: FontWeight.bold,
                
              ),  
              textAlign: TextAlign.center,),
            );
          } else {
            return ListView(  
              children: <Widget>[  
                Column(  
                  children: model.products.map(  
                    (product) {
                      return CartTile(product);
                    }
                  ).toList(),
                ),
                DiscountCard(),
                ShipCart(),
                CartPrice(() async{  
                  String orderId = await model.finishOrder();

                  if(orderId != null) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:  
                      (context) => OrderScreen(orderId)
                    ));
                  }
                    
                })
              ],
            );
          }
        },
      ),
    );
  }
}
