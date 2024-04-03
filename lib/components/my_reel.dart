import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyReel extends StatefulWidget {
  String url;
  MyReel({
    super.key,
    required this.url,
  });

  @override
  State<MyReel> createState() => _MyReelState();
}

class _MyReelState extends State<MyReel> {
  late VideoPlayerController _myVideoController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _myVideoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _myVideoController.initialize().then((value) {
      _myVideoController.play();
      _myVideoController.setLooping(true);
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _myVideoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_myVideoController);
  }
}
