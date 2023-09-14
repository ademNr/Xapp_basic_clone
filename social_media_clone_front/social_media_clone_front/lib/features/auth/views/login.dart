import 'package:facebook_clone_front/features/auth/controllers/authController.dart';
import 'package:facebook_clone_front/features/auth/views/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final formKey = GlobalKey<FormState>();
  bool rememberMe=false;
  bool _passwordVisible = false;
  String emailError = '';
  String passwordError = '';
  TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  String em = '';
  String pas = '';

  final AuthController authController = Get.put(AuthController());




  @override
  void initState() {
    super.initState();

  }






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
                          constraints.maxHeight * 0.13,
                          constraints.maxWidth * 0.04,
                          0
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Log in",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                fontFamily: "Metropolis",
                                color: Colors.white,
                              ),
                            ),
                            const  SizedBox(height: 20),
                            const   Text(
                              "Hi, again.",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                fontFamily: "Metropolis",
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 50),
                            Form(
                              key: formKey,
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

                                    Container(

                                      child: TextFormField(

                                        controller: email,
                                        onChanged: (value) {
                                          setState(() {
                                            em=email.text;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Email is required';
                                          } else if (emailError != '') {
                                            return emailError;
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
                                          hintText: 'Enter your email',
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xffF7F9F9).withOpacity(0.5),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xff2C3A4A),
                                        ),
                                        style: TextStyle(color: Colors.white),
                                      ),
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
                                          pas=password.text;
                                        });
                                      },
                                      validator: (value) {
                                        if (passwordError != '') {
                                          return passwordError;
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
                                        hintText: 'Enter your password',
                                        hintStyle: TextStyle(
                                          fontSize: 15,
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
                                    SizedBox(height: constraints.maxWidth *0.03),
                                    Row(
                                      children: [

                                        SizedBox(width: constraints.maxWidth *0.5),
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: const Text(
                                            'Forgot password ?',
                                            style: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox( height: constraints.maxWidth *0.07,),

                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0,  constraints.maxWidth * 0.015, 0, 0),
                                      child: Container(
                                        height: 50,
                                        width: 700,
                                        child: TextButton(
                                          onPressed: () async {


                                            if (formKey.currentState!.validate()) {
                                              authController.logIn(em, pas).then((value)  async{
                                                if (authController.authResponse.value.toString() == "Invalid email") {
                                                  setState(() {
                                                    emailError = "Invalid email";
                                                    passwordError = "";
                                                  });
                                                } else if (authController.authResponse.value.toString() == "Wrong password") {
                                                  setState(() {
                                                    emailError = "";
                                                    passwordError = "Wrong password";
                                                  });
                                                } else {

                                                  setState(() {
                                                    emailError = "";
                                                    passwordError = "";
                                                  });
                                                }
                                              });
                                            } else {
                                              setState(() {
                                                emailError = "";
                                                passwordError = "";
                                              });
                                            }
                                          },

                                          child: Text(
                                            "Sign In",
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

                                        Padding(padding: EdgeInsets.fromLTRB(constraints.maxWidth * 0.1, constraints.maxWidth * 0.015, 0, 0),
                                          child: Text("You don't have an account ?",style: TextStyle(color: Color (0xffF7F9F9)),),
                                        ),


                                        Padding(
                                          padding:  EdgeInsets.fromLTRB(constraints.maxWidth * 0.02, constraints.maxWidth * 0.015, 0, 0),
                                          child: InkWell(
                                            onTap: () async {
                                            Get.to(()=> SignUp());

                                            },
                                            child: const Text(
                                              'Sign up.',
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
            }));
  }

}
