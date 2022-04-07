import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingWidget extends StatelessWidget {
  final double? productRating;
  final double? itemSize;
  final double? itemPadding;
  const RatingWidget({
    Key? key,
    this.callback,
    this.itemSize = 10,
    this.productRating = 5,
    this.itemPadding = 2.5,
  }) : super(key: key);
  final void Function(int)? callback;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: RatingBar.builder(
          initialRating: productRating!,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: itemSize!,
          itemPadding: EdgeInsets.symmetric(horizontal: itemPadding!),
          itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
          onRatingUpdate: (rating) {}),
    );
  }
}
