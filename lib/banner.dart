// // ignore_for_file: prefer_const_constructors, avoid_print

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simple_speed_dial/simple_speed_dial.dart';

// import 'global.dart';
// import 'tracker/track_order.dart';

// class FloatingCart extends StatefulWidget {
//   const FloatingCart({super.key});

//   @override
//   State<FloatingCart> createState() => _FloatingCartState();
// }

// class _FloatingCartState extends State<FloatingCart>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   int counter = 0;
//   void incrementCounter() {
//     setState(() {
//       finalOrderId;
//     });
//   }

//   void getOrderId() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     obtainedOrderId = pref.getString('userOrderId');
//     obtainedOrderId1 = pref.getString('userOrderId1');
//     obtainedOrderId2 = pref.getString('userOrderId2');
//     obtainedOrderId3 = pref.getString('userOrderId');
//     obtainedOrderId4 = pref.getString('userOrderId');
//     obtainedOrderId5 = pref.getString('userOrderId');

//     setState(() {
//       print(obtainedOrderId.toString());
//       // print(obtainedOrderId1);
//       // print(obtainedOrderId2);
//       // print(obtainedOrderId3);
//       // print(obtainedOrderId4);
//       // print(obtainedOrderId5);
//     });

//     if (obtainedOrderId.toString().isEmpty) {
//       setState(() {
//         finalOrderId = obtainedOrderId.toString();
//         print(finalOrderId);
//       });
//     }
//     if (obtainedOrderId1 != null) {
//       setState(() {
//         finalOrderId = obtainedOrderId1;
//       });
//     }
//     if (obtainedOrderId2 != null) {
//       setState(() {
//         finalOrderId = obtainedOrderId2;
//       });
//     }
//     if (obtainedOrderId3 != null) {
//       setState(() {
//         finalOrderId = obtainedOrderId3;
//       });
//     }
//     if (obtainedOrderId4 != null) {
//       setState(() {
//         finalOrderId = obtainedOrderId4;
//       });
//     }
//     if (obtainedOrderId5 != null) {
//       setState(() {
//         finalOrderId = obtainedOrderId5;
//       });
//     }
//   }

//   @override
//   void initState() {
//     print("floatL $finalOrderId");
//     getOrderId();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 450),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (!animationController.isDismissed) {
//           animationController.reverse();
//         }
//       },
//       child: SizedBox(
//         child: Builder(builder: (context) {
//           return finalOrderId.toString().isNotEmpty
//               ? SpeedDial(
//                   controller: animationController,
//                   openBackgroundColor: Colors.white,
//                   closedForegroundColor: Colors.white,
//                   openForegroundColor: Colors.black,
//                   closedBackgroundColor: Colors.black,
//                   // labelsBackgroundColor: Colors.amber,
//                   speedDialChildren: [
//                     // speedDialFoodList(context, finalOrderId),
//                     if (finalOrderId.toString().isNotEmpty)
//                       speedDialFoodList(context, finalOrderId),
//                     // if (obtainedOrderId1.isNotEmpty)
//                     //   speedDialFoodList(context, finalOrderId1),
//                     // if (obtainedOrderId2.isNotEmpty)
//                     //   speedDialFoodList(context, finalOrderId2),
//                     // if (obtainedOrderId3.isNotEmpty)
//                     //   speedDialFoodList(context, finalOrderId3),
//                     // if (obtainedOrderId4.isNotEmpty)
//                     //   speedDialFoodList(context, finalOrderId4),
//                     // if (obtainedOrderId5.isNotEmpty)
//                     //   speedDialFoodList(context, finalOrderId5),
//                   ],
//                   child: Icon(Icons.shopping_cart),
//                 )
//               : Container();
//         }),
//       ),
//     );
//   }

//   SpeedDialChild speedDialFoodList(BuildContext context, orderId) {
//     return SpeedDialChild(
//       child: Icon(Icons.restaurant_menu_outlined),
//       foregroundColor: Colors.white,
//       backgroundColor: Colors.red,
//       label: counter.toString(),
//       onPressed: () {
//         animationController.reverse();
//         incrementCounter();
//         // showDialog(
//         //   // barrierColor: Colors.black87,
//         //   // barrierDismissible: false,
//         //   context: context,
//         //   builder: (BuildContext context) {
//         //     return Dialog(
//         //       shape: RoundedRectangleBorder(
//         //         borderRadius: BorderRadius.circular(10.0),
//         //       ),
//         //       child: Container(
//         //           width: 850,
//         //           margin: EdgeInsets.zero,
//         //           padding: EdgeInsets.only(top: 16),
//         //           child: OrderTracker(
//         //               // finalOrderId: orderId,
//         //               )),
//         //     );
//         //   },
//         // );
//       },
//       // closeSpeedDialOnPressed: false,
//     );
//   }
// }
