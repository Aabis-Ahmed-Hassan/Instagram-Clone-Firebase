import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/responsive_dimensions.dart';

class LayoutDeterminer extends StatelessWidget {
  Widget WebLayout;
  Widget MobileLayout;
  LayoutDeterminer({
    super.key,
    required this.WebLayout,
    required this.MobileLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > WebDimensions) {
          return WebLayout;
        } else {
          return MobileLayout;
        }
      },
    );
  }
}
