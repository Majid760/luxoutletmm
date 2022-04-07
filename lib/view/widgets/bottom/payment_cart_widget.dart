import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/bloc/cart/cart_cubit.dart';
import 'package:luxoutlet/bloc/cart/cart_state.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/utility/currency_symbol_utility.dart';
import 'package:provider/provider.dart';

class FloatingPaymentCarWidget extends StatelessWidget {
  const FloatingPaymentCarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 117,
        height: 52,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: kLinearGradient,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
              height: 21.75,
              width: 21.75,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              )),
          const SizedBox(
            width: 6.62,
          ),
          BlocBuilder<CartCubit, CartState>(
            bloc: context.read<CartCubit>(),
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 14,
                    width: 47,
                    child: Text('${currency(context)}' '${state.total}',
                        style: GoogleFonts.workSans(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                        ))),
                SizedBox(
                    height: 14,
                    width: 47,
                    child: Text('${state.cartProductList!.length}',
                        style: GoogleFonts.workSans(
                          fontSize: 12,
                          color: const Color(whiteColor).withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                        )))
              ],
            ),
          ),
        ]));
  }
}
