import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/home_page.dart';
import 'package:shop_app/login_signup_pages/signup_page.dart';
import '../toast_messages/toast_message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool _passwordText =true;
  bool isLoading =false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 3,
      style: BorderStyle.solid,
    ),
  );
  final errorBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 3,
      style: BorderStyle.solid,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //const Color.fromARGB(255, 193, 221, 235)
        title: Image.asset(
          "assets/images/logo_1.png",
          height: 70,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Text(
                "Login",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email or mobile phone number',
                        errorBorder: errorBorder,
                        focusedErrorBorder: errorBorder,
                        enabledBorder: border,
                        focusedBorder: border,
                        prefixIcon: const Icon(Icons.person, color: Colors.black),
                      ),
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      style:const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                        color: Colors.black,
                      ),

                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        errorBorder: errorBorder,
                        focusedErrorBorder: errorBorder,
                        enabledBorder: border,
                        focusedBorder: border,
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            _passwordText = !_passwordText;
                          });
                        }, icon:Icon(
                          _passwordText ? Icons.visibility_off : Icons.visibility,
                        ),
                        )
                      ),
                      textInputAction: TextInputAction.done,
                      obscureText:_passwordText,
                      controller: passwordController,
                      style:const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                        color: Colors.black,
                      ),

                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 55,
                      width: double.infinity, // Make button full-width
                      child: ElevatedButton(
                        onPressed: ()=> login(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                        ),
                        child:isLoading ? const  CircularProgressIndicator():
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),

                        ),
                      ),

                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SignupPage()),
                        );
                      },
                      child: const Text(
                        "Need an account? Sign up",
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
            ],
          ),
        ),
      ),
    );
  }
  void login(BuildContext context) async{
    String email = emailController.text;
    String password = passwordController.text;
    RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (email.isEmpty || !emailRegExp.hasMatch(email)) {
      showToast("Invalid email address");
      return;
    }
    if (password.isEmpty || password.length<6) {
      showToast("Password must be at least 6 characters long.");
      return;
    }
    if(isLoading){
      return;
    }
    setState(() {
      isLoading =true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Email or mobile", email);
    await Future.delayed(const Duration(seconds: 2),);
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }


}
