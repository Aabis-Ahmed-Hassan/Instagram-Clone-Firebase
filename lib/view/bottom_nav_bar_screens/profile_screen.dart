import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isFollowing = false;
  bool isLoading = false;
  bool isOwner = false;
  int numberOfPosts = -1;
  QuerySnapshot<Map<String, dynamic>>? allPosts;
  int numberOfFollowers = -1;
  int numberOfFollowing = -1;

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

    //fetch user details like image, username, bio
    var dataFromFirestore = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.uid)
        .get();

    userDetails = dataFromFirestore.data()!;

    //update number of posts
    allPosts = await FirebaseFirestore.instance
        .collection('Posts')
        .where('uid', isEqualTo: widget.uid)
        .get();

    numberOfPosts = allPosts!.docs.length;

    //update number of followers

    numberOfFollowers = dataFromFirestore['followers'].length;
    //update number of following

    numberOfFollowing = dataFromFirestore['following'].length;

//checks if the user is the owner of the profile
    if (FirebaseAuth.instance.currentUser!.uid == widget.uid) {
      isOwner = true;
    } else {
      isOwner = false;
    }

    //checks if the user follows this profile or not

    if (dataFromFirestore['followers']
        .contains(FirebaseAuth.instance.currentUser!.uid)) {
      isFollowing = true;
    } else {
      isFollowing = false;
    }

    //remove loading (Circular Progress Indicator)
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
                            width: width * 0.075,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyStats(amount: numberOfPosts, title: 'Posts'),
                                MyStats(
                                    amount: numberOfFollowers,
                                    title: 'Followers'),
                                MyStats(
                                    amount: numberOfFollowing,
                                    title: 'Following'),
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
                        height: height * 0.03,
                      ),

                      //follow/unfollow/edit_profile/share_profile button

                      isOwner
                          ? Row(
                              children: [
                                Expanded(
                                  child: MyFollowButtonForProfileScreen(
                                    title: 'Edit Profile',
                                    onTap: () {},
                                    isLeftButton: true,
                                  ),
                                ),
                                Expanded(
                                  child: MyFollowButtonForProfileScreen(
                                    title: 'Share Profile',
                                    onTap: () {},
                                    isLeftButton: false,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                isFollowing
                                    ? Expanded(
                                        child: MyFollowButtonForProfileScreen(
                                          title: 'Following',
                                          onTap: () {},
                                          isLeftButton: true,
                                        ),
                                      )
                                    : Expanded(
                                        child: MyFollowButtonForProfileScreen(
                                          title: 'Follow',
                                          onTap: () {},
                                          isLeftButton: true,
                                        ),
                                      ),
                                Expanded(
                                  child: MyFollowButtonForProfileScreen(
                                    title: 'Message',
                                    onTap: () {},
                                    isLeftButton: false,
                                  ),
                                ),
                              ],
                            ),

                      SizedBox(
                        height: height * 0.03,
                      ),
                      //highlights section
                      isOwner
                          ? Column(
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
                                Text('New')
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: height * 0.03,
                      ),

                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("Posts")
                            .where(
                              'uid',
                              isEqualTo: widget.uid,
                            )
                            .get(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return GridView.builder(
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: width * 0.02,
                                mainAxisSpacing: height * 0.01,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    snapshot.data!.docs[index]['postImageUrl'],
                                  ),
                                );
                              },
                            );
                          }
                        },
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
  var title, amount;

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
          amount.toString(),
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
