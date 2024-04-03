import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/modals/user_modal.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/utils/constants/padding.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';
import 'package:instagram_clone_firebase/view_modal/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _myEditController = TextEditingController();
  showDialogBox(
      BuildContext context, String keyName, String previousValue, String uid) {
    _myEditController.text = previousValue;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextFormField(
            controller: _myEditController,
            decoration: InputDecoration(
              hintText: 'Enter Text to Update',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('Users').doc(uid).update({
                  keyName: _myEditController.text,
                }).then(
                  (value) {
                    Utils.showToastMessage('Updated');
                    Navigator.pop(context);

                    setState(() {});
                  },
                ).onError(
                  (error, stackTrace) {
                    Utils.showToastMessage(error.toString());
                  },
                );
              },
              child: Text('Update'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    UserModal _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: width * mobileViewPadding),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    showDialogBox(context, 'username',
                        _user.username.toString(), _user.uid.toString());
                  },
                  title: Text('Username'),
                  subtitle: Text(_user.username.toString()),
                  trailing: Icon(
                    Icons.edit,
                  ),
                ),
                ListTile(
                  onTap: () {
                    showDialogBox(context, 'bio', _user.bio.toString(),
                        _user.uid.toString());
                  },
                  title: Text('Bio'),
                  subtitle: Text(
                    _user.bio.toString(),
                  ),
                  trailing: Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
