// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';

import '../model/app_responsive.dart';
import '../model/constant.dart';

class MenuList extends StatefulWidget {
  final dynamic mediaQueryData;

  const MenuList({super.key, required this.mediaQueryData});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  final _items = [
    'assets/banners/banner1.jpg',
    'assets/banners/banner2.jpg',
    'assets/banners/banner3.png',
    'assets/food/meal1.jpeg',
    'assets/food/meal2.jpeg',
    'assets/food/meal3.jpeg',
    'assets/food/meal4.jpeg',
    'assets/food/meal15.png',
    'assets/food/meal5.jpeg',
    'assets/food/meal6.jpeg',
    'assets/food/meal7.jpeg',
    'assets/food/meal8.jpeg',
    'assets/food/meal9.jpeg',
    'assets/food/meal10.jpg',
    'assets/food/meal11.jpg',
  ];
  final ScrollController controllerOne = ScrollController();
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all(Colors.black54),
              crossAxisMargin: 3),
        ),
        child: Scrollbar(
          controller: controllerOne,
          thumbVisibility: true,
          trackVisibility: true,
          child: Stack(
            children: [
              footerImage(mediaQueryData),
              ListView(
                controller: controllerOne,
                scrollDirection: Axis.vertical,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    // width: 50,
                    // width: AppResponsive.isTablet(context) ||
                    //         AppResponsive.isDesktop(context)
                    //     ? widget.mediaQueryData.size.width / 5
                    //     : widget.mediaQueryData.size.width * 5,
                    child: MasonryView(
                        itemPadding: 5,
                        itemRadius: 20,
                        listOfItem: _items,
                        numberOfColumn: AppResponsive.isTablet(context) ||
                                AppResponsive.isDesktop(context) ||
                                AppResponsive.isBMobile(context)
                            ? 3
                            : 2,
                        itemBuilder: (item) {
                          return profileCard(item);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileCard(var cardImage) {
    return Card(
      elevation: 10,
      color: Colors.white12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: MenuViewCard(
          cardMenu: "cardName",
          cardDetails: "ownerName",
          cardImage: cardImage,
          mediaQueryData: widget.mediaQueryData),
    );
  }

  ImageFiltered footerImage(MediaQueryData mediaQueryData) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
      child: Container(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              filterQuality: FilterQuality.low,
              colorFilter: ColorFilter.mode(Colors.white12, BlendMode.color),
              fit: BoxFit.fill,
              image: AssetImage("assets/banners/banner2.jpg")),
        ),
      ),
    );
  }
}

class MenuViewCard extends StatefulWidget {
  final String cardMenu;
  final String cardDetails;
  final String cardImage;
  final dynamic mediaQueryData;

  const MenuViewCard({
    super.key,
    required this.cardMenu,
    required this.cardDetails,
    required this.cardImage,
    required this.mediaQueryData,
  });

  @override
  State<MenuViewCard> createState() => _MenuViewCardState();
}

class _MenuViewCardState extends State<MenuViewCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final MediaQueryData mediaQueryData = MediaQuery.of(context);

    // var mediaQueryData;
    return SizedBox(
      width: widget.mediaQueryData.size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: SizedBox(
              height: 150,
              width: widget.mediaQueryData.size.width * 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(widget.cardImage), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cardDetails,
                        textAlign: TextAlign.left,
                        style: MenuListStyle.menuName,
                      ),
                      Text(
                        widget.cardMenu,
                        textAlign: TextAlign.left,
                        style: MenuListStyle.menuDetails,
                      ),
                    ],
                  ),
                ],
              )),
          const SizedBox(height: 10),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  // Future<dynamic> networkError(context) {
  //   return showDialog(
  //     // barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         icon: Center(
  //           child: FaIcon(FontAwesomeIcons.triangleExclamation,
  //               size: 50, color: Colors.redAccent),
  //         ),
  //         content: Text(
  //           "You encountered some network challenges.",
  //           textAlign: TextAlign.center,
  //         ),
  //       );
  //     },
  //   );
  // }
}
