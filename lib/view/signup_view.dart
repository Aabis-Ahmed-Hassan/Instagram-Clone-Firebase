import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_firebase/components/my_auth_button.dart';
import 'package:instagram_clone_firebase/components/my_text_form_field.dart';
import 'package:instagram_clone_firebase/res/app_auth.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';

import '../utils/Routes/route_names.dart';

class SignupView extends StatefulWidget {
  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  File? pickedImage;
  void selectImage() async {
    File response = await Utils.addPhoto(ImageSource.camera);
    setState(() {
      pickedImage = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spacer(),

                //show instagram logo
                SvgPicture.asset(
                  'assets/images/instagram_logo.svg',
                  color: primaryColor,
                  height: height * 0.075,
                ),
                SizedBox(
                  height: height * 0.035,
                ),

                //show profile image
                InkWell(
                  onTap: () {
                    selectImage();
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      pickedImage == null
                          ? CircleAvatar(
                              radius: width * 0.16,
                              child: Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 50,
                              ),
                              backgroundColor: primaryColor.withOpacity(0.3),
                            )
                          : CircleAvatar(
                              radius: width * 0.16,
                              backgroundImage: FileImage(pickedImage!),
                            ),
                      Positioned(
                        // bottom: -10,
                        right: width * 0.02,
                        bottom: height * 0.012,
                        child: Container(
                          height: height * 0.0325,
                          width: height * 0.0325,
                          decoration: BoxDecoration(
                            // color: primaryColor,
                            border: Border.all(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: Icon(
                            size: 15,
                            Icons.add_a_photo,
                            // color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.035,
                ),

                //enter username
                MyTextFormField(
                  hintText: 'Enter your username',
                  controller: _usernameController,
                  inputType: TextInputType.text,
                  obscureText: false,
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                //enter email
                MyTextFormField(
                    hintText: 'Enter your email',
                    controller: _emailController,
                    inputType: TextInputType.emailAddress,
                    obscureText: false),
                SizedBox(
                  height: height * 0.035,
                ),
                //enter password
                MyTextFormField(
                    hintText: 'Enter your password',
                    controller: _passwordController,
                    inputType: TextInputType.text,
                    obscureText: true),
                SizedBox(
                  height: height * 0.035,
                ),
                //enter bio
                MyTextFormField(
                    hintText: 'Enter your bio',
                    controller: _bioController,
                    inputType: TextInputType.text,
                    obscureText: false),
                SizedBox(
                  height: height * 0.035,
                ),
                //sign up button
                MyAuthButton(
                  onTap: () async {
                    print('tapped');
                    String response = await AppAuth().signupUser(
                      _emailController.text,
                      _passwordController.text,
                      _usernameController.text,
                      _bioController.text,
                    );
                    print(response);
                    print('tapped');
                  },
                  title: 'Sign Up',
                ),
                // Spacer(),
                //don't have an account text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Alread have an account?  "),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.login);
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.035,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
