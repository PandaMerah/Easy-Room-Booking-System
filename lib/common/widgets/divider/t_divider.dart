// create a widget that only function is to show a divider by using a container and the width should be the width of the screen and the height should be 1.0 and its color is grey
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class TDivider extends StatelessWidget {
  const TDivider({
    super.key,
    this.color = TColors.light,
    this.height = 3.0,
  });

  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      color: color,
    );
  }
}
