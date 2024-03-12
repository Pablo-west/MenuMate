// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_mate/model/app_responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/constant.dart';
import '../model/theme_helper.dart';
import 'database.dart';

class PlaceOdrer extends StatefulWidget {
  final String imagePath;
  final String foodName;

  const PlaceOdrer(
      {super.key, required this.imagePath, required this.foodName});

  @override
  State<PlaceOdrer> createState() => _PlaceOdrerState();
}

class _PlaceOdrerState extends State<PlaceOdrer> {
  String? dropdownPaymentOpt;

  final TextEditingController tableNumController = TextEditingController();
  final TextEditingController userNameontroller = TextEditingController();
  final TextEditingController paymentOptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: mediaQueryData.size.height,
          // height: 800,
          width: AppResponsive.isTablet(context)
              ? mediaQueryData.size.width * 2
              : mediaQueryData.size.width * 3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(),
                      //Brand Name
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: " Menu",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              TextSpan(
                                text: "Mate",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              )
                            ])),
                          ),
                          Text(
                            "Place your order",
                            style: TextStyle(
                                // fontStyle: FontStyle.italic,
                                // fontSize: 10,
                                ),
                          ),
                        ],
                      ),

                      Spacer(),
                      //close button
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close_outlined))
                    ],
                  ),
                ),
                SizedBox(
                  child: AppResponsive.isTablet(context) ||
                          AppResponsive.isDesktop(context)
                      ? tableNdesktopView(context)
                      : mobileView(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column mobileView(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Column(
      children: [
        SizedBox(
          height: 130,
          // width: 170,
          child: foodLabel(widget.imagePath, widget.foodName),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: mediaQueryData.size.width / 1.3,
          height: 400,
          child: ListView(
            padding: EdgeInsets.only(left: 10, right: 10),
            children: [
              formOrder(context),
              SizedBox(height: 20),
              Divider(
                thickness: 3,
                color: Colors.brown,
              ),
              SizedBox(height: 30),
              Text(
                "Special Ingredients",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 5),
              Text("•	Scotch Bonnet Peppers"),
              Text("•	Garlic and Ginger"),
              Text("•	Thyme and Bay Leaves"),
              Text("•	Mixed Vegetables"),
              Text("•	Bay Leaves"),
              SizedBox(height: 20),
              Text(
                "🌟 Signature ${widget.foodName} 🌟",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 10),
              Text(
                "Elevate your dining experience with our tantalizing ${widget.foodName}. Each bite is a burst of West African flavors, expertly crafted to perfection. 🍚✨",
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 7),
              Text(
                "🔥 Spice-infused, tomato-kissed, and veggie-packed - it's a celebration on your plate!",
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ],
    );
  }

  Form formOrder(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Fill the form below to place order",
            style: TextStyle(
              // fontStyle: FontStyle.italic,
              fontSize: 17,
            ),
          )),
          SizedBox(height: 15),
          entryTextField(
              tableNumController, "Enter your table number", "Eg: Table 03"),
          SizedBox(height: 10),
          entryTextField(
              userNameontroller, "Enter your Name", "Eg: Pablo West"),
          SizedBox(height: 10),
          textDropdown("Title", 30, 150, dropdownPaymentOpt, (String? value) {
            setState(() {
              dropdownPaymentOpt = value!;
            });
          }, paymentOptArray),
          foodAmount(),
          SizedBox(height: 30),
          rowActionButton(context),
        ],
      ),
    );
  }

  Stack foodLabel(var imagePath, String foodName) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Card(
          elevation: 20,
          child: Container(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(imagePath), fit: BoxFit.cover),
          )),
        ),
        Center(
            child: Text(
          foodName,
          style: TextStyle(
              backgroundColor: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ))
      ],
    );
  }

  Padding tableNdesktopView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 500,
            width: 350,
            child: foodLabel(widget.imagePath, widget.foodName),
          ),
          Container(
            width: 300,
            height: 400,
            margin: EdgeInsets.only(left: 30, right: 40),
            child: formOrder(context),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 50),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Special Ingredients",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("•	Scotch Bonnet Peppers"),
                  Text("•	Garlic and Ginger"),
                  Text("•	Thyme and Bay Leaves"),
                  Text("•	Mixed Vegetables"),
                  Text("•	Bay Leaves"),
                  SizedBox(height: 30),
                  Text(
                    "🌟 Signature ${widget.foodName} 🌟",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Elevate your dining experience with our tantalizing ${widget.foodName}. Each bite is a burst of West African flavors, expertly crafted to perfection. 🍚✨",
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "🔥 Spice-infused, tomato-kissed, and veggie-packed - it's a celebration on your plate!",
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text foodAmount() {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: "GHS: ",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      TextSpan(
        text: "80.00",
        style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 40),
      )
    ]));
  }

  Row rowActionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        actionButton(() {
          Navigator.of(context).pop();
        }, Colors.grey, "Cancel".toUpperCase()),
        actionButton(() async {
          String id = DateTime.now().toString();
          String mealNum = DateTime.now().millisecond.toString();
          // print(id);
          if (formKey.currentState!.validate()) {
            // print(tableNumController.text);
            // print(userNameontroller.text);
            // print(dropdownPaymentOpt);
            storeOrderId(mealNum);

            Map<String, dynamic> orderInfoMap = {
              "mealNum": mealNum,
              "food": widget.foodName,
              "foodAmt": "GHS 80.00",
              "tableNum": tableNumController.text,
              "userName": userNameontroller.text,
              "paymentOption": dropdownPaymentOpt
            };
            DatabaseMethods().addOrder(orderInfoMap, id).then((value) {
              Fluttertoast.showToast(
                  msg: "✔ Your order has been placed Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.greenAccent,
                  textColor: Colors.white,
                  fontSize: 15.0);
            });
            Navigator.of(context).pop();
          } else {
            unfilledField(context);
          }
        }, Colors.green, " Order ".toUpperCase())
      ],
    );
  }

  Widget entryTextField(controller, lableText, textHint) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: TextFormField(
          textInputAction: TextInputAction.next,
          controller: controller,
          style: TextStyle(fontSize: 13),
          decoration: ThemeHelper().textInputDecoration(
            lableText,
            "",
            textHint,
            null,
            null,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return kNullValue;
            }

            return null;
          }),
    );
  }

  ElevatedButton actionButton(press, color, title) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: press,
        child: Text(title));
  }

  Widget textDropdown(String textName, double height, double width,
      var dropdownValue, onChanged, var itemMap) {
    return Row(
      children: [
        Text(
          textName,
        ),
        const SizedBox(width: 10.0),
        dropDownListWidget(height, width, dropdownValue, onChanged, itemMap),
      ],
    );
  }

  Center dropDownListWidget(
      double height, double width, var dropdownValue, onChanged, var itemMap) {
    return Center(
      child: Container(
        height: 50,
        width: width,
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.zero,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            value: dropdownValue,
            icon: const Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.black,
            ),
            isExpanded: true,
            elevation: 16,
            style: const TextStyle(
              color: Colors.black,
            ),
            onChanged: onChanged,
            items: itemMap.map<DropdownMenuItem<String>>((dynamic value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: TextStyle(
                        fontSize: 14,
                        color: kDefaultIconDarkColor,
                        fontWeight: FontWeight.w300)),
              );
            }).toList(),
            decoration: InputDecoration(
              hintText: 'Select an option',
              hintStyle: TextStyle(fontSize: 14),
              fillColor: Colors.white,
              hoverColor: Colors.white10,
              filled: true,
              border: InputBorder.none,
              contentPadding: EdgeInsetsDirectional.only(bottom: 15, start: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: Colors.red.shade200, width: 1.0)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: Colors.red.shade200, width: 1.0)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.red, width: 2.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.red, width: 2.0)),
            ),
            validator: (value) {
              if (value == null) {
                return 'Please select an option';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> unfilledField(context) {
    return showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          icon: Center(
            child: FaIcon(FontAwesomeIcons.triangleExclamation,
                size: 50, color: Colors.redAccent),
          ),
          content: Text(
            "You left out some required field(s).",
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}

Future<void> storeOrderId(String mealNum) async {
  final SharedPreferences perf = await SharedPreferences.getInstance();

  perf.setString('userOrderId', mealNum);
}
