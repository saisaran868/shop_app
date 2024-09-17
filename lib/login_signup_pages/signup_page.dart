import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/home_page.dart';
import 'package:shop_app/login_signup_pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../toast_messages/toast_message.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;
  bool _passwordSignup = true;
  bool _confrimPasswordSignup = true;
  bool isTermsChecked = false;
  final Uri terms = Uri.parse('https://flutter.dev');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confrimPasswordController = TextEditingController();
   final border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 3,
      style: BorderStyle.solid,
    ),
  );
   
  final errorBorder =const  OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 3,
      style: BorderStyle.solid,
    ),
  );

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,
        title: Image.asset("assets/images/logo_1.png",
        height: 70,
        )
          ),

     body:SingleChildScrollView(
       child: Form(
        key: formKey,
        
         child: Padding(
           padding: const EdgeInsets.all(24.0),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100,),
               Text(
                "Sign up",
                style: Theme.of(context).textTheme.titleLarge,
                ),
               const SizedBox(height: 30,),
       
               TextFormField(
                decoration:  InputDecoration(
                    hintText: 'Email or mobile phone number',
                    errorBorder: errorBorder,
                    focusedErrorBorder: errorBorder,
                    enabledBorder: border,
                    focusedBorder: border,
                    prefixIcon: const Icon(Icons.person ,color: Colors.black,),
                ),
                textInputAction:TextInputAction.next ,
                controller: emailController,
                 style:const TextStyle(
                   fontFamily: 'Roboto',
                   fontSize: 16.0,
                   color: Colors.black,
                 ),
               ),
       const SizedBox(height: 15,),
       
                TextFormField(
                decoration:  InputDecoration(
                    hintText: 'Password',
                    errorBorder: errorBorder,
                    focusedErrorBorder: errorBorder,
                    enabledBorder: border,
                    focusedBorder: border,
                    prefixIcon: const Icon(Icons.lock ,color: Colors.black,),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _passwordSignup = !_passwordSignup;
                      });
                    }, icon:Icon(
                      _passwordSignup ? Icons.visibility_off : Icons.visibility,
                    ),
                    ),
                ),
                textInputAction:TextInputAction.next,
                controller: passwordController,
                  obscureText: _passwordSignup,
                  style:const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
               ),
       const SizedBox(height: 15,),
       
        TextFormField(
                decoration:  InputDecoration(
                    hintText: 'Confrim Password',
                    errorBorder: errorBorder,
                    focusedErrorBorder: errorBorder,
                    enabledBorder: border,
                    focusedBorder: border,
                    prefixIcon: const Icon(Icons.lock ,color: Colors.black,),
                    suffixIcon:  IconButton(onPressed: (){
                      setState(() {
                        _confrimPasswordSignup = !_confrimPasswordSignup;
                      });
                    }, icon:Icon(
                      _confrimPasswordSignup ? Icons.visibility_off : Icons.visibility,
                    ),
                    ),
                ),
                textInputAction:TextInputAction.done ,
                controller: confrimPasswordController,
          obscureText: _confrimPasswordSignup,
          style:const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16.0,
            color: Colors.black,
          ),
               ),
       const SizedBox(height: 5,),
Row(
  children: [
    Checkbox(value: isTermsChecked, onChanged:(value){
      setState(() {
        isTermsChecked =value!;
      });
    }
    ),

     InkWell(
       onTap: (){
       launchUrl(terms);

       },
       child: const Text("Terms and Conditions",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
          ),
     ),

  ],
),
          const  SizedBox(height: 5,),
           SizedBox(
             height: 55,
             width: double.infinity, // Make button full-width
             child: ElevatedButton(
               onPressed: () {
                signUp(context);
               },
               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.yellow,
               ),
               child: isLoading?const CircularProgressIndicator():const Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                    Text(
                     "Sign Up",
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 21,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ],
               ),
             ),
           ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            ],
           ),
         ),
       ),
     )   
    );
  }
  void signUp(context)async{
    String emailSignup = emailController.text;
    String password = passwordController.text;
    String confrimPassword = confrimPasswordController.text;
    RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (emailSignup.isEmpty || !emailRegExp.hasMatch(emailSignup)) {
      showToast("Invalid email address");
      return;
    }
    if(password.isEmpty || password.length<6){
      showToast("Password must be at least 6 characters long.");
      return;
    }
    if(confrimPassword != password){
      showToast("Password doesn't match.");
      return;
    }
    if(isTermsChecked != true){
      showToast("Accept Terms and Conditions");
      return;
    }
    if(isLoading){
      return;
    }
    setState(() {
      isLoading =true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Email or mobile", emailSignup);
    await Future.delayed(const Duration(seconds: 2),);
    setState(() {
      isLoading = false;
    });
    showToast("Account Created Successfully");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );

  }
  Future<void> _launchUrl (Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}

