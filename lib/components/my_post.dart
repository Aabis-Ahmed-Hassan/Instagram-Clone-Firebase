import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone_firebase/modals/user_modal.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/utils/constants/padding.dart';
import 'package:instagram_clone_firebase/view/bottom_nav_bar_screens/profile_screen.dart';
import 'package:instagram_clone_firebase/view/comments_screen.dart';
import 'package:instagram_clone_firebase/view_modal/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/constants/responsive_dimensions.dart';
import '../utils/utils.dart';

class MyPost extends StatefulWidget {
  final snapshot;

  MyPost({super.key, required this.snapshot});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  Future<void> deletePost(String postId, String currentUserUID) async {
    if (currentUserUID == widget.snapshot['uid']) {
      await Utils.deletePost(postId);
    } else {
      Utils.showToastMessage(
          "You can't delete this post because it's not your post. ");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    double _myPostPadding = 0.04;
    UserModal user = Provider.of<UserProvider>(context).getUser;
    return Container(
      decoration: BoxDecoration(
          border: width > WebDimensions
              ? Border.all(
                  width: 1,
                  color: Colors.white,
                )
              : null),
      padding: EdgeInsets.symmetric(vertical: height * 0.0125),
      margin: width > WebDimensions
          ? EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * webViewPadding,
            )
          : null,
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          uid: widget.snapshot['uid'],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl:
                                widget.snapshot['profileImage'].toString(),
                            placeholder: (context, url) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                        radius: width > WebDimensions
                            ? width * 0.015
                            : width * 0.0575,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        widget.snapshot['username'].toString(),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        height: height * 0.035,
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                        ),
                        onTap: () async {
                          await deletePost(
                            widget.snapshot['postId'],
                            user.uid.toString(),
                          );
                        },
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await Utils.likePost(widget.snapshot['postId'],
                  user.uid.toString(), widget.snapshot['likes']);
            },
            child: Container(
                height: height * 0.35,
                width: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.snapshot['postImageUrl'].toString(),
                  placeholder: (context, url) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )),
            // child: Image(
            //   height: height * 0.35,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            //   image: NetworkImage(widget.snapshot['postImageUrl'].toString()),
            // ),
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
                                builder: (context) => CommentsScreen(
                                    postSnapshot: widget.snapshot),
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
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: '  ${widget.snapshot['description'].toString()}',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.0055),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CommentsScreen(postSnapshot: widget.snapshot),
                      ),
                    );
                  },
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Posts')
                          .doc(widget.snapshot['postId'])
                          .collection('Comments')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              commentCountSnapshot) {
                        if (commentCountSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            'Loading...',
                            style: TextStyle(
                              color: tertiaryColor,
                            ),
                          );
                        } else {
                          if (commentCountSnapshot.data!.docs.length == 0) {
                            return Text(
                              'No Comments Yet.',
                              style: TextStyle(
                                color: tertiaryColor,
                              ),
                            );
                          } else {
                            return Text(
                              'View all ${commentCountSnapshot.data!.docs.length.toString()} comments',
                              style: TextStyle(
                                color: tertiaryColor,
                              ),
                            );
                          }
                        }
                      }),
                ),
                Text(
                  DateFormat.yMMMd().format(
                      (widget.snapshot['datePublished'] as Timestamp).toDate()),
                  style: TextStyle(
                    color: tertiaryColor,
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
