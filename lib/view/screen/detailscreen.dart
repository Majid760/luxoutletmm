import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/bloc/cart/cart_cubit.dart';
import 'package:luxoutlet/bloc/cart/cart_state.dart';
import 'package:luxoutlet/bloc/product/product_cubit.dart';
import 'package:luxoutlet/bloc/product/product_state.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/data/model/product.dart';
import 'package:luxoutlet/view/widgets/button_widget.dart';
import 'package:luxoutlet/view/widgets/favorite_widget.dart';
import 'package:luxoutlet/view/widgets/price_widget.dart';
import 'package:luxoutlet/view/widgets/productname_widget.dart';
import 'package:luxoutlet/view/widgets/rating_widget.dart';
import 'package:luxoutlet/view/widgets/rounded_image_widget.dart';
import 'package:luxoutlet/view/widgets/slider_widget.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  static const String routeName = '/detail_screen';

  const DetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Products product = ModalRoute.of(context)!.settings.arguments as Products;
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Container(
          color: const Color(0xFFEDEDED),
          child: ListView(
            padding: const EdgeInsets.only(
              top: 0.0,
              bottom: 60,
            ),
            children: [
              //appbar
              SliderWidget(
                  activeDotHeight: 8,
                  activeDotWidth: 8,
                  activeDotRadius: 8,
                  dotHeight: 8,
                  dotWidth: 8,
                  dotSpacing: 4,
                  totalDot: product.images!.length,
                  dotRadius: 8,
                  height: 415,
                  width: 375,
                  intColor: 0xFFC4C4C4,
                  sliderImageList: product.images),
              // product attribute section
              const ItemChraracteristicSection(),
              // Item detail section
              const ItemDetailSection(),
              // item  review section
              const ReviewsSection(),
              // Related product section
              const RelatedProductSection(),
            ],
          ),
        ),
        bottomNavigationBar: BottomSection(
          product: product,
          onBackPress: () {
            Navigator.pop(context);
          },
          onPress: () {
            displayModalBottomSheet(context, product);
          },
        ));
  }
}

class ImageSliderSectionProductDetail extends StatelessWidget {
  const ImageSliderSectionProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Products product;

  @override
  Widget build(BuildContext context) {
    return SliderWidget(
        activeDotHeight: 8,
        activeDotWidth: 8,
        activeDotRadius: 8,
        dotHeight: 8,
        dotWidth: 8,
        dotSpacing: 4,
        totalDot: product.images!.length,
        dotRadius: 8,
        height: 415,
        width: 375,
        intColor: 0xFFC4C4C4,
        sliderImageList: product.images);
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({
    Key? key,
    required this.product,
    this.onPress,
    this.onBackPress,
    this.isSetShadow = true,
  }) : super(key: key);

  final Products? product;
  final VoidCallback? onPress;
  final bool? isSetShadow;
  final VoidCallback? onBackPress;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 61,
        width: 375,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(4), topLeft: Radius.circular(4)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: (isSetShadow!)
                  ? const Color(0xFF6C6C6C).withOpacity(0.15)
                  : const Color(whiteColor),
              blurRadius: 4,
              offset: const Offset(4, 0.0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
                onTap: onBackPress,
                child: const SizedBox(
                    height: 15,
                    width: 18,
                    child: Icon(Icons.arrow_back_rounded,
                        color: Color(0xFfA4A4A4)))),
            ButtonWidget(onPress: onPress
                // trigger bottomsheet
                ),
            InkWell(
                splashColor: Colors.amber.shade200,
                onTap: () {},
                child: const Icon(Icons.favorite_border_rounded,
                    color: Color(darkGreyColor))
                // const Icon(Icons.favorite_rounded,
                //     color: Color(yellowColor))
                // : const Icon(Icons.favorite_border_rounded,
                //     color: Color(darkGreyColor)),
                ),
          ],
        ));
  }
}

class RelatedProductSection extends StatelessWidget {
  const RelatedProductSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C6C6C).withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0.0, 4), // changes position of shadow
            ),
          ],
        ),
        height: 300,
        width: 375,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 25,
              width: 150,
              padding: const EdgeInsets.only(top: 10),
              child: Text("Related Products",
                  style: GoogleFonts.workSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal)),
            ),
            const Expanded(
              child: RelatedItemProductWidget(),
            )
          ],
        ),
      ),
    );
  }
}

