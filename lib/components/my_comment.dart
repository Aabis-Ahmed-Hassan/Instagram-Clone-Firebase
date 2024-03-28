import 'package:flutter/material.dart';

class MyComment extends StatelessWidget {
  const MyComment({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('asdf'),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: width * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'username',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              'The content of the comment will be shown here The content of the comment will be shown here The content of the comment will be shown here The content of the comment will be shown here ',
                          style: TextStyle(
                            height: height * 0.0018,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    '01,04,2024',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              width * 0.02,
            ),
            child: Icon(
              Icons.favorite,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
