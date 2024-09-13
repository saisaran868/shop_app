import 'package:flutter/material.dart';
import 'package:shop_app/cart_pages/cart_page.dart';
import 'package:shop_app/product_pages/product_list_page.dart';
import 'package:shop_app/profile_pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int currentPage =0;
List<Widget> pages =const[
  ProductListPage(),
  CartPage(),
  ProfilePage(),
];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        body:IndexedStack(
          index: currentPage,
          children:pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 35,
          currentIndex: currentPage,
          onTap:(value){
            setState(() {
               currentPage = value;
            });
          },
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items:const [
            BottomNavigationBarItem(icon:Icon(Icons.home),label: ""),
            BottomNavigationBarItem(icon:Icon(Icons.shopping_cart),label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: ""),
          ]
        
        ),
      ),
    
    );

  }
}