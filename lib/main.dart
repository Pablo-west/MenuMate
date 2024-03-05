// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_import, sort_child_properties_last

import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menu_mate/popular%20dish/popular_dish.dart';

import 'tracker/track_order.dart';
import 'menu list/menu_list.dart';
import 'model/app_responsive.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBhZw8FsHp1_VmcG81DXZ9XqPbc7-Uz41g",
            appId: "1:1087992874835:web:7f7e85e68e40fbd21283a6",
            messagingSenderId: "1087992874835",
            projectId: "menumate-ce7ae"));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MenuMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8.0),
        child: FloatingActionButton(
            child: Icon(Icons.shopping_cart),
            tooltip: 'Track order',
            hoverColor: Colors.orange,
            elevation: 20,
            backgroundColor: Colors.orange[900],
            foregroundColor: Colors.white,
            onPressed: () {
              showDialog(
                // barrierColor: Colors.black87,
                // barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        width: 850,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.only(top: 16),
                        child: OrderTracker()),
                  );
                },
              );
            }),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all(Colors.black54),
              crossAxisMargin: 5),
        ),
        child: Scrollbar(
          controller: controller,
          thumbVisibility: true,
          trackVisibility: true,
          child: ListView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                // height: mediaQueryData.size.height / 2.2,
                width: mediaQueryData.size.width,
                clipBehavior: Clip.none,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 20,
                  child: Image.asset(
                    'assets/banners/banner3.png',
                    scale: 3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "How it ",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextSpan(
                    text: "Works?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ])),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(
                    left: AppResponsive.isTablet(context) ||
                            AppResponsive.isDesktop(context)
                        ? 30
                        : 20,
                    right: AppResponsive.isTablet(context) ||
                            AppResponsive.isDesktop(context)
                        ? 30
                        : 20),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      stepsWorks(Icon(Icons.qr_code_2_outlined, size: 50),
                          "Scan QR code or Tap the NFC tag\nto access today's menu"),
                      SizedBox(
                          width: AppResponsive.isTablet(context) ||
                                  AppResponsive.isDesktop(context)
                              ? 45
                              : 15),
                      stepsWorks(Icon(Icons.menu_book_outlined, size: 50),
                          "Pick your tasty meal\nand place your order"),
                      SizedBox(
                          width: AppResponsive.isTablet(context) ||
                                  AppResponsive.isDesktop(context)
                              ? 45
                              : 5),
                      stepsWorks(Icon(Icons.spoke_outlined, size: 50),
                          "Enjoy Our Tasty\nOrganic Food!"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Text(
                  "Our Popular Dishes",
                  // style: GoogleFonts.gafata(
                  //     textStyle: TextStyle(
                  //   fontStyle: FontStyle.italic,
                  //   // fontWeight: FontWeight.w900,
                  //   color: Colors.black,
                  // )),
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                indent: 200,
                endIndent: 200,
                thickness: 3,
              ),
              SizedBox(height: 10),
              PopularDish(),
              SizedBox(height: 10),
              Divider(
                indent: 200,
                endIndent: 200,
                thickness: 3,
              ),
              SizedBox(height: 100),
              Center(
                child: Text(
                  "Our Menu List",
                  // style: GoogleFonts.gafata(
                  //     textStyle: TextStyle(
                  //   fontStyle: FontStyle.italic,
                  //   // fontWeight: FontWeight.w900,
                  //   color: Colors.black,
                  // )),
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                // padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(
                    horizontal: AppResponsive.isTablet(context) ||
                            AppResponsive.isDesktop(context)
                        ? 200
                        : 35),
                height: AppResponsive.isTablet(context) ||
                        AppResponsive.isDesktop(context) ||
                        AppResponsive.isBMobile(context)
                    ? mediaQueryData.size.height
                    : mediaQueryData.size.height / 1.3,
                // width: 10,
                child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                      child: MenuList(mediaQueryData: mediaQueryData),
                    )),
              ),
              SizedBox(height: 50),
              Divider(thickness: 3, color: Colors.brown),
              SizedBox(
                  // height: 300,
                  // height: mediaQueryData.size.height,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      child: AppResponsive.isTablet(context) ||
                              AppResponsive.isDesktop(context) ||
                              AppResponsive.isBMobile(context)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                contactUs(),
                                openHours(),
                                quickLinks(),
                              ],
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 20),
                              child: Column(
                                children: [
                                  contactUs(),
                                  openHours(),
                                  quickLinks(),
                                ],
                              ),
                            )),
                  SizedBox(
                      height: AppResponsive.isTablet(context) ||
                              AppResponsive.isDesktop(context) ||
                              AppResponsive.isBMobile(context)
                          ? 30
                          : 0)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Column quickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        footerHeadTitle("Quick Link"),
        GestureDetector(
            onTap: () {
              print("Todays Menu");
            },
            child: contactListItem(Icon(Icons.smart_button), "Todays Menu")),
        GestureDetector(
            onTap: () {
              print("Staff");
            },
            child: contactListItem(Icon(Icons.smart_button), "Staff")),
        GestureDetector(
            onTap: () {
              print("Dashboard");
            },
            child: contactListItem(Icon(Icons.smart_button), "Dashboard")),
      ],
    );
  }

  Column openHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        footerHeadTitle("Open Hours"),
        contactListItem(Icon(Icons.table_restaurant_outlined),
            "Weekdays: 8:30am - 11:30pm"),
        contactListItem(
            Icon(Icons.table_restaurant), "Saturday: 6:30am - 11:30pm"),
        contactListItem(
            Icon(Icons.table_restaurant_outlined), "Sunday: 2:30pam - 11:30pm"),
      ],
    );
  }

  Column contactUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        footerHeadTitle("Contact Us"),
        contactListItem(
            Icon(Icons.phone), "+233-00-000-0000\n+233-00-000-0000"),
        contactListItem(Icon(Icons.email_outlined), "menucook@mate.org"),
        contactListItem(Icon(Icons.location_on_outlined),
            "52/1, Hasan Holdings, New\nEskaton Road, Dhaka, Bangladesh"),
      ],
    );
  }

  Row contactListItem(icon, text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: 8),
        footerListedItem(text),
      ],
    );
  }

  Widget footerListedItem(text) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 10)
      ],
    );
  }

  Widget footerHeadTitle(title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(height: 30),
        Container(
          padding: EdgeInsets.all(25),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              backgroundColor: Colors.white12,
            ),
          ),
        ),
        // SizedBox(height: 8),
      ],
    );
  }

  ImageFiltered footerImage(MediaQueryData mediaQueryData) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
      child: Container(
        width: mediaQueryData.size.width,
        height: 300,
        decoration: const BoxDecoration(
          image: DecorationImage(
              filterQuality: FilterQuality.low,
              colorFilter: ColorFilter.mode(Colors.white12, BlendMode.color),
              fit: BoxFit.cover,
              image: AssetImage("assets/banners/banner2.jpg")),
        ),
      ),
    );
  }

  Widget stepsWorks(icon, text) {
    return Expanded(
      child: Column(children: [
        icon,
        SizedBox(height: 10),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: AppResponsive.isTablet(context) ||
                      AppResponsive.isDesktop(context)
                  ? 15
                  : 12),
        ),
      ]),
    );
  }
}
