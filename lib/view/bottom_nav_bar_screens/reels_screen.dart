import 'package:flutter/material.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  PageController _myPageController = PageController(initialPage: 0);
  int currentPage = 0;
  List<Color> myColors = [
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.green,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: 5,
            scrollDirection: Axis.vertical,
            controller: _myPageController,
            onPageChanged: (int index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    color: myColors[index],
                  ),
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      title: Text(
                        'Reels',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('adfadf'),
                              Text('adfadf'),
                              Text('adfadf'),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text('adfadf'),
                            Spacer(),
                            Text('adfadf'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    ));
  }
}
