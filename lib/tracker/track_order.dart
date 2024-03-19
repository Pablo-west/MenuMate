// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';
import '../model/app_responsive.dart';
import '../orders/database.dart';
import 'display_tracked_order.dart';

class OrderTracker extends StatefulWidget {
  const OrderTracker({super.key});

  @override
  State<OrderTracker> createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker> {
  bool kitchenProcess = false;
  bool deliveredProcess = false;
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
      if (deliveredProcess == true) {
        String mealStage = "Delivered Stage";
        trakerStage = mealStage;
      } else if (kitchenProcess == true) {
        String mealStage = "Kitchen Stage";
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
              : Center(child: Text("You have no order placed")),
        ));
  }

  void trackerCard(List<Widget> contentWidgets, BuildContext context,
      DocumentSnapshot<Object?> ds) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    String deliveredMode = "false";
    String kitchenMode = "false";
    try {
      deliveredMode = ds.get("deliveredMode")?.toString() ?? "";
      kitchenMode = ds.get("kitchenMode")?.toString() ?? "";
    } catch (e) {
      // Handle any errors, such as the field not existing
      // print("$e");
    }
    return contentWidgets.add(
      SizedBox(
        height: 400,
        // width: 400,
        child: DisplayTrackedOrder(
          ds: ds,
          kitchenMode: kitchenMode,
          deliveredMode: deliveredMode,
        ),
      ),
    );
  }
}
