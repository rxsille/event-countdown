import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset('assets/quiet_town.svg'),
    );
  }
}