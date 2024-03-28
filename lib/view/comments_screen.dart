import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:provider/provider.dart';

import '../components/my_comment.dart';
import '../modals/user_modal.dart';
import '../view_modal/user_provider.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    UserModal user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyComment(),
          MyComment(),
          MyComment(),
        ],
      ),
      bottomNavigationBar: Container(
        height: kToolbarHeight,
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('ad'),
              radius: width * 0.05,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * 0.03,
                  right: width * 0.02,
                ),
                child: TextField(
                  decoration: InputDecoration(hintText: 'enter something'),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'Post',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
