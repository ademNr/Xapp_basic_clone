
import 'package:facebook_clone_front/features/auth/controllers/authController.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:get/get.dart';

import 'login.dart';




class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  bool _passwordVisible = false;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController password2 = TextEditingController();
   final AuthController authController = Get.put(AuthController());
  String? erroremail = '';
  String? errorpassword = '';
  String? errorpassword2 = '';

  String email1="";
  String password1="";
  String password22="";
  String username1="";





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints)  {
              return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        constraints.maxWidth * 0.09,
                        constraints.maxHeight * 0.1,
                        constraints.maxWidth * 0.04,
                        constraints.maxWidth * 0.08,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                fontFamily: "Metropolis",
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Create your account in seconds.",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                fontFamily: "Metropolis",
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 50),
                            Form(
                              key: formkey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5,),

                                    TextFormField(
                                      controller: email,
                                      onChanged: (value) {
                                        setState(() {
                                          email1=email.text;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Email is required';
                                        } else if (erroremail != '') {
                                          return erroremail;
                                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                            .hasMatch(value)) {
                                          return 'Please enter a valid email address';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        hintText: 'email',
                                        hintStyle: TextStyle(
                                          color: Color(0xffF7F9F9).withOpacity(0.5),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xff2C3A4A),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "Password",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5,),

                                    TextFormField(
                                      controller: password,
                                      onChanged: (value) {
                                        setState(() {
                                          password1=password.text;
                                        });
                                      },
                                      validator: (value) {
                                        if ( errorpassword!= '') {
                                          return errorpassword;
                                        } else if (value == null || value.isEmpty) {
                                          return 'Password is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      obscureText: !_passwordVisible,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        hintText: 'password',
                                        hintStyle: TextStyle(
                                          color: Color(0xffF7F9F9).withOpacity(0.5),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xff2C3A4A),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Color(0xffF7F9F9),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible = !_passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "Confirm password",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5,),

                                    TextFormField(
                                      controller: password2,
                                      onChanged: (value) {
                                        setState(() {
                                          password22=password2.text;

                                        });
                                      },
                                      validator: (value) {

                                        if (value == null || value.isEmpty) {
                                          return 'Password is required';
                                        }
                                        if ( password1 != password22) {
                                          return "Password don't match";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      obscureText: !_passwordVisible,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        hintText: 'confirm password',
                                        hintStyle: TextStyle(
                                          color: Color(0xffF7F9F9).withOpacity(0.5),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xff2C3A4A),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Color(0xffF7F9F9),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible = !_passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "User name",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5,),

                                    TextFormField(
                                      controller: username,
                                      onChanged: (value) {
                                        setState(() {
                                          username1=password.text;
                                        });
                                      },

                                      validator: (value) {
                                        if ((value?.length)! < 6){
                                          return 'Username must be 6 characters or more';
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        hintText: 'user name',
                                        hintStyle: TextStyle(
                                          color: Color(0xffF7F9F9).withOpacity(0.5),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xff2C3A4A),

                                      ),
                                      style: TextStyle(color: Colors.white),
                                    ),

                                    SizedBox(height: constraints.maxWidth *0.03),


                                    SizedBox( height: constraints.maxWidth *0.07,),

                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0,  constraints.maxWidth * 0.015, 0, 0),
                                      child: Container(
                                        height: 50,
                                        width: 700,
                                        child:  TextButton(
                                          onPressed: () async {
                                            print(password22);
                                            print(password1);
                                            if (formkey.currentState!.validate()) {

                                              authController.register(username.text,  email.text, password.text).then((value) => {
                                                if (authController.authResponse.value.toString()== "this email already email exists"){
                                                  setState(() {
                                                    erroremail="This email taken";
                                                  })
                                                }
                                              });
                                            }
                                            setState(() {
                                              errorpassword="";
                                              erroremail="";
                                            });
                                          },
                                          child: Text(
                                            "Sign up",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                            ),
                                          ),
                                        ),

                                      ),
                                    ),
                                    SizedBox(height: constraints.maxWidth *0.05,),
                                    Row(
                                      children: [

                                        Padding(padding: EdgeInsets.fromLTRB(constraints.maxWidth*0.1, constraints.maxWidth * 0.015, 0, 0),
                                          child: Text("You alerady have an account ?",style: TextStyle(color: Color (0xffF7F9F9)),),
                                        ),


                                        Padding(
                                          padding:  EdgeInsets.fromLTRB(constraints.maxWidth * 0.02, constraints.maxWidth * 0.015, 0, 0),
                                          child: InkWell(
                                            onTap: () async{
                                              Get.to(Signin(),transition: Transition.downToUp,duration: Duration(milliseconds: 400));

                                            },
                                            child: const Text(
                                              'Log in.',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.blue,
                                                decoration: TextDecoration.underline,
                                                decorationThickness: 1.0,
                                                decorationColor:  Colors.blue,
                                              ),


                                            ),
                                          ),
                                        ),


                                      ],
                                    )




                                  ]),
                            ),
                          ] )
                  )

              );
            })
    );
  }
// ignore: prefer_typing_uninitialized_variables
}


