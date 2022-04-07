import 'package:flutter/material.dart';
import 'package:luxoutlet/const/color.dart';

class AppBarTitle extends StatelessWidget {
  final String? title;
  const AppBarTitle({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: (title == null)
          ? RichText(
              text: const TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                // style: Theme.of(context).textTheme.headline6,
                children: <TextSpan>[
                  TextSpan(
                      text: 'Lux',
                      style: TextStyle(
                          color: Color(redColor),
                          fontSize: 18,
                          fontFamily: "Montserrat",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: 'Outlet',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Montserrat",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    child: RichText(
                        text: const TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  // style: Theme.of(context).textTheme.headline6,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Lux',
                        style: TextStyle(
                            color: Color(redColor),
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700)),
                    TextSpan(
                        text: 'Outlet',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ],
                ))),
                Text(title!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Montserrat",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700))
              ],
            ),
    );
  }
}
