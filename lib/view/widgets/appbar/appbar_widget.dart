import 'package:flutter/material.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/view/widgets/appbar/appbarmenu_widget.dart';
import 'package:luxoutlet/view/widgets/appbar/icon_widget.dart';
import 'package:luxoutlet/view/widgets/appbar/textfield_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? trailingPress;
  final IconData? leadingIconData;
  final IconData? trailingIconData;
  const AppBarWidget(
      {Key? key,
      this.title,
      @required this.leadingIconData,
      this.trailingIconData,
      this.trailingPress})
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(110);
  @override
  Widget build(BuildContext context) {
    // alignment: AlignmentDirectional.bottomCenter,
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(lightGreyColor),
          elevation: 0,
          flexibleSpace: Container(
            height: 110,
            decoration: const BoxDecoration(gradient: kLinearGradient),
            child: AppBarMenuItem(
              trailingPress: trailingPress,
              title: title,
              leadingIconData: leadingIconData,
              trailingIconData: trailingIconData,
            ),
          ),
        ),
        const Positioned(
            top: 88,
            left: 20,
            right: 20,
            child: CustomTextField(
              hintText: "what are you looking for?",
            ))
      ],
    );
  }
}

class AppBarMenuItem extends StatelessWidget {
  final String? title;
  final VoidCallback? trailingPress;
  final IconData? leadingIconData;
  final IconData? trailingIconData;
  const AppBarMenuItem({
    Key? key,
    this.title,
    @required this.leadingIconData,
    this.trailingIconData,
    this.trailingPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: InkWell(
            onTap: trailingPress,
            child: IconWidget(
                width: 16,
                height: 12,
                iconColor: Colors.white,
                icon: leadingIconData),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
          child: AppBarTitle(
            title: title,
          ),
        ),
        (trailingIconData != null)
            ? Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconWidget(
                  height: 16.31,
                  // width: 14.63,
                  icon: trailingIconData,
                  iconColor: Colors.white,
                  onPressed: () {},
                ),
              )
            : const SizedBox(
                width: 30,
              ),
      ],
    );
  }
}
