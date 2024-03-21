import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/responsive_dimensions.dart';
import 'package:provider/provider.dart';

import '../../view_modal/user_provider.dart';

class LayoutDeterminer extends StatefulWidget {
  Widget WebLayout;
  Widget MobileLayout;

  LayoutDeterminer({
    super.key,
    required this.WebLayout,
    required this.MobileLayout,
  });

  @override
  State<LayoutDeterminer> createState() => _LayoutDeterminerState();
}

class _LayoutDeterminerState extends State<LayoutDeterminer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUser();
  }

   getUser() async {
    UserProvider _userProvider = Provider.of<UserProvider>(context,listen: false);

    await _userProvider.updateUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > WebDimensions) {
          return widget.WebLayout;
        } else {
          return widget.MobileLayout;
        }
      },
    );
  }
}
