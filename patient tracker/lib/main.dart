import 'package:flutter/material.dart';
import 'package:practice/signup.dart';  // for SignUp page
import 'package:practice/home.dart';    // for Home Page
import 'package:practice/home_doctor.dart';    // for doctor's Home Page
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //static const String _title = 'Patient Tracker';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LogIn(),
    );
  }
}

// create LogIn page
class LogIn extends StatelessWidget {
  //const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Patient Tracker",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
            textAlign: TextAlign.center,
            ),          
          backgroundColor: const Color(0xFF323264),
          ),
        body: Scaffold(
          backgroundColor: Colors.orange[50],
          body: Center(
            child: Center(
              child: Login_Form(),
            ),
          ),
          /*
          body: Container (
            child: Login(),
        ),
        */
        ),         
      );
  }
}

/*
class _Login extends StatelessWidget {
  const _Login({Key? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logIn = Align(
      alignment: Alignment.center,
      child: Login_Form(),
    );
    
    return logIn;
  }
}
*/

class Login_Form extends StatefulWidget {
  //const Login_Form({Key? key}) : super(key: key);
  @override
  _Login_FormState createState() => _Login_FormState();
}

// create sign up form
class _Login_FormState extends State<Login_Form> {
  //const _Login_FormState({Key? key} ) : super(key: key);
  //bool _isObscure = true; // show the password or not

  // API
  final String apiURL = 'http://patient.com/api'; // backend URL
  // create Controller
  final signIn_email = TextEditingController();
  final signIn_password = TextEditingController();  
  
  String result = ''; // To store the result from the API call

  // ===========

  // applying GET request
  Future <void> postRequest() async {
    try {
      final response = await http.post(
        Uri.parse(apiURL),
        headers: <String, String> {
          'Content-Type': 'application/json; charset = UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': signIn_email.text,
          'password': signIn_password.text,
        }),
      );

      if (response.statusCode == 200) {
        // Successful POST request, handle the reponse here
        final responseData = jsonDecode(response.body);
        setState((){
          result = 'ID: ${responseData['id']}\nEmail: ${responseData['email']}\nPassword: ${responseData['password']}';
        });
      }
      else {
        // if the server returns an error response, thrown an exception
        throw Exception('Failed to post data');
      }
    }
    catch (e) {
      setState((){
        result = 'Error: $e';
      });
    }
  }

  // ============
  @override
  Widget build(BuildContext context) { 
    
    // function for button   
    void SignIn(){
      final email = signIn_email.text;
      debugPrint(signIn_email.text);
      debugPrint(signIn_password.text);
      // go to Home Page (home.dart)

      // check doctor or not
      if (RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(@communitymedical.org)$")
        .hasMatch(email)) {
        debugPrint('doctor email');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home_Doctor()),
        );
        }
      else {
        if (RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.(com|edu|org|gov)$")
          .hasMatch(email)) {
          debugPrint('patient email');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } 
        else {
          debugPrint('Error');
        }
      }

 
      
      /*
      // go to Home page if not null
      if (signIn_email.text.isNotEmpty && signIn_password.text.isNotEmpty){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }  
      else {
        debugPrint('Empty');
      }
      */

      /*
      // check email type by regular expression
      final email = signIn_email.text;
      if (RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
        .hasMatch(email)) {
        debugPrint('patient email');
      } 
      else if (RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@communitymedical.org")
        .hasMatch(email)) {
        debugPrint('doctor email');
        }
      else {
        debugPrint('Error');
      }
      */
    }
    
    

    // main funciton
    final logIn_form = Container(
      width: 322,
      height: 447,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [          
          // Title - Sign In
          const Text(
            'Log In',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Istok Web',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          // Text Box for Email
          Container(
            width: 210,
            height: 56,
            child: TextField(
              controller: signIn_email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter here...',
              ),
            ),
          ),
          // Text Box for Password
          Container(
            width: 210,
            height: 56,
            child: TextFormField(
              controller: signIn_password,
              //obscureText: _isObscure,  // hidden password
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter here...',
                /*
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: (){
                    setState(() {
                        _isObscure = !_isObscure;
                      });
                  },
                ),
                */
              ),
            ),
          ),
          // Button for Sign In
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF6750A4), // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              SignIn(); //SignIn
              //postRequest();              
            },  
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
          ),
          // go to Sign Up page (signup.dart)        
          TextButton(
            onPressed: (){
              //signIn_email.clear();
              //signIn_password.clear();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              );
            },
            child: const Text(
            "Don't Have an Account? Sing Up",
            style: TextStyle(
              color: Color(0xFF0000FF),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,   
              decoration: TextDecoration.underline, 
              decorationColor: Color(0xFF0000FF),          
              height: 0.09,
              letterSpacing: 0.50,
              
            ),
          ),
          ), 
          
      ]),
    );
    
    return logIn_form;
  }
}