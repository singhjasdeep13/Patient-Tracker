import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice/view/user/patientDisplay.dart'; // for Patient Information Page
import 'package:practice/main.dart';   // for login page 
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';  // for decoding received JSON

class Page_User extends StatefulWidget {
  //const MyWidget({super.key});

  @override
  State<Page_User> createState() => _Page();
}


class _Page extends State<Page_User> {
    /* API */
  final String apiURL = 'http://10.62.77.52:3000/auth/logout'; // backend URL
  String result = ''; // To store the result from the API call

  /* ======================== */
  /* applying POST request */
  void postRequest_logout() async {
    try {
      final response = await http.post(
        Uri.parse(apiURL),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        /*
        body: jsonEncode(<String, dynamic>{
          'email': signIn_email.text,
          'password': signIn_password.text
        }),
        */
      );
      final responseData = jsonDecode(response.body);
      final resultString = jsonEncode(responseData);
      if (response.statusCode == 200) {
        /* Successful POST request, handle the reponse here */    
        setState((){
          result = resultString;
          print(resultString);
        });
      }
      else {
        /* if the server returns an error response, thrown an exception */
        print(resultString);
      }
    }
    catch (e) {
      setState((){
        result = 'Error: $e';
        print(result);
      });
    }
  }
  
  /* ======================== */

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        /* Logo Image Button */
        title: IconButton(
          icon: Image.asset(
                'assets/images/patient_logo.png',
                height: 80,
                width: 80,
            ),
          onPressed: (){
            /* Action for Logo Button */
          },
        ),
        actions: <Widget> [
          PopupMenuButton<String>(
            offset: Offset(0.0, 50), // position
            constraints: BoxConstraints.expand(width: 120, height: 65), // size
            color: Color(0xFFF4F4F4),  // color
            surfaceTintColor: Color(0xFFF4F4F4),  // color
            onSelected: (String value) async {
              if (value == 'logout'){                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogIn()), // go to patient home pages
                );
                patientList.clear();   
                postRequest_logout();             
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child:CircleAvatar(
                child: Icon(
                  Icons.account_circle,
                  color: Color(0xFF373C88),
                  size: 40,                
                ),
                backgroundColor: Color(0xFFF4F4F4),
              ),
            ),            
            itemBuilder: (context) {
              return [
                /* LogOut Button */
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Log Out',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF373C88),
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ];
            }
          ),
        ],
        backgroundColor: Color(0xFFF4F4F4),
      ),
      /* Main part: The patient list */
      body: add_patient(),
    );
  }
}
