import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/components/my_reel.dart';
import 'package:instagram_clone_firebase/utils/constants/padding.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  PageController _myPageController = PageController(initialPage: 0);
  int currentPage = 0;
  List<String> myVideosLink = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
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
                      color: Colors.transparent,
                      child: MyReel(
                        url: myVideosLink[index],
                      ),
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
                      body: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * mobileViewPadding,
                          vertical: height * 0.02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: width * 0.05,
                                        backgroundColor: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: width * 0.025,
                                      ),
                                      Text('Name')
                                    ],
                                  ),
                                  Text('Lorem Ipsum'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.music_note),
                                      Text('Music name is ...'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyIconWithStats(
                                  showStats: true,
                                  icon: Icon(
                                    Icons.favorite_outline,
                                    size: 23,
                                  ),
                                  stats: '28k',
                                ),
                                MyIconWithStats(
                                  showStats: true,
                                  icon: Icon(
                                    Icons.message_outlined,
                                    size: 25,
                                  ),
                                  stats: '18k',
                                ),
                                MyIconWithStats(
                                  showStats: true,
                                  icon: Icon(
                                    Icons.share_outlined,
                                    size: 25,
                                  ),
                                  stats: '1.3k',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class MyIconWithStats extends StatelessWidget {
  bool showStats;

  String stats;
  var icon;
  MyIconWithStats(
      {super.key,
      required this.showStats,
      required this.icon,
      this.stats = ''});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    return Column(
      children: [
        SizedBox(
          height: height * 0.035,
        ),
        icon,
        showStats ? Text(stats) : Container(),
      ],
    );
  }
}
