import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:placement_original/footer.dart';
import 'package:placement_original/services/Database.dart';
import 'package:placement_original/services/sharedPref.dart';
import 'package:url_launcher/url_launcher.dart';
class Company extends StatefulWidget {
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  ScrollController _scrollController;
  double _opacity = 0;
  double _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  List _isHovering = [false, false, false, false, false, false, false];
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    bool isScreenSmall = screenSize.width < 800;
    _opacity = _scrollPosition < screenSize.height * 0.4 ? 0.75 : 1.0;

    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: isScreenSmall
          ? AppBar(


        title: Image.asset(
          'bitlogo.png',
          fit: BoxFit.contain,
          height: screenSize.height * 0.08,
        ),

        backgroundColor: Color.fromRGBO(42, 42, 114,0.9 ),
      )
          : PreferredSize(
        preferredSize: Size(screenSize.width, screenSize.height * 0.15),
        child: Card(

          elevation: 10,


          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end:Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.9),
                    Color.fromRGBO(42, 42, 114,0.9 ),
                  ]
              ),
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 0, horizontal: screenSize.width * 0.1),
              child: Row(
                children: [
                  Image.asset('bitlogo.png', height: 250.0),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          onHover: (ishoverd) {
                            setState(() {
                              _isHovering[0] = ishoverd;
                            });
                          },
                          child: Text(
                            'Home',
                            style: GoogleFonts.aBeeZee(
                                color: _isHovering[0]
                                    ? Colors.white
                                    : Colors.white,

                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(width: screenSize.width / 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/Facilities');
                          },
                          onHover: (ishoverd) {
                            setState(() {
                              _isHovering[1] = ishoverd;
                            });
                          },
                          child: Text(
                            'Facilities and\nObjectives',
                            style: GoogleFonts.aBeeZee(
                                color: _isHovering[1]
                                    ? Colors.white
                                    : Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: screenSize.width / 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/Placements');
                          },
                          onHover: (ishoverd) {
                            setState(() {
                              _isHovering[2] = ishoverd;
                            });
                          },
                          child:

                          Text(
                            'Placements',
                            style: GoogleFonts.aBeeZee(
                                color: _isHovering[2]
                                    ? Colors.white
                                    : Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),


                          ),

                        ),

                        IconButton(onPressed: () {
                          Navigator.pushNamed(context, '/Stats');
                        },

                            icon:Icon(Icons.arrow_drop_down)),
                        SizedBox(width: screenSize.width / 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/Company');
                          },
                          onHover: (ishoverd) {
                            setState(() {
                              _isHovering[3] = ishoverd;
                            });
                          },
                          child: Text(
                            'Company\nDetails',
                            style: GoogleFonts.aBeeZee(
                                color: _isHovering[3]
                                    ? Colors.white
                                    : Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600

                            ),
                          ),
                        ),
                        SizedBox(width: screenSize.width / 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/contact_us');
                          },
                          onHover: (ishoverd) {
                            setState(() {
                              _isHovering[4] = ishoverd;
                            });
                          },
                          child: Text(
                            'Contact Us',
                            style: GoogleFonts.aBeeZee(
                                color: _isHovering[4]
                                    ? Colors.white
                                    : Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  themeChange.isSignedIn
                      ? DropdownButton<String>(

                    iconSize: 0,
                    value: "DashBoard",
                    elevation: 8,
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (val) {
                      setState(() {
                        if (val.compareTo("Sign Out") == 0) {
                          Database( "", "")
                              .signOut();
                          themeChange.username = "";
                          themeChange.email = "";
                          themeChange.isSignedIn = false;
                        } else if (val.compareTo("DashBoard") == 0)
                          Navigator.pushNamed(
                              context, '/dashboard');
                      });
                    },
                    style: GoogleFonts.montserrat(
                      color: Colors.orange,
                    ),
                    items: <String>[
                      'DashBoard',
                      'Sign Out'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                      : Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                        onHover: (val) {
                          setState(() {
                            _isHovering[5] = val;
                          });
                        },
                        child: Text(
                          "Register",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              color: _isHovering[5]
                                  ? Colors.pink
                                  : Colors.orange,
                              fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        onHover: (val) {
                          setState(() {
                            _isHovering[6] = val;
                          });
                        },
                        child: Text(
                          "Log In",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              color: _isHovering[6]
                                  ? Colors.pink
                                  : Colors.orange,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenSize.width * 0.01)
                ],
              ),
            ),
          ),
        ),
      ),

      drawer: isScreenSmall
          ? Drawer(
        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Column(
                  children: [
                    Image.asset('bitlogo.png',
                        height: 120.0, width: 250.0, scale: 0.1),
                    Text(''),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.9),
                        Color.fromRGBO(42, 42, 114,0.9 ),
                      ]
                  ),
                )
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home, color: Colors.grey),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: Text('Facilities'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pushNamed(context, '/Facilities');
              },
            ),
            ListTile(
              title: Text('Placements'),
              leading: Icon(Icons.calendar_today),
              onTap: () {
                Navigator.pushNamed(context, '/Placements');
              },
            ),
            ListTile(
              title: Text('Company\nDetails'),
              leading: Icon(Icons.people),
              onTap: () {
                Navigator.pushNamed(context, '/Company');
              },
            ),
            ListTile(
              title: Text('Contact us'),
              leading: Icon(Icons.contact_mail),
              onTap: () {
                Navigator.pushNamed(context, '/contact_us');
              },
            ),
            themeChange.isSignedIn
                ? Column(
              children: [
                ListTile(
                  title: Text('DashBoard'),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
                ListTile(
                  title: Text('Sign Out'),
                  leading: Image.network(
                      'https://img.icons8.com/fluent-systems-regular/24/000000/exit.png'),
                  onTap: () {
                    Database( "", "").signOut();
                    themeChange.username = "";
                    themeChange.email = "";
                    themeChange.isSignedIn = false;
                  },
                ),
              ],
            )
                : Column(
              children: [
                ListTile(
                  title: Text('Register'),
                  leading: Icon(Icons.person_add),
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                ListTile(
                  title: Text('Log In'),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ],
            ),
          ],
        ),
      )
          : null,

      backgroundColor: Theme.of(context).backgroundColor,

      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Container(

              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding:EdgeInsets.all(10),
                        child: Container(
                          height: screenSize.height*0.1,


                          width: screenSize.width,
                        ),
                      ),
                    ],
                  ),

                          SizedBox(height: 50.0),

                    Row(

                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(


                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0,0),
                            child: Card(
                              elevation: 20.0,
                              // shadowColor: themeChange.darkTheme
                              //     ? Colors.blue
                              //     : Colors.orange,
                              child: Row(
                                children: [

                                  SizedBox(
                                    child:Image.asset(
                                      "info.png",


                                      height: screenSize.height * 0.20,
                                      width: screenSize.width * 0.2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 10,),


                                    Container(

                                      width: screenSize.width * 0.2,
                                      height: screenSize.height * 0.1,



                                      child:
                                      Center(
                                        child: Text(
                                          'INFOSYS',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.monda(
                                              fontSize: 22.0,
                                              color: themeChange.darkTheme
                                                  ? Colors.white
                                                  : Colors.grey[900]),
                                        ),
                                      ),
                                    ),

                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [

                         Expanded(
                         
                          child: ExpansionCard(
                            title: Row(
                            children: [
                              Text("heeeeeeee"),
                            ],
                            ),
                            onExpansionChanged: (onExpand){
                              if(onExpand == true){
                                setState(() {
                                  color:Colors.grey;
                                });

                              }else{
                                setState(() {
                                  color:Colors.white;
                                });
                              }
                            },

                          ),
                          
                        ),

                    ],

                  ),
        Footer()
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: isScreenSmall
          ? FloatingActionButton(
        backgroundColor:
        themeChange.darkTheme ? Colors.grey : Colors.black12,
        onPressed: () {
          themeChange.darkTheme = !themeChange.darkTheme;
        },
        child: Icon(Icons.brightness_medium,
            color:
            themeChange.darkTheme ? Colors.white : Colors.grey[800]),
      )
          : null,
    );
  }
}
