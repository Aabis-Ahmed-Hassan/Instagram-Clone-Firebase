import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone_firebase/modals/user_modal.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/view/comments_screen.dart';
import 'package:instagram_clone_firebase/view_modal/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class MyPost extends StatefulWidget {
  final snapshot;

  MyPost({super.key, required this.snapshot});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    double _myPostPadding = 0.04;
    UserModal user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.0125),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: width * _myPostPadding,
              right: width * _myPostPadding,
              bottom: height * 0.0125,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.snapshot['profileImage'].toString()),
                  radius: width * 0.0575,
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Text(
                  widget.snapshot['username'].toString(),
                ),
                Spacer(),
                Icon(
                  Icons.more_vert,
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await Utils.likePost(widget.snapshot['postId'],
                  widget.snapshot['uid'], widget.snapshot['likes']);
            },
            child: Image(
              height: height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
              image: NetworkImage(widget.snapshot['postImageUrl'].toString()),
            ),
          ),
          SizedBox(height: height * 0.015),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * _myPostPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: width * _myPostPadding,
                      ),
                      child: InkWell(
                        onTap: () async {
                          await Utils.likePost(widget.snapshot['postId'],
                              user.uid.toString(), widget.snapshot['likes']);
                        },
                        child: widget.snapshot['likes']
                                .contains(user.uid.toString())
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border,
                              ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: width * _myPostPadding,
                      ),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CommentsScreen(postSnapshot: widget.snapshot),
                              ),
                            );
                          },
                          icon: Icon(Icons.messenger_outline_outlined)),
                    ),
                    Icon(Icons.send),
                    Spacer(),
                    Icon(FontAwesomeIcons.bookmark),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Text(
                  '${widget.snapshot['likes'].length.toString()} likes',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: height * 0.0055),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.snapshot['username'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '  ${widget.snapshot['description'].toString()}',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.0055),
                Text(
                  'View all 100 comments',
                  style: TextStyle(
                    color: secondaryColor,
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(
                      (widget.snapshot['datePublished'] as Timestamp).toDate()),
                  style: TextStyle(
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
