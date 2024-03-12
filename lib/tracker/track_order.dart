// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';
import '../model/app_responsive.dart';
import '../orders/database.dart';

class OrderTracker extends StatefulWidget {
  const OrderTracker({super.key});

  @override
  State<OrderTracker> createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker> {
  Stream? stockStream;
  getontheload() async {
    stockStream = await DatabaseMethods().getOrder();
    setState(() {});
  }

  void getOrderId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var obtainedOrderId = pref.getString('userOrderId');

    if (obtainedOrderId != null) {
      setState(() {
        finalOrderId = obtainedOrderId;
      });
      // print(finalOrderId);
    }
  }

  @override
  void initState() {
    getOrderId();
    getontheload();

    setState(() {
      if (receivedProcess == true) {
        String mealStage = "Delivered Stage";
        trakerStage = mealStage;
      } else if (deliveringProcess == true) {
        String mealStage = "Delivering Stage";
        trakerStage = mealStage;
      } else if (cookingProcess == true) {
        String mealStage = "Cooking Stage";
        trakerStage = mealStage;
      } else {
        String mealStage = "Ordered Stage";
        trakerStage = mealStage;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: AppResponsive.isBMobile(context) ? 300 : 400,
        child: SizedBox(
          child: (finalOrderId.isNotEmpty)
              ? StreamBuilder(
                  builder: (context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        // Handle ConnectionState.none
                        return Text("ConnectionState.none");
                      case ConnectionState.waiting:
                        // Handle ConnectionState.waiting
                        return CircularProgressIndicator();
                      case ConnectionState.active:
                      case ConnectionState.done:
                        List<Widget> contentWidgets = [];
                        for (DocumentSnapshot ds in snapshot.data.docs) {
                          // Display content only when "Id" is equal to 42909
                          if (ds["mealNum"] == finalOrderId) {
                            trackerCard(contentWidgets, context, ds);
                          }
                        }

                        return contentWidgets.isNotEmpty
                            ? ListView(
                                // mainAxisSize: MainAxisSize.max,
                                children: contentWidgets)
                            : Text("No show");
                    }
                  },
                  stream: stockStream,
                )
              : Text("Data"),
        ));
  }

  void trackerCard(List<Widget> contentWidgets, BuildContext context,
      DocumentSnapshot<Object?> ds) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return contentWidgets.add(
      SizedBox(
        height: 400,
        // width: 400,
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: Container()),

                Expanded(
                  flex: 5,
                  child: Text(
                    "Track your meal",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Expanded(flex: 1, child: Container()),
                //close button
                IconButton(
                    padding: EdgeInsets.only(right: 10),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close_outlined))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  // clipBehavior: Clip.none,
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            onProcessState("Ordered"),
                            SizedBox(
                                child: cookingProcess
                                    ? onProcessState("Cooking")
                                    : offProcessState("Cooking")),
                            SizedBox(
                                child: deliveringProcess
                                    ? onProcessState("Delivering")
                                    : offProcessState("Delivering")),
                            SizedBox(
                                child: receivedProcess
                                    ? Text("Delivered",
                                        style: TextStyle(
                                            color: Colors.orangeAccent,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                AppResponsive.isBMobile(context)
                                                    ? 15.5
                                                    : 11))
                                    : Text("Delivered",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                AppResponsive.isBMobile(context)
                                                    ? 15.5
                                                    : 11))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Client order details
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text("Order Placed Details",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          )),
                      SizedBox(height: 10),
                      AppResponsive.isBMobile(context)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  orderPlaceDetailsOne(ds),
                                  orderPlaceDetailsTwo(ds),
                                ])
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  orderPlaceDetailsOne(ds),
                                  orderPlaceDetailsTwo(ds),
                                ]),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: AppResponsive.isBMobile(context)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              listingItems("Your meal is at: ", trakerStage),
                              listingItems("Your waiter for today is: ", "Paa"),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              listingItems("Your meal is at: ", trakerStage),
                              listingItems("Your waiter for today is: ", "Paa"),
                            ],
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget trackerCard(BuildContext context) {
  //   return ListView(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Spacer(),

  //           Text(
  //             "Track your meal",
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //           ),
  //           Spacer(),
  //           //close button
  //           IconButton(
  //               padding: EdgeInsets.only(right: 10),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               icon: Icon(Icons.close_outlined))
  //         ],
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Card(
  //             child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Row(
  //                 children: [
  //                   onProcessState("Ordered"),
  //                   SizedBox(
  //                       child: cookingProcess
  //                           ? onProcessState("Cooking")
  //                           : offProcessState("Cooking")),
  //                   SizedBox(
  //                       child: deliveringProcess
  //                           ? onProcessState("Delivering")
  //                           : offProcessState("Delivering")),
  //                   SizedBox(
  //                       child: receivedProcess
  //                           ? Text("Delivered",
  //                               style: TextStyle(
  //                                   color: Colors.orangeAccent,
  //                                   fontWeight: FontWeight.w600,
  //                                   fontSize: AppResponsive.isBMobile(context)
  //                                       ? 15.5
  //                                       : 11))
  //                           : Text("Delivered",
  //                               style: TextStyle(
  //                                   color: Colors.grey,
  //                                   fontWeight: FontWeight.w600,
  //                                   fontSize: AppResponsive.isBMobile(context)
  //                                       ? 15.5
  //                                       : 11))),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       // Client order details
  //       Container(
  //         margin: EdgeInsets.symmetric(horizontal: 20),
  //         child: Card(
  //           child: Padding(
  //             padding: const EdgeInsets.all(15.0),
  //             child: Column(
  //               children: [
  //                 Text("Order Placed Details",
  //                     style: TextStyle(
  //                       fontStyle: FontStyle.italic,
  //                       fontSize: 12,
  //                     )),
  //                 SizedBox(height: 10),
  //                 AppResponsive.isBMobile(context)
  //                     ? Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                             orderPlaceDetailsOne(),
  //                             orderPlaceDetailsTwo(),
  //                           ])
  //                     : Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                             orderPlaceDetailsOne(),
  //                             orderPlaceDetailsTwo(),
  //                           ]),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       Container(
  //         margin: EdgeInsets.symmetric(horizontal: 20),
  //         child: Card(
  //           child: Padding(
  //               padding: const EdgeInsets.all(15.0),
  //               child: AppResponsive.isBMobile(context)
  //                   ? Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         listingItems("Your meal is at: ", trakerStage),
  //                         listingItems("Your waiter for today is: ", "Paa"),
  //                         Text(finalOrderId),
  //                       ],
  //                     )
  //                   : Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(finalOrderId),
  //                         listingItems("Your meal is at: ", trakerStage),
  //                         listingItems("Your waiter for today is: ", "Paa"),
  //                       ],
  //                     )),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Column orderPlaceDetailsTwo(var ds) {
    String mealNumber = ds["mealNum"].toString();
    String foodAmount = ds["foodAmt"].toString();
    String paymentOpt = ds["paymentOption"].toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listingItems("Meal number: ", mealNumber),
        listingItems("Amount: ", foodAmount),
        listingItems("Mode of payment: ", paymentOpt),
      ],
    );
  }

  Column orderPlaceDetailsOne(ds) {
    String tableNumber = ds["tableNum"].toString();
    String userName = ds["userName"].toString();
    String food = ds["food"].toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listingItems("Table number: ", tableNumber),
        listingItems("Name: ", userName),
        listingItems("Meal name: ", food),
      ],
    );
  }

  Widget offProcessState(String processName) {
    return Row(
      children: [
        Text(processName,
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: AppResponsive.isBMobile(context) ? 15.5 : 11)),
        offProgress(),
      ],
    );
  }

  Widget onProcessState(String processName) {
    return Row(
      children: [
        Text(processName,
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
                fontSize: AppResponsive.isBMobile(context) ? 15.5 : 10)),
        onProgress()
      ],
    );
  }

  Widget offProgress() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.isBMobile(context) ? 10.0 : 5),
      child: AppResponsive.isBMobile(context)
          ? Text("- - - -",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: AppResponsive.isBMobile(context) ? 20.5 : 11))
          : Text(">",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11)),
    );
  }

  Widget onProgress() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.isBMobile(context) ? 10.0 : 5),
      child: AppResponsive.isBMobile(context)
          ? Text("- - - -",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: AppResponsive.isBMobile(context) ? 20.5 : 11))
          : Text(">",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11)),
    );
  }

  Text listingItems(String title, details) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: title,
      ),
      TextSpan(
        text: details,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5),
      )
    ]));
  }
}
