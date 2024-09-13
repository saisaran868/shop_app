import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_pages/cart_provider.dart';
import 'package:shop_app/splash_screen/splash_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
      
          fontFamily: 'Lato',
          colorScheme:ColorScheme.fromSeed(
         seedColor: const Color.fromRGBO(254, 206, 1, 1),
         primary: const Color.fromRGBO(254, 206, 1, 1),
         ),
           
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),
          textTheme: const TextTheme(
            titleLarge:  TextStyle(
               fontSize: 35,
               fontWeight: FontWeight.bold,
                                ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            
          ),
          useMaterial3: true,
        ),
        
        title: "Shopping App",
        home:const SplashPage(),
      ),
    );
  }
}