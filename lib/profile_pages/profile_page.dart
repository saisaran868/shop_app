import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/login_signup_pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account" ,
        ),
        actions:  [
          // logout(context);
          IconButton(onPressed: (){
           showDialog(context: context, builder: (context){
             return AlertDialog(
               title: Text("Logout",style: Theme.of(context).textTheme.titleMedium,),
               content: const Text("Are you sure you want to Logout ?"),
               actions: [
                 TextButton(onPressed: (){
                   Navigator.pop(context);
                 }, child: const Text("No" ,style: TextStyle(color: Colors.blue),),),

                 TextButton(onPressed: (){
                   logout(context);
                 }, child: const Text("Yes" ,style: TextStyle(color: Colors.red),),),
               ],

             );
           }
           );
          },
            icon: const Icon(Icons.exit_to_app),),
        ],
      ),
      body: Container(
        padding:const EdgeInsets.all(24.0),
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [


          ],
        ),
      ),
    );
  }
  logout(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Make sure to await the clear operation
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false, // Remove all routes
    );
  }

}
