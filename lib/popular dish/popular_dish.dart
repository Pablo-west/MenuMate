// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../orders/place_order.dart';

class PopularDish extends StatefulWidget {
  const PopularDish({super.key});

  @override
  State<PopularDish> createState() => _PopularDishState();
}

class _PopularDishState extends State<PopularDish> {
  final List<String> imagesPaths = [
    'assets/food/meal15.png',
    'assets/banners/banner2.jpg',
    'assets/banners/banner3.png',
    'assets/banners/banner1.jpg',
  ];
  final List<String> imageName = ['Jollof Rice', 'Waakye', 'Fufu', 'Banku'];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemBuilder: (context, index, realIndex) {
        return PlaceOrderDialog(
          imagePath: imagesPaths[index],
          foodName: imageName[index],
        );
      },
      itemCount: imagesPaths.length,
      options: CarouselOptions(
        height: 250,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        autoPlay: true,
        aspectRatio: 1 / 9,
        enlargeFactor: 0.3,
        viewportFraction: 0.5,
        // reverse: true,
        autoPlayInterval: Duration(seconds: 3),
        // aspectRatio: 100 / 5,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}

class PlaceOrderDialog extends StatefulWidget {
  final String imagePath;
  final String foodName;
  const PlaceOrderDialog({
    super.key,
    required this.imagePath,
    required this.foodName,
  });

  @override
  State<PlaceOrderDialog> createState() => _PlaceOrderDialogState();
}

class _PlaceOrderDialogState extends State<PlaceOrderDialog> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                  width: double.infinity,
                  height: mediaQueryData.size.height / 1.2,
                  padding: EdgeInsets.only(top: 16),
                  child: PlaceOdrer(
                    imagePath: widget.imagePath,
                    foodName: widget.foodName,
                  )),
            );
          },
        );
      },
      child: Container(
          height: 10,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
                image: AssetImage(widget.imagePath), fit: BoxFit.cover),
          )),
    );
  }
}