class RelatedItemProductWidget extends StatelessWidget {
  const RelatedItemProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, productState) => ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: productState.productList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Stack(clipBehavior: Clip.none, children: [
                  RoundedImage(
                    imagePath: productState.productList![index].images![0],
                    height: 133,
                    width: 136,
                    bgColor: 0xFFC4C4C4,
                  ),

                  // favorite widget
                  Positioned(
                    top: 115,
                    left: 100,
                    child: InkWell(
                      onTap: () {},
                      child: const FavoriteWidget(
                        iconColor: 0xFF000000,
                        // ? 0xFFF3AF00
                        // : 0xFF000000,
                      ),
                    ),
                  ),

                  // product characteristics section
                  Positioned(
                    top: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // rating widget
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: RatingWidget(
                            productRating: 5,
                            itemSize: 8,
                            itemPadding: 1,
                          ),
                        ),

                        // product name widget
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: ProductNameWidget(
                            width: 136,
                            title: productState.productList![index].name,
                            fontSize: 11,
                          ),
                        ),
                        PriceWidget(
                            fontColor: 0xFF000000,
                            price: productState.productList![index].price)
                      ],
                    ),
                  )
                ]),
              );
            }),
      ),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(extraDarkGreyColor).withOpacity(0.15),
                blurRadius: 4,
                offset: const Offset(0.0, 4), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        height: 224,
        width: 375,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                height: 20,
                width: 70,
                child: Text('Reviews',
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Colors.black)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    // height: 20,
                    // width: 70,
                    child: Text('View All',
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 10.5,
                            color: const Color(darkGreyColor))),
                  ),
                  const SizedBox(
                      // height: 20,
                      // width: 70,
                      child: Icon(Icons.arrow_forward_ios_outlined,
                          size: 11, color: Color(0xFFACACAC))),
                ],
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SizedBox(
                height: 20,
                width: 100,
                child: Text('Leslie Alexander',
                    style: GoogleFonts.workSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const RatingWidget(),
                // date section
                Text('Jan 21, 2021',
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 10.5,
                        color: const Color(darkGreyColor)))
              ],
            ),
            Container(
                padding: const EdgeInsets.only(top: 9),
                height: 60,
                width: 340,
                child: Text(
                    'Really cool and stylish light weight jacket, has 3 inside pockets and feels strong. The fitting is good and not too loose, quite warm but definitely not for winter.',
                    style: GoogleFonts.workSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal))),
            SizedBox(
              height: 30,
              width: 340,
              child: Text('535 people found this review useful',
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 11,
                      color: Colors.black)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('comments',
                    style: GoogleFonts.workSans(
                        fontSize: 11,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      // height: 20,
                      // width: 70,
                      child: Text('Helpful',
                          style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 10.5,
                              color: const Color(0xFFACACAC))),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: SizedBox(
                          // height: 20,
                          // width: 70,
                          child: Icon(Icons.thumb_up_alt_outlined,
                              size: 12, color: Color(0xFFACACAC))),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ItemChraracteristicSection extends StatefulWidget {
  const ItemChraracteristicSection({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemChraracteristicSection> createState() =>
      _ItemChraracteristicSectionState();
}

class _ItemChraracteristicSectionState
    extends State<ItemChraracteristicSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 26, top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C6C6C).withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0.0, 4), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating,review an stock section
          Row(
            children: [
              const RatingWidget(
                itemPadding: 0,
                itemSize: 13,
                productRating: 5,
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(left: 10),
                height: 13,
                width: 68,
                child: Text('126 reviews',
                    style: GoogleFonts.workSans(
                        fontStyle: FontStyle.normal,
                        color: const Color(darkGreyColor),
                        fontWeight: FontWeight.w500,
                        fontSize: 11.5)),
              )),
              Text('In Stock',
                  style: GoogleFonts.workSans(
                      fontStyle: FontStyle.normal,
                      color: const Color(greenColor),
                      fontWeight: FontWeight.w500,
                      fontSize: 11.5)),
            ],
          )
          // Product Name sectioin
          ,
          Padding(
            padding: const EdgeInsets.only(top: 13.3),
            child: SizedBox(
              height: 42,
              width: 332,
              child: Text(
                  'Polo Ralph Lauren wind breaker jacket - classic style - light blue',
                  style: GoogleFonts.workSans(
                      fontStyle: FontStyle.normal,
                      color: const Color(0xFF464646),
                      fontWeight: FontWeight.w500,
                      fontSize: 18)),
            ),
          ),
          // price section
          const PriceWidget(
            height: 21,
            width: 110,
            price: 80.00,
            oldPrice: 200.0,
            oldPriceFontSize: 15,
            fontSize: 18,
            fontColor: 0xFF464646,
          ),

          // product colors section
          const ColorSection(),
          // product size section
          const ProductSizeSection(),
        ],
      ),
    );
  }
}

