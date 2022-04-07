import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luxoutlet/bloc/cart/cart_cubit.dart';
import 'package:luxoutlet/bloc/cart/cart_state.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/data/model/product.dart';
import 'package:luxoutlet/view/widgets/discount_widget.dart';
import 'package:luxoutlet/view/widgets/favorite_widget.dart';
import 'package:luxoutlet/view/widgets/price_widget.dart';
import 'package:luxoutlet/view/widgets/productname_widget.dart';
import 'package:luxoutlet/view/widgets/rating_widget.dart';
import 'package:luxoutlet/view/widgets/rounded_image_widget.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final Products? product;
  final String? productPath;
  final double? productDiscount;
  final double? productRating;
  final double? height;
  final double? width;
  final String? productName;
  final double? productPrice;
  final double? productOldPrice;
  const ProductWidget(
      {Key? key,
      this.productPath,
      this.productDiscount,
      this.productRating,
      this.productName,
      this.productPrice,
      this.productOldPrice,
      this.product,
      this.height = 159,
      this.width = 163})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Stack(clipBehavior: Clip.none, children: [
        RoundedImage(
          imagePath: productPath,
          height: height,
          width: width,
          borderRadius: 8,
        ),
        Positioned(
            top: 23,
            child: (productDiscount != null)
                ? DiscountWidget(
                    discount: productDiscount,
                  )
                : const SizedBox()),

        // favorite widget
        Positioned(
          top: 144,
          left: 120,
          child: BlocConsumer<CartCubit, CartState>(
            bloc: context.read<CartCubit>(),
            listenWhen: (preState, state) => preState != state,
            listener: (context, state) {},
            builder: (context, state) => InkWell(
              onTap: () {
                context.read<CartCubit>().addProductToFavorite(product!);
              },
              child: FavoriteWidget(
                iconColor: state.favoriteProducts!.contains(product!)
                    ? yellowColor
                    : blackColor,
              ),
            ),
          ),
        ),

        // product characteristics section
        Positioned(
          top: 165,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // rating widget
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RatingWidget(
                  productRating: productRating,
                ),
              ),

              // product name widget
              ProductNameWidget(
                title: productName,
              ),

              // product price widget
              (productOldPrice == null)
                  ? const SizedBox()
                  : PriceWidget(
                      price: productPrice,
                      oldPrice: productOldPrice,
                    )
            ],
          ),
        )
      ]),
    );
  }
}
