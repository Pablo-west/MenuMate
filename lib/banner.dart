// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MenuMate',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final MediaQueryData mediaQueryData = MediaQuery.of(context);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Container(
//               height: mediaQueryData.size.height / 1.5,
//               width: mediaQueryData.size.width,
//               clipBehavior: Clip.none,
//               child: Card(
//                 margin: EdgeInsets.zero,
//                 elevation: 20,
//                 child: Image.asset(
//                   'assets/banners/banner3.png',
//                   // scale: 3,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Container(
//               color:
//                   Colors.black.withOpacity(0.6), // Adjust the opacity as needed
//               width: MediaQuery.of(context).size.width,
//               height: mediaQueryData.size.height / 1.5,
//             ),
//             Center(
//               child: Column(
//                 children: [
//                   SizedBox(height: 150),
//                   Container(
//                     margin: EdgeInsets.zero,
//                     child: Image.asset(
//                       'assets/logo/logo-icon.png',
//                       // scale: 3,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Container(
//                       padding: EdgeInsets.only(left: 40),
//                       child: Text(
//                         'MenuMate',
//                         // style: TextStyle(
//                         //     fontSize: 35,
//                         //     fontWeight: FontWeight.w900,
//                         //     color: Colors.black),
//                         // style: GoogleFonts.gafata(
//                         //     textStyle: TextStyle(
//                         //   fontSize: 45,
//                         //   fontWeight: FontWeight.w900,
//                         //   color: Colors.white,
//                         // )),
//                       )),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
