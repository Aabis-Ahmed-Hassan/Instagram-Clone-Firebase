import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/utils/constants/padding.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
  ProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userDetails = {};

  bool isLoading = false;

  String posts = '-1';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    var dataFromFirestore = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.uid)
        .get();

    userDetails = dataFromFirestore.data()!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: mobileBackgroundColor,
              title: Text(
                userDetails['username'],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  width: width * padding,
                ),
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //profile_image & followers/following,posts
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: height * 0.05,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              userDetails['imageUrl'],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyStats(amount: posts, title: 'Posts'),
                                MyStats(amount: '0', title: 'Followers'),
                                MyStats(amount: '0', title: 'Followers'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),

                      //username
                      Text(
                        userDetails['username'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      //bio
                      Text(
                        userDetails['bio'],
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      //follow/unfollow/edit_profile/share_profile button
                      Row(
                        children: [
                          Expanded(
                            child: MyFollowButtonForProfileScreen(
                              title: 'Follow',
                              onTap: () {},
                              isLeftButton: true,
                            ),
                          ),
                          Expanded(
                            child: MyFollowButtonForProfileScreen(
                              title: 'Follow',
                              onTap: () {},
                              isLeftButton: false,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: height * 0.02,
                      ),
                      //highlights section
                      Column(
                        children: [
                          Container(
                            height: height * 0.075,
                            width: height * 0.075,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              border: Border.all(
                                width: 1,
                                color: primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.add,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      InkWell(
                        onTap: () {
                          print(userDetails);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.red,
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

class MyStats extends StatelessWidget {
  String title, amount;
  MyStats({
    super.key,
    required this.amount,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
        ),
        Text(
          title,
        ),
      ],
    );
  }
}

class MyFollowButtonForProfileScreen extends StatelessWidget {
  String title;
  VoidCallback? onTap;
  bool isLeftButton;
  MyFollowButtonForProfileScreen(
      {super.key,
      required this.title,
      required this.onTap,
      required this.isLeftButton});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: isLeftButton
            ? EdgeInsets.only(
                right: width * 0.01,
              )
            : EdgeInsets.only(
                left: width * 0.01,
              ),
        padding: EdgeInsets.symmetric(
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
