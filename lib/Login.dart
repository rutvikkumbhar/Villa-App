import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'Home.dart';
import 'Register.dart';
import 'Error.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final uid;
  User? user;
  bool loading=false;
  bool pass=true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5EFE7),
      body: ListView(
          children: [
        Form(
          key: _formKey,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                Container(
                  child: Lottie.asset("assets/Animations/Login_Page_Animation.json",repeat: true,height: 220,width: 220,fit: BoxFit.contain),
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email",prefixIcon: const Icon(Icons.alternate_email_rounded,color: Color(0xff3E5879)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter valid email!';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: pass?true:false,
                    decoration: InputDecoration(labelText: "Password",prefixIcon: const Icon(Icons.security_outlined,color: Color(0xff3E5879)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff393E46))),
                      floatingLabelStyle: const TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                          icon: pass?const FaIcon(FontAwesomeIcons.eyeSlash,size: 21,color: Color(0xff3E5879),):const FaIcon(FontAwesomeIcons.eye,size: 21,color: Color(0xffE52020),),
                          onPressed: (){
                            setState(() {
                              pass=pass?false:true;
                            });
                          }),
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter valid password!";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                  child: Container(
                    width: 250,height: 55,
                    decoration: BoxDecoration(color: Color(0xff213555),borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                        child: loading?CircularProgressIndicator(color: Colors.white,):Text("Log In",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 18)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading=true;
                            });
                            await _auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text).then((onValue) {
                              Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context) => Home()),
                                    (Route<dynamic> route) => false,);
                            }).onError((error, stackTrace) {
                              Error().toastMessage(error.toString());
                              setState(() {
                                loading=false;
                              });
                            });
                          }
                        }),
                  ),
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have any account? ",style: GoogleFonts.poppins(color: const Color(0xff3E5879).withValues(alpha:  0.7),fontSize: 13,fontWeight: FontWeight.w400),),
                    GestureDetector(
                      child: Text("sign up.",style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.blue)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return Registration();
                        }));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 90,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Villa",style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 23,color: Colors.black.withValues(alpha:  0.2)),),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
