import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_firebase/auth/sign_up_user.dart';
import 'package:instagram_clone_firebase/components/my_auth_button.dart';
import 'package:instagram_clone_firebase/components/my_text_form_field.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/utils/constants/padding.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';

import '../utils/Routes/route_names.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _bioFocusNode = FocusNode();

  var formKey = GlobalKey<FormState>();

  bool _loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _bioFocusNode.dispose();
    _usernameFocusNode.dispose();
  }

  void signUpUser() async {
    setState(() {
      _loading = true;
    });
    String response = await SignUpUser().signUpUser(
        _emailController.text,
        _passwordController.text,
        _usernameController.text,
        _bioController.text,
        pickedImage!, //*
        context);

    setState(() {
      _loading = false;
    });
    if (kDebugMode) {
      print(response);
    }
  }

  File? pickedImage;

  void selectImage() async {
//allow user to pick image and then return the picked image
    File response = await Utils.pickImage(ImageSource.camera);
    //update default profile photo with user's image
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
            horizontal: width * padding,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spacer(),

                SizedBox(
                  height: height * 0.065,
                ),
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

                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      //enter username
                      MyTextFormField(
                        hintText: 'Enter your username',
                        controller: _usernameController,
                        inputType: TextInputType.text,
                        obscureText: false,
                        focusNode: _usernameFocusNode,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'Username should be atleast 6 characters';
                          }
                        },
                        onFieldSubmitted: (value) {
                          Utils.changeFocusNode(
                              context, _usernameFocusNode, _emailFocusNode);
                        },
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      //enter email
                      MyTextFormField(
                        hintText: 'Enter your email',
                        focusNode: _emailFocusNode,
                        controller: _emailController,
                        inputType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (value) {
                          bool isValidEmail =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value);

                          if (value == null || value.isEmpty) {
                            return ' Please enter your email';
                          } else if (!isValidEmail) {
                            return 'Please enter a valid email address';
                          }
                        },
                        onFieldSubmitted: (value) {
                          Utils.changeFocusNode(
                              context, _emailFocusNode, _passwordFocusNode);
                        },
                      ),

                      SizedBox(
                        height: height * 0.035,
                      ),
                      //enter password
                      MyTextFormField(
                        hintText: 'Enter your password',
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        inputType: TextInputType.text,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'Password should be atleast 6 characters';
                          }
                        },
                        obscureText: true,
                        onFieldSubmitted: (value) {
                          Utils.changeFocusNode(
                              context, _passwordFocusNode, _bioFocusNode);
                        },
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      //enter bio
                      MyTextFormField(
                        hintText: 'Enter your bio',
                        controller: _bioController,
                        focusNode: _bioFocusNode,
                        inputType: TextInputType.text,
                        validator: (value) {
                          if (value.length < 20) {
                            return 'Username should be atleast 20 characters';
                          }
                        },
                        obscureText: false,
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                    ],
                  ),
                ),
                //sign up button
                MyAuthButton(
                  onTap: signUpUser,
                  // onTap: () async {
                  //   if (formKey.currentState!.validate()) {
                  //     signupUser();
                  //   }
                  // },
                  title: 'Sign Up',
                  loading: _loading,
                ),

                SizedBox(
                  height: height * 0.065,
                ),

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
