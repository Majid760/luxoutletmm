import 'package:flutter/material.dart';
import 'package:luxoutlet/data/model/product.dart';
import 'package:luxoutlet/view/screen/detailscreen.dart';
import 'package:luxoutlet/view/widgets/product_widget.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({Key? key, required this.products, final product})
      : super(key: key);

  final List<Products>? products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 90),
      itemCount: products!.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, DetailScreen.routeName,
                arguments: products![index]);
          },
          child: ProductWidget(
            productName: products![index].name,
            productPath: products![index].images!.first.trimLeft(),
            productDiscount: products![index].discount,
            productPrice: products![index].price,
            productOldPrice: products![index].oldPrice,
            productRating: products![index].rating,
            product: products![index],
          ),
        );
      },
    );
  }
}
