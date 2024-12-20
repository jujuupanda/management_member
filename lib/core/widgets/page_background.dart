import 'package:flutter/material.dart';

import '../utils/utils.dart';

class PageBackground extends StatelessWidget {
  const PageBackground({
    super.key,
    this.isWhite = false,
  });

  final bool? isWhite;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: isWhite == true ? PaletteColor().white : PaletteColor().softBlack,
      ),
    );
  }
}
