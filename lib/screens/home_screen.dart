import 'package:flutter/material.dart';
import 'package:loja/pages/tabs/home_tab.dart';
import 'package:loja/pages/tabs/orders_tab.dart';
import 'package:loja/pages/tabs/places_tab.dart';
import 'package:loja/pages/widgets/cart_button.dart';
import 'package:loja/pages/widgets/custom_drawer.dart';
import 'package:loja/pages/tabs/products_tab.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(  
         
          drawer: CustomDrawer(pageController: _pageController,),
           body: HomeTab(),
           floatingActionButton: CartButton(),
        ),
       Scaffold(  
         appBar: AppBar(  
           title: Text("Produtos"),
           centerTitle: true,
         ),
         drawer: CustomDrawer(pageController: _pageController,),
         floatingActionButton: CartButton(),
         body: ProductsTab(),
       ),
       Scaffold(  
         appBar: AppBar(  
           title: Text("Lojas"),
           centerTitle: true,
         ),
         body: PlacesTab(),
         drawer: CustomDrawer(pageController: _pageController,)
       ),
       Scaffold(  
         appBar: AppBar(  
           title: Text("Meus Pedidos"),
           
         ),
         body: OrdersTab(),
           drawer: CustomDrawer(pageController: _pageController)
       )
      ],
    );
  }
}