// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable

import 'package:flutter/material.dart';

import '../global.dart';
import '../model/app_responsive.dart';

class OrderTracker extends StatefulWidget {
  const OrderTracker({super.key});

  @override
  State<OrderTracker> createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker> {
  @override
  void initState() {
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
      height: 300,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),

              Text(
                "Track your meal",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Spacer(),
              //close button
              IconButton(
                  padding: EdgeInsets.only(right: 10),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close_outlined))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
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
                                      fontSize: AppResponsive.isBMobile(context)
                                          ? 15.5
                                          : 11))
                              : Text("Delivered",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppResponsive.isBMobile(context)
                                          ? 15.5
                                          : 11))),
                    ],
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
                                orderPlaceDetailsOne(),
                                orderPlaceDetailsTwo(),
                              ])
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                orderPlaceDetailsOne(),
                                orderPlaceDetailsTwo(),
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
    );
  }

  Column orderPlaceDetailsTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listingItems("Meal number: ", "123450422"),
        listingItems("Amount: ", "GHS 80.00"),
        listingItems("Mode of payment: ", "G-money"),
      ],
    );
  }

  Column orderPlaceDetailsOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listingItems("Table number: ", "Table 03"),
        listingItems("Name: ", "Pablo West "),
        listingItems("Meal name: ", "Jollof Rice"),
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
