import 'package:flutter/material.dart';
import 'package:placement_original/services/Database.dart';

class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("students information"),
        backgroundColor: Color.fromRGBO(42, 42, 114,0.9 ),
      ),
      body: FutureBuilder(
        future: Database("","").getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            dataList = snapshot.data as List;
            return buildItems(dataList);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildItems(dataList) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dataList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            dataList[index]["name"],
          ),
          subtitle:  Text(dataList[index]["usn"]),
          trailing: Text(
            dataList[index]["branch"],
          ),
        );
      });
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:placement_original/footer.dart';
// import 'package:placement_original/services/Database.dart';
// import 'package:placement_original/services/sharedPref.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/src/foundation/key.dart';
//
// class DashBoard extends StatefulWidget {
//   const DashBoard({Key? key}) : super(key: key);
//   @override
//   _DashBoardState createState() => _DashBoardState();
// }
//
// class _DashBoardState extends State<DashBoard> {  ScrollController _scrollController;
//
//    double _opacity = 0;
//   double _scrollPosition = 0;
//
//   _scrollListener() {
//     setState(() {
//       _scrollPosition = _scrollController.position.pixels;
//     });
//   }
//
//
//
// // final CollectionReference collectionRef=
// // FirebaseFirestore.instance.collection("Data");
// // //
// // Future getData() async {
// //   try {
// //     await collectionRef.get().then((querySnapshot) {
// //       for (var result in querySnapshot.docs) {
// //         studentlist.add(result.data());
// //       }
// //     });
// //
// //     return studentlist;
// //   } catch (e) {
// //     debugPrint("error -$e");
// //     return null;
// //   }
// // }
//
// List _isHovering = [false, false, false, false, false, false, false];
//   _launchURL(url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//
//   }
// List studentlist=[];
//  // @override
//   // Widget build(BuildContext context) {
//   //   var screenSize = MediaQuery.of(context).size;
//   //   bool isScreenSmall = screenSize.width < 800;
//   //   _opacity = _scrollPosition < screenSize.height * 0.4 ? 0.75 : 1.0;
//   //   // print(screenSize.height*0.45);
//   //   // print(screenSize.width);
//   //   final themeChange = Provider.of<DarkThemeProvider>(context);
//   //   // Future.delayed(
//   //   //     Duration.zero,
//   //   //     () => !isPopped
//   //   //         ? showDialog(
//   //   //             context: context,
//   //   //             builder: (context) => AlertDialog(
//   //   //                   title: Container(
//   //   //                       height: 600,
//   //   //                       width: 480,
//   //   //                       child:
//   //   //                           Center(child: Image.asset('Trade-itional.png'))),
//   //   //                   actions: [
//   //   //                     TextButton(
//   //   //                         onPressed: () {
//   //   //                           Navigator.of(context).pop();
//   //
//   //   //                           setState(() {
//   //   //                             isPopped = true;
//   //   //                           });
//   //   //                         },
//   //   //                         child: Text('Close'))
//   //   //                   ],
//   //   //                 ))
//   //   //         : null);
//   //   return Scaffold(
//   //     // extendBodyBehindAppBar: true,
//   //     appBar: isScreenSmall
//   //         ? AppBar(
//   //
//   //
//   //       title: Image.asset(
//   //         'bitlogo.png',
//   //         fit: BoxFit.contain,
//   //         height: screenSize.height * 0.08,
//   //       ),
//   //
//   //       backgroundColor: Color.fromRGBO(42, 42, 114,0.9 ),
//   //     )
//   //         : PreferredSize(
//   //       preferredSize: Size(screenSize.width, screenSize.height * 0.15),
//   //       child: Card(
//   //
//   //         elevation: 10,
//   //
//   //         // color: Color.fromRGBO(0, 51, 102, 0.9),
//   //         child: Container(
//   //           decoration: BoxDecoration(
//   //             gradient: LinearGradient(
//   //                 begin: Alignment.centerLeft,
//   //                 end:Alignment.centerRight,
//   //                 colors: [
//   //                   Color.fromRGBO(0, 0, 0, 0.9),
//   //                   Color.fromRGBO(42, 42, 114,0.9 ),
//   //                 ]
//   //             ),
//   //           ),
//   //
//   //           child: Padding(
//   //             padding: EdgeInsets.symmetric(
//   //                 vertical: 0, horizontal: screenSize.width * 0.1),
//   //             child: Row(
//   //               children: [
//   //                 Image.asset('bitlogo.png', height: 250.0),
//   //                 Expanded(
//   //                   child: Row(
//   //                     mainAxisAlignment: MainAxisAlignment.center,
//   //                     children: [
//   //                       InkWell(
//   //                         onTap: () {
//   //                           Navigator.pushNamed(context, '/');
//   //                         },
//   //                         onHover: (ishoverd) {
//   //                           setState(() {
//   //                             _isHovering[0] = ishoverd;
//   //                           });
//   //                         },
//   //                         child: Text(
//   //                           'Home',
//   //                           style: GoogleFonts.aBeeZee(
//   //                               color: _isHovering[0]
//   //                                   ? Colors.white
//   //                                   : Colors.white,
//   //
//   //                               fontSize: 18.0,
//   //                               fontWeight: FontWeight.w600,
//   //                               decoration: TextDecoration.underline),
//   //                         ),
//   //                       ),
//   //                       SizedBox(width: screenSize.width / 20),
//   //                       InkWell(
//   //                         onTap: () {
//   //                           Navigator.pushNamed(context, '/Facilities');
//   //                         },
//   //                         onHover: (ishoverd) {
//   //                           setState(() {
//   //                             _isHovering[1] = ishoverd;
//   //                           });
//   //                         },
//   //                         child: Text(
//   //                           'Facilities and\nObjectives',
//   //                           style: GoogleFonts.aBeeZee(
//   //                               color: _isHovering[1]
//   //                                   ? Colors.white
//   //                                   : Colors.white,
//   //                               fontSize: 18.0,
//   //                               fontWeight: FontWeight.w600),
//   //                         ),
//   //                       ),
//   //                       SizedBox(width: screenSize.width / 20),
//   //                       InkWell(
//   //                         onTap: () {
//   //                           Navigator.pushNamed(context, '/Placements');
//   //                         },
//   //                         onHover: (ishoverd) {
//   //                           setState(() {
//   //                             _isHovering[2] = ishoverd;
//   //                           });
//   //                         },
//   //                         child:
//   //
//   //                         Text(
//   //                           'Placements',
//   //                           style: GoogleFonts.aBeeZee(
//   //                               color: _isHovering[2]
//   //                                   ? Colors.white
//   //                                   : Colors.white,
//   //                               fontSize: 18.0,
//   //                               fontWeight: FontWeight.w600),
//   //
//   //
//   //                         ),
//   //
//   //                       ),
//   //
//   //                       IconButton(onPressed: () {
//   //                         Navigator.pushNamed(context, '/Stats');
//   //                       },
//   //
//   //                           icon:Icon(Icons.arrow_drop_down)),
//   //                       SizedBox(width: screenSize.width / 20),
//   //                       InkWell(
//   //                         onTap: () {
//   //                           Navigator.pushNamed(context, '/Company');
//   //                         },
//   //                         onHover: (ishoverd) {
//   //                           setState(() {
//   //                             _isHovering[3] = ishoverd;
//   //                           });
//   //                         },
//   //                         child: Text(
//   //                           'Company\nDetails',
//   //                           style: GoogleFonts.aBeeZee(
//   //                               color: _isHovering[3]
//   //                                   ? Colors.white
//   //                                   : Colors.white,
//   //                               fontSize: 18.0,
//   //                               fontWeight: FontWeight.w600
//   //                             //decoration: TextDecoration.underline
//   //                           ),
//   //                         ),
//   //                       ),
//   //                       SizedBox(width: screenSize.width / 20),
//   //                       InkWell(
//   //                         onTap: () {
//   //                           Navigator.pushNamed(context, '/contact_us');
//   //                         },
//   //                         onHover: (ishoverd) {
//   //                           setState(() {
//   //                             _isHovering[4] = ishoverd;
//   //                           });
//   //                         },
//   //                         child: Text(
//   //                           'Contact Us',
//   //                           style: GoogleFonts.aBeeZee(
//   //                               color: _isHovering[4]
//   //                                   ? Colors.white
//   //                                   : Colors.white,
//   //                               fontWeight: FontWeight.w600,
//   //                               fontSize: 18.0),
//   //                         ),
//   //                       )
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 themeChange.isSignedIn
//   //                     ? DropdownButton<String>(
//   //                   // value: themeChange.username!=null && !themeChange.username.isEmpty?themeChange.username:'Loading',
//   //                   iconSize: 0,
//   //                   value: "DashBoard",
//   //                   elevation: 8,
//   //                   underline: Container(
//   //                     height: 2,
//   //                     color: Colors.transparent,
//   //                   ),
//   //                   onChanged: (val) {
//   //                     setState(() {
//   //                       if (val.compareTo("Sign Out") == 0) {
//   //                         Database("", "")
//   //                             .signOut();
//   //                         themeChange.username = "";
//   //                         themeChange.email = "";
//   //                         themeChange.isSignedIn = false;
//   //                       } else if (val.compareTo("DashBoard") == 0)
//   //                         Navigator.pushNamed(
//   //                             context, '/dashboard');
//   //                     });
//   //                   },
//   //                   style: GoogleFonts.montserrat(
//   //                     color: Colors.orange,
//   //                   ),
//   //                   items: <String>[
//   //                     'DashBoard',
//   //                     'Sign Out'
//   //                   ].map<DropdownMenuItem<String>>((String value) {
//   //                     return DropdownMenuItem<String>(
//   //                       value: value,
//   //                       child: Text(value),
//   //                     );
//   //                   }).toList(),
//   //                 )
//   //                     : Row(
//   //                   children: [
//   //                     InkWell(
//   //                       onTap: () {
//   //                         Navigator.pushNamed(context, '/register');
//   //                       },
//   //                       onHover: (val) {
//   //                         setState(() {
//   //                           _isHovering[5] = val;
//   //                         });
//   //                       },
//   //                       child: Text(
//   //                         "Register",
//   //                         style: GoogleFonts.openSans(
//   //                             fontWeight: FontWeight.w400,
//   //                             color: _isHovering[5]
//   //                                 ? Colors.pink
//   //                                 : Colors.orange,
//   //                             fontSize: 17),
//   //                       ),
//   //                     ),
//   //                     SizedBox(
//   //                       width: screenSize.width * 0.01,
//   //                     ),
//   //                     InkWell(
//   //                       onTap: () {
//   //                         Navigator.pushNamed(context, '/login');
//   //                       },
//   //                       onHover: (val) {
//   //                         setState(() {
//   //                           _isHovering[6] = val;
//   //                         });
//   //                       },
//   //                       child: Text(
//   //                         "Log In",
//   //                         style: GoogleFonts.openSans(
//   //                             fontWeight: FontWeight.w400,
//   //                             color: _isHovering[6]
//   //                                 ? Colors.pink
//   //                                 : Colors.orange,
//   //                             fontSize: 17),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //                 SizedBox(width: screenSize.width * 0.01),
//   //                 // IconButton(
//   //                 //   icon: Icon(Icons.brightness_medium,
//   //                 //       color: themeChange.darkTheme
//   //                 //           ? Colors.white
//   //                 //           : Colors.grey[400]),
//   //                 //   onPressed: () {
//   //                 //     themeChange.darkTheme = !themeChange.darkTheme;
//   //                 //   },
//   //                 // )
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //
//   //     drawer: isScreenSmall
//   //         ? Drawer(
//   //       child: ListView(
//   //         // Important: Remove any padding from the ListView.
//   //         padding: EdgeInsets.zero,
//   //         children: <Widget>[
//   //           DrawerHeader(
//   //               child: Column(
//   //                 children: [
//   //                   Image.asset('bitlogo.png',
//   //                       height: 120.0, width: 250.0, scale: 0.1),
//   //                   Text(''),
//   //                 ],
//   //               ),
//   //               decoration: BoxDecoration(
//   //                 gradient: LinearGradient(
//   //                     colors: [
//   //                       Color.fromRGBO(0, 0, 0, 0.9),
//   //                       Color.fromRGBO(42, 42, 114,0.9 ),
//   //                     ]
//   //                 ),
//   //               )
//   //           ),
//   //           ListTile(
//   //             title: Text('Home'),
//   //             leading: Icon(Icons.home, color: Colors.grey),
//   //             onTap: () {
//   //               Navigator.pushNamed(context, '/');
//   //             },
//   //           ),
//   //           ListTile(
//   //             title: Text('Facilities'),
//   //             leading: Icon(Icons.settings),
//   //             onTap: () {
//   //               Navigator.pushNamed(context, '/Facilities');
//   //             },
//   //           ),
//   //           ListTile(
//   //             title: Text('Placements'),
//   //             leading: Icon(Icons.calendar_today),
//   //             onTap: () {
//   //               Navigator.pushNamed(context, '/Placements');
//   //             },
//   //           ),
//   //           ListTile(
//   //             title: Text('Company\nDetails'),
//   //             leading: Icon(Icons.people),
//   //             onTap: () {
//   //               Navigator.pushNamed(context, '/Company');
//   //             },
//   //           ),
//   //           ListTile(
//   //             title: Text('Contact us'),
//   //             leading: Icon(Icons.contact_mail),
//   //             onTap: () {
//   //               Navigator.pushNamed(context, '/contact_us');
//   //             },
//   //           ),
//   //           themeChange.isSignedIn
//   //               ? Column(
//   //             children: [
//   //               ListTile(
//   //                 title: Text('DashBoard'),
//   //                 leading: Icon(Icons.person),
//   //                 onTap: () {
//   //                   Navigator.pushNamed(context, '/dashboard');
//   //                 },
//   //               ),
//   //               ListTile(
//   //                 title: Text('Sign Out'),
//   //                 leading: Image.network(
//   //                     'https://img.icons8.com/fluent-systems-regular/24/000000/exit.png'),
//   //                 onTap: () {
//   //                   Database("",  "").signOut();
//   //                   themeChange.username = "";
//   //                   themeChange.email = "";
//   //                   themeChange.isSignedIn = false;
//   //                 },
//   //               ),
//   //             ],
//   //           )
//   //               : Column(
//   //             children: [
//   //               ListTile(
//   //                 title: Text('Register'),
//   //                 leading: Icon(Icons.person_add),
//   //                 onTap: () {
//   //                   _launchURL(
//   //                       'https://rzp.io/l/rotaractRegistration');
//   //                 },
//   //               ),
//   //               ListTile(
//   //                 title: Text('Log In'),
//   //                 leading: Icon(Icons.person),
//   //                 onTap: () {
//   //                   Navigator.pushNamed(context, '/login');
//   //                 },
//   //               ),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     )
//   //         : null,
//   //     backgroundColor: Theme.of(context).backgroundColor,
//   // }
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text("details of students"),
//     ),
//     body: FutureBuilder(
//       future: Database("","").getData(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text(
//             "Something went wrong",
//           );
//         }
//         if (snapshot.connectionState == ConnectionState.done) {
//           studentlist = snapshot.data as List;
//           return buildItems(studentlist);
//         }
//         return const Center(child: CircularProgressIndicator());
//       },
//     ),
//   );
// }
// }
//   //      body: FutureBuilder(
//   //        future : Database("","").getData(),
//   //        builder: (context, snapshot),{
//   //          if (snapshot.hasError){
//   //            return const Text(
//   //            "something went wrong",
//   //
//   //            );
//   //          }
//   //          if snapshot.connectionstate == ConnectionState.done){
//   //            datalist = snapshot.data as List;
//   //            return buildItems(datalist);
//   //
//   //      }
//   //      return const Center(child: CircularProgressIndicator());
//   //
//   //      },
//   //      ),
//   //   );
//   // }
//       //   children: [
//       //
//       //     SingleChildScrollView(
//       //       controller: _scrollController,
//       //       child: Container(
//       //         // color: Theme.of(context).backgroundColor,
//       //         child: Column(
//       //           children: [
//       //             Stack(
//       //               children: [
//       //                 Container(
//       //                   height: isScreenSmall
//       //                       ? screenSize.height * 0.3
//       //                       : screenSize.height * 0.45,
//       //                   width: screenSize.width,
//       //                   // child: Image.asset(
//       //                   //     themeChange.darkTheme
//       //                   //         ? 'celeberation_image.webp'
//       //                   //         : 'celeberation_image_orange.webp',
//       //                   //     fit: isScreenSmall ? BoxFit.fill : BoxFit.cover),
//       //                 )
//       //               ],
//       //             ),
//       //             Center(
//       //               child: Padding(
//       //                 padding: EdgeInsets.all(screenSize.width * 0.1),
//       //                 child: Column(
//       //                   mainAxisSize: MainAxisSize.min,
//       //                   mainAxisAlignment: MainAxisAlignment.center,
//       //                   crossAxisAlignment: CrossAxisAlignment.start,
//       //                   children: [
//       //                     Text(
//       //                       'Placement Cell of bit studentlist',
//       //                       style: TextStyle(
//       //                           fontSize: 40,
//       //                           fontWeight: FontWeight.bold,
//       //                           // color: themeChange.darkTheme
//       //                           //     ? Colors.grey[400]
//       //                           //     : Colors.grey[900]
//       //                             ),
//       //                     ),
//       //
//       //                     SizedBox(height: 30.0),
//       //                     Container(
//       //
//       //                       padding: EdgeInsets.symmetric(
//       //                           vertical: 11.0, horizontal: 11.0),
//       //                       child: FlatButton(
//       //                         onPressed: () {
//       //
//       //                         },
//       //
//       //                         child: Text(String.fromCharCode(0x2022) + '$print{studentlist}',
//       //                           style: GoogleFonts.aBeeZee(
//       //
//       //                             //sans can also be tried
//       //                             fontSize: 10.0,
//       //                             letterSpacing: 0.5,
//       //                             color: Colors.blue,decoration: TextDecoration.underline,
//       //                           ),
//       //                         ),
//       //                       ),
//       //
//       //                     ),
//       //                     // SizedBox(height: screenSize.height * 0.05),
//       //                     // Row(
//       //                     //   children: [
//       //                     //     CircleAvatar(
//       //                     //       radius: 30,
//       //                     //       backgroundColor: Colors.blue[900],
//       //                     //       child: IconButton(
//       //                     //           icon: Icon(
//       //                     //         Icons.location_on,
//       //                     //         color: themeChange.darkTheme
//       //                     //             ? Colors.grey[400]
//       //                     //             : Colors.white,
//       //                     //         size: 30,
//       //                     //       )),
//       //                     //     ),
//       //                     //     SizedBox(
//       //                     //       width: screenSize.width * 0.01,
//       //                     //     ),
//       //                     //     Text(
//       //                     //
//       //                     //            'hello',
//       //                     //       style: GoogleFonts.montserrat(
//       //                     //           fontSize: 20,
//       //                     //           color: themeChange.darkTheme
//       //                     //               ? Colors.grey[400]
//       //                     //               : Colors.grey[900]),
//       //                     //     )
//       //                     //   ],
//       //                     // ),
//       //                     //
//       //                     // SizedBox(height: screenSize.height * 0.02),
//       //                     // Row(
//       //                     //   children: [
//       //                     //     CircleAvatar(
//       //                     //       backgroundColor: Colors.blue[900],
//       //                     //       radius: 30,
//       //                     //       child: IconButton(
//       //                     //         icon: Icon(
//       //                     //           Icons.call,
//       //                     //           color: themeChange.darkTheme
//       //                     //               ? Colors.grey[400]
//       //                     //               : Colors.white,
//       //                     //           size: 30,
//       //                     //         ),
//       //                     //         onPressed: () {
//       //                     //           _launchURL('tel:080-22422741');
//       //                     //         },
//       //                     //       ),
//       //                     //     ),
//       //                     //     SizedBox(
//       //                     //       width: screenSize.width * 0.01,
//       //                     //     ),
//       //                     //     Column(
//       //                     //       children: [
//       //                     //
//       //                     //         InkWell(
//       //                     //           child: Text(
//       //                     //             'tel:080-2242274',
//       //                     //             style: TextStyle(fontSize: 18),
//       //                     //           ),
//       //                     //           onTap: () {
//       //                     //             _launchURL('tel:080-2242274');
//       //                     //           },
//       //                     //         )
//       //                     //       ],
//       //                     //     )
//       //                     //   ],
//       //                     // ),
//       //                     //
//       //                     // SizedBox(height: screenSize.height * 0.02),
//       //                     // // Row(
//       //                     // //   children: [
//       //                     // //     CircleAvatar(
//       //                     // //       backgroundColor: Colors.blue[900],
//       //                     // //       radius: 30,
//       //                     // //       child: IconButton(
//       //                     // //         icon: Icon(
//       //                     // //           Icons.mail,
//       //                     // //           color: themeChange.darkTheme
//       //                     // //               ? Colors.grey[400]
//       //                     // //               : Colors.white,
//       //                     // //           size: 30,
//       //                     // //         ),
//       //                     // //         onPressed: () {
//       //                     // //           _launchURL('tel:6362796957');
//       //                     // //         },
//       //                     // //       ),
//       //                     // //     ),
//       //                     // //     SizedBox(
//       //                     // //       width: screenSize.width * 0.01,
//       //                     // //     ),
//       //                     // //     Column(
//       //                     // //       children: [
//       //                     // //         Text(
//       //                     // //           '',
//       //                     // //           style: GoogleFonts.montserrat(
//       //                     // //               fontSize: 18,
//       //                     // //               color: themeChange.darkTheme
//       //                     // //                   ? Colors.grey[400]
//       //                     // //                   : Colors.grey[900]),
//       //                     // //         ),
//       //                     // //         InkWell(
//       //                     // //           child: Text(
//       //                     // //             '+91-6362796957',
//       //                     // //             style: TextStyle(fontSize: 18),
//       //                     // //           ),
//       //                     // //           onTap: () {
//       //                     // //             _launchURL('tel:6362796957');
//       //                     // //           },
//       //                     // //         )
//       //                     // //       ],
//       //                     // //     )
//       //                     // //   ],
//       //                     // // ),
//       //                     //
//       //                     //
//       //                     //
//       //                     // SizedBox(height: screenSize.height * 0.02),
//       //                     // Row(
//       //                     //   children: [
//       //                     //     CircleAvatar(
//       //                     //       backgroundColor: Colors.pink,
//       //                     //       radius: 30,
//       //                     //       child: IconButton(
//       //                     //         icon: Icon(
//       //                     //           Icons.mail,
//       //                     //           color: themeChange.darkTheme
//       //                     //               ? Colors.grey[400]
//       //                     //               : Colors.white,
//       //                     //           size: 30,
//       //                     //         ),
//       //                     //         onPressed: () {
//       //                     //           _launchURL('mailto:bitrotaract@gmail.com');
//       //                     //         },
//       //                     //       ),
//       //                     //     ),
      //                     //     SizedBox(
      //                     //       width: screenSize.width * 0.01,
      //                     //     ),
      //                     //     SelectableText(
      //                     //       'bitrotaract@gmail.com',
      //                     //       style: GoogleFonts.montserrat(
      //                     //           fontSize: 18,
      //                     //           color: themeChange.darkTheme
      //                     //               ? Colors.grey[400]
      //                     //               : Colors.grey[900]),
      //                     //     )
      //                     //   ],
      //                     // ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             Footer()
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
     // ),
//       floatingActionButton: isScreenSmall
//           ? FloatingActionButton(
//               backgroundColor:
//                   themeChange.darkTheme ? Colors.grey : Colors.black12,
//               onPressed: () {
//                 themeChange.darkTheme = !themeChange.darkTheme;
//               },
//               child: Icon(Icons.brightness_medium,
//                   color:
//                       themeChange.darkTheme ? Colors.white : Colors.grey[800]),
//             )
//           : null,
//     );
//   }
// }