class ItemDetailSection extends StatelessWidget {
  const ItemDetailSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C6C6C).withOpacity(0.15),
                blurRadius: 4,
                offset: const Offset(0.0, 4), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        height: 153,
        width: 374,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              width: 100,
              child: Text('Item Details',
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Colors.black)),
            ),
            Container(
                padding: const EdgeInsets.only(top: 9),
                height: 60,
                width: 340,
                child: Text(
                    'Light blue jacket by Polo Ralph Lauren. Button neck with spread collar. Zip placket. Embroidered logo to chest and cuff Side pockets/ Elasticated hem.',
                    style: GoogleFonts.workSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal))),
            SizedBox(
              height: 30,
              width: 340,
              child: Text('True to size. Model wears: UK S/ EU S/ US',
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 11,
                      color: Colors.black)),
            ),
            Align(
              child: InkWell(
                onTap: () {},
                child: const SizedBox(
                  height: 6,
                  width: 10,
                  child: Icon(Icons.keyboard_arrow_down_sharp,
                      color: Color(0xFFACACAC)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductSizeSection extends StatefulWidget {
  const ProductSizeSection({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductSizeSection> createState() => _ProductSizeSectionState();
}

class _ProductSizeSectionState extends State<ProductSizeSection> {
  int? sizeIndex;
  List<String> productSizes = ['XXS', 'XS', 'S', 'M', 'L', 'XL'];
  @override
  void initState() {
    super.initState();
    sizeIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 55,
          height: 16,
          child: Text('Sizes',
              style: GoogleFonts.workSans(
                fontSize: 14,
                fontStyle: FontStyle.normal,
                color: const Color(darkGreyColor),
                fontWeight: FontWeight.w500,
              ))),
      Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: productSizes.asMap().entries.map((entry) {
              int index = entry.key;
              return InkWell(
                onTap: () {
                  setState(() => sizeIndex = index % 6);
                },
                child: Container(
                    height: 47,
                    width: 47,
                    child: Center(
                      child: Text(entry.value,
                          style: GoogleFonts.workSans(
                              color: (index == sizeIndex)
                                  ? const Color(whiteColor)
                                  : const Color(blackColor),
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500)),
                    ),
                    decoration: BoxDecoration(
                      color: (index == sizeIndex)
                          ? const Color(yellowColor)
                          : const Color(whiteColor),
                      border: Border.all(
                          color: (index == sizeIndex)
                              ? const Color(yellowColor)
                              : const Color(greyColor)),
                      borderRadius: BorderRadius.circular(8),
                    )),
              );
            }).toList()),
      ),
    ]);
  }
}

// color section of detail screen
class ColorSection extends StatefulWidget {
  const ColorSection({
    Key? key,
  }) : super(key: key);

  @override
  State<ColorSection> createState() => _ColorSectionState();
}

class _ColorSectionState extends State<ColorSection> {
  int? colorIndex;

  List<String> imagesOfColors = [
    'assets/images/color1.png',
    'assets/images/color2.png',
    'assets/images/color3.png',
    'assets/images/color4.png',
    'assets/images/color5.png',
    'assets/images/color6.png',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
            width: 55,
            height: 16,
            child: Text('Colours',
                style: GoogleFonts.workSans(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  color: const Color(darkGreyColor),
                  fontWeight: FontWeight.w500,
                ))),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: imagesOfColors.asMap().entries.map((entry) {
                int index = entry.key;
                return InkWell(
                  onTap: () {
                    setState(() => colorIndex = index % 6);
                  },
                  child: RoundedImage(
                      imagePath: entry.value,
                      height: 47,
                      width: 47,
                      borderRadius: 8,
                      borderColor:
                          (index == colorIndex) ? yellowColor : (whiteColor)),
                );
              }).toList()),
        ),
      ]),
    );
  }
}

// bottom sheet
void displayModalBottomSheet(context, Products product) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext bc) {
        return Container(
            color: Colors.transparent,
            child: Container(
              height: 570,
              width: 375,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24)),
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 29),
                  child: Column(
                    children: [
                      // product name , price ,image
                      SizedBox(
                        height: 93,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedImage(
                                width: 81,
                                height: 93,
                                borderRadius: 8,
                                imagePath: product.images![0]),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 59,
                                    width: 200,
                                    child: Text(product.name.toString(),
                                        style: GoogleFonts.workSans(
                                            fontSize: 14,
                                            color: const Color(0xFF868686),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal)),
                                  ),
                                  SizedBox(
                                      width: 65,
                                      height: 21,
                                      child: PriceWidget(
                                          price: product.price,
                                          fontSize: 18,
                                          fontColor: 0xFF464646))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // product Color section
                      const Padding(
                        padding: EdgeInsets.only(right: 19.0),
                        child: ColorSection(),
                      ),

                      // color section
                      const Padding(
                        padding: EdgeInsets.only(right: 19),
                        child: ProductSizeSection(),
                      ),
                      // back button, add cart button , favorite section
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: BlocBuilder<CartCubit, CartState>(
                    bloc: Provider.of<CartCubit>(context),
                    builder: (context, state) => BottomSection(
                      isSetShadow: false,
                      product: product,
                      onPress: () {
                        context.read<CartCubit>().addProductToCart(product);
                        Fluttertoast.showToast(
                            msg: "Product Added Successfully",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor:
                                const Color(darkGreyColor).withOpacity(0.7),
                            textColor: const Color(whiteColor),
                            fontSize: 12.0);
                        Navigator.pop(context);
                      },
                      onBackPress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ]),
            ));
      });
}
