import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/utils/constants/padding.dart';
import 'package:instagram_clone_firebase/view_modal/user_provider.dart';
import 'package:provider/provider.dart';

import '../../upload_post/upload_post_data.dart';
import '../../utils/utils.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  var _postImage;

  TextEditingController _postDescription = TextEditingController();

  bool _loading = false;

  //dispose
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _postDescription.dispose();
  }

  //dialog box to select the image to upload_post
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
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
            ),
          ),
        ],
      ),
    );
  }

  //upload upload_post on firestore
  postIt(
    String description,
    String username,
    String profileImage,
    String uid,
  ) async {
    setState(() {
      _loading = true;
    });

    try {
      await uploadPostData(
          _postImage, uid, description, username, profileImage);
      _postDescription.text = '';
      setState(
        () {
          _loading = false;
        },
      );

      clearImage();
    } catch (e) {
      setState(
        () {
          _loading = false;
        },
      );
      Utils.showToastMessage(e.toString());
    }
  }

  // clear the selected image and show UPLOAD icon
  void clearImage() {
    setState(() {
      _postImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    // UserModal user = Provider.of<UserProvider>(context, listen: false).getUser;
    UserProvider user = Provider.of<UserProvider>(context, listen: false);
    print('build');
    return _postImage == null
        ? Center(
            child: IconButton(
              onPressed: () async {
                await chooseImage(context);
              },
              icon: Icon(
                Icons.upload,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: clearImage,
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(
                'Add Post',
              ),
              centerTitle: false,
              actions: [
                InkWell(
                  onTap: () {
                    return postIt(
                      _postDescription.text.toString(),
                      user.getUser.username.toString(),
                      user.getUser.imageUrl.toString(),
                      user.getUser.uid.toString(),
                    );
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.035,
                ),
              ],
            ),
            body: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * mobileViewPadding),
              child: Column(
                children: [
                  //show linear progress indicator
                  _loading
                      ? LinearProgressIndicator(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                          minHeight: 1.5,
                        )
                      : Container(),
                  //using padding to add some space above and below the row
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.01,
                      bottom: height * 0.01,
                    ),
                    child: Row(
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
                            textAlignVertical: TextAlignVertical.top,
                            maxLines: 4,
                            controller: _postDescription,
                            decoration: InputDecoration(
                              hintText: 'Write a caption...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          // child: Image.file(_postImage!),
                          child: _postImage != null
                              ? Image.file(_postImage!)
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          );
  }
}
