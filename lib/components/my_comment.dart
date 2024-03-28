import 'package:flutter/material.dart';

class MyComment extends StatefulWidget {
  final snapshot;
  MyComment({super.key, required this.snapshot});

  @override
  State<MyComment> createState() => _MyCommentState();
}

class _MyCommentState extends State<MyComment> {
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
            backgroundImage: NetworkImage(widget.snapshot['profileImageUrl']),
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
                          text: widget.snapshot['username'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  ${widget.snapshot['comment']}',
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
