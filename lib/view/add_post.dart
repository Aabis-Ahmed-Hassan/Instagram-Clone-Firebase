import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/utils/constants/padding.dart';
import 'package:instagram_clone_firebase/view_modal/user_provider.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? _postImage;
  // _chooseFile(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SimpleDialog(
  //           title: Text(
  //             'Create a Post',
  //           ),
  //           children: [
  //             SimpleDialogOption(
  //               child: Text(
  //                 'Take a Photo',
  //               ),
  //               onPressed: () async {
  //                 Navigator.pop(context);
  //                 _postImage = await Utils.pickImage(
  //                   ImageSource.camera,
  //                 );
  //                 // setState(() {});
  //               },
  //             ),
  //             SimpleDialogOption(
  //               child: Text(
  //                 'Choose from Gallery',
  //               ),
  //               onPressed: () async {
  //                 Navigator.pop(context);
  //                 _postImage = await Utils.pickImage(
  //                   ImageSource.gallery,
  //                 );
  //                 // setState(() {});
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  chooseImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text(
                'Pick an Image',
              ),
              children: [
                SimpleDialogOption(
                  onPressed: () async {
                    Navigator.pop(context);
                    _postImage = await Utils.pickImage(ImageSource.camera);
                    setState(() {});
                  },
                  child: Text(
                    'Capture a Picture',
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () async {
                    Navigator.pop(context);
                    _postImage = await Utils.pickImage(ImageSource.gallery);
                    setState(() {});
                  },
                  child: Text(
                    'Choose from Gallery',
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    UserProvider user = Provider.of<UserProvider>(context, listen: false);
    print('build');
    return _postImage == null
        ? Center(
            child: IconButton(
              onPressed: () => chooseImage(context),
              icon: Icon(
                Icons.upload,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: Icon(
                Icons.arrow_back,
              ),
              title: Text(
                'Add Post',
              ),
              centerTitle: false,
              actions: [
                Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: width * 0.035,
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * padding),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: width * 0.075,
                              backgroundImage: NetworkImage(
                                user.getUser.imageUrl.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Write a caption...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Image.file(_postImage!),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(),
                ],
              ),
            ));
  }
}
