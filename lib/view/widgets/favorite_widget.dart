import 'package:flutter/material.dart';
import 'package:luxoutlet/const/color.dart';

class FavoriteWidget extends StatelessWidget {
  final int? iconColor;
  const FavoriteWidget({Key? key, this.iconColor = 0xFF000000})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(60)),
        ),
        child: Icon(
            (iconColor == blackColor) ? Icons.favorite_border : Icons.favorite,
            color: Color(iconColor!)));
  }
}
