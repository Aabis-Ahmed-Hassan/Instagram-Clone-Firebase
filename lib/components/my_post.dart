import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';

class MyPost extends StatelessWidget {
  const MyPost({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    double _myPostPadding = 0.045;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
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
                  backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/14260625/pexels-photo-14260625.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load'),
                  radius: width * 0.0575,
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Text(
                  'Username',
                ),
                Spacer(),
                Icon(
                  Icons.menu,
                ),
              ],
            ),
          ),
          Image(
            height: height * 0.35,
            width: double.infinity,
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://images.pexels.com/photos/14260625/pexels-photo-14260625.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load'),
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
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: width * _myPostPadding,
                      ),
                      child: Icon(Icons.messenger_outline_outlined),
                    ),
                    Icon(Icons.send),
                    Spacer(),
                    Icon(Icons.save),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Text(
                  '123,123 likes',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: height * 0.0055),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Username',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text:
                            '  This is the description of the post and I am Aabis Ahmed HAsssan . This is the descrition of the psot and I am aabis ahmed hassan. ',
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
                  '01/02/2023',
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
