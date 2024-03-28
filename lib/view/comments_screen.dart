import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';
import 'package:provider/provider.dart';

import '../components/my_comment.dart';
import '../modals/user_modal.dart';
import '../view_modal/user_provider.dart';

class CommentsScreen extends StatefulWidget {
  final postSnapshot;

  CommentsScreen({super.key, required this.postSnapshot});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final _commentController = TextEditingController();

  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  //show loading instead of 'Post' when the user clicks on 'Post'.
  bool loading = false;

  Future<void> postTheComment(String uid, String postId, String profileImageUrl,
      String username, String comment) async {
    setState(() {
      loading = true;
    });

    await Utils.addComment(
      uid,
      postId,
      profileImageUrl,
      username,
      comment,
    );

    setState(() {
      loading = false;
    });
  }

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
      body: Expanded(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Posts')
              .doc(widget.postSnapshot['postId'])
              .collection('Comments')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                  commentSnapshot) {
            if (commentSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              print(commentSnapshot.data!.docs.length);

              return ListView.builder(
                  itemCount: commentSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return MyComment(
                        snapshot: commentSnapshot.data!.docs[index]);
                  });
            }
          },
        ),
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
              backgroundImage: NetworkImage(
                user.imageUrl.toString(),
              ),
              radius: width * 0.05,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * 0.03,
                  right: width * 0.02,
                ),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                      hintText: 'Comment as ${user.username.toString()}'),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await postTheComment(
                  user.uid.toString(),
                  widget.postSnapshot['postId'],
                  user.imageUrl.toString(),
                  user.username.toString(),
                  _commentController.text.toString(),
                );
              },
              child: loading
                  ? CircularProgressIndicator(
                      color: Colors.blue,
                    )
                  : Text(
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
