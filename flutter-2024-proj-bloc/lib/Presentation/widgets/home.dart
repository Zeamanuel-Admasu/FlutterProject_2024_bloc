import 'package:flutter/material.dart';
import '../screens/about.dart';
import 'custom_card.dart';
import 'food_image.dart';
import 'get_color.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Food Table',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CircularFoodTable(),
    );
  }
}

class CircularFoodTable extends StatefulWidget {
  @override
  _CircularFoodTableState createState() => _CircularFoodTableState();
}

class _CircularFoodTableState extends State<CircularFoodTable>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  double _rotationAngle = 0.0;
  List<Widget> dishes = [];
  List<String> foodIndex = ["Doro", "Kitfo", "Pasta", "Tibs"];
  Map<String, String> foodDescription = {
    "Doro":
        "A Habesha Masterpiece,A national dish of our country. Enjoy one made by our chefs",
    "Kitfo":
        "The Beloved Gurage dish. It can be raw or fried. You can devour with Kocho,Injera,bread or whatever you like.",
    "Pasta":
        "An Italian favorite in Ethiopia. One of the finest dishes of the world is available here with many different side dishes",
    "Tibs":
        "Another Cultural food common in Ethiopia. We have sheep,cow and goat tibs that you can enjoy with your family and friends"
  };
  int changingIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {
          _rotationAngle = _rotationAnimation.value;
        });
      });
    _buildDishesAroundTable();
  }

  void changeText(bool forward) {
    setState(() {
      forward ? changingIndex++ : changingIndex--;
      if (changingIndex == 4) {
        changingIndex = 0;
      } else if (changingIndex == -1) {
        changingIndex = 3;
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _rotateTable(double angle) {
    double targetAngle =
        (_rotationAngle + (4 * angle)) % (2 * pi); // Double the angle parameter

    _rotationAnimation = Tween<double>(
      begin: _rotationAngle,
      end: targetAngle,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.reset();
    _animationController.duration =
        Duration(milliseconds: 900); // Restore original animation duration
    _animationController.forward();

    _rotationAngle = targetAngle;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff101520), Color(0xff101520)],
        ),
      ),
      child: MaterialApp(
        title: 'Traditional Restaurant Website',
        home: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 61, 233, 218),
            title: const Text(
              'Traditional Booking',
              style: TextStyle(
                fontFamily: 'C',
                fontSize: 25,
                color: Color.fromARGB(153, 56, 231, 202),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Abebe Belete',
                        style: TextStyle(fontSize: 20.0, color: Colors.amber),
                      ),
                      SizedBox(width: 16.0),
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: AssetImage('assets/Avatar.png'),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/totot.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            const Color.fromARGB(255, 221, 77, 89)
                                .withOpacity(0.1),
                            BlendMode.lighten,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Traditional Booking',
                              style: TextStyle(
                                color: Color.fromARGB(255, 202, 193, 193),
                                fontSize: 40,
                                fontFamily: "B",
                                shadows: [
                                  Shadow(
                                    blurRadius: 20.0,
                                    color: Color(0xff101520),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            RichText(
                              text: TextSpan(
                                children: [
                                  for (int i = 0; i < 'WELCOME'.length; i++)
                                    TextSpan(
                                      text: 'WELCOME'[i],
                                      style: TextStyle(
                                        color: getColorForLetter(i),
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: const Color(0xff182032),
                  alignment: Alignment.center,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Discover Our Reservation",
                          style: TextStyle(
                            color: Color.fromARGB(255, 221, 77, 89),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Types",
                          style: TextStyle(
                            color: Color.fromARGB(255, 221, 77, 89),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            height: 450,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const [
                                CustomCardWidget(
                                  title: 'Business Type',
                                  description:
                                      'We offer reservation system for people starting from 1 to 20 in need of having cultural Ehiopian cusine, while discussing crucial business matters',
                                  imagePath: 'assets/business.jpg',
                                ),
                                CustomCardWidget(
                                  title: 'Family Type',
                                  description:
                                      'You can reserve a table with the specific number of people in your family. Have a wonderfull time with them without worrying about details of reservations.',
                                  imagePath: 'assets/B.jpg',
                                ),
                                CustomCardWidget(
                                  title: 'for different reunions',
                                  description:
                                      'We are happy to tell you that you can reserve tables and reunite with your friends. You dont have to worry about anything. You are only one call Away',
                                  imagePath: 'assets/D.jpg',
                                ),
                                CustomCardWidget(
                                  title: 'Romantic Dates for couples',
                                  description:
                                      'Have a wonderful time with your loved ones. Just be ready to arrive in time. One Click Away!!! ',
                                  imagePath: 'assets/couple.jpeg',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 70,
                    color: Colors.white,
                    child: Center(
                      child: Text("Popular feasts on the table",
                          style: GoogleFonts.ibmPlexSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff101520))),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRect(
                            child: Transform.translate(
                              offset: Offset(-285, 0),
                              child: Row(
                                children: [
                                  AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      return Transform.rotate(
                                        angle: _rotationAngle,
                                        child: Container(
                                          width: 420,
                                          height: 420,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.7),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/table.jpg"),
                                                repeat: ImageRepeat.repeat),
                                            shape: BoxShape.circle,
                                            color: Colors.brown,
                                          ),
                                          child: Stack(
                                            children: dishes,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 25),
                                  Container(
                                    width: 200,
                                    height: 200,
                                    // color: Colors.amberAccent,
                                    child: Column(children: [
                                      AnimatedOpacity(
                                        duration: Duration(seconds: 1),
                                        opacity: 1,
                                        child: Text(
                                          '${foodIndex[changingIndex]}',
                                          style: GoogleFonts.vesperLibre(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        '${foodDescription['${foodIndex[changingIndex]}']}',
                                        style:
                                            GoogleFonts.palanquin(fontSize: 17),
                                      )
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 160),
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  _rotateTable(-pi / 8);
                                  changeText(false); // Rotate clockwise
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () {
                                  _rotateTable(pi / 8);
                                  changeText(true); // Rotate counterclockwise
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  transform: Matrix4.rotationZ(0.1),
                  width: 300,
                  height: 200,
                  child: Image.asset(
                    'assets/D.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const AboutPage()));
                        },
                        child: const Text("About Us"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _buildDishesAroundTable() {
    List<String> foods = [
      "assets/doro.png",
      "assets/tibs.png",
      "assets/pasta.png",
      "assets/kitfo.png"
    ];

    dishes.clear(); // Clear existing dishes

    double radius = 140;
    double dishAngleIncrement =
        2 * pi / 4; // Change dish angle increment to create 4 dishes

    for (int i = 0; i < 4; i++) {
      // Change loop condition to create 4 dishes
      double currentAngle =
          dishAngleIncrement * i + _rotationAngle; // Consider rotation angle
      double offsetX = radius * cos(currentAngle);
      double offsetY = radius * sin(currentAngle);

      dishes.add(
        Positioned(
          top: 150 + offsetY - 0,
          left: 150 + offsetX - 2,
          child: _buildDishWidget(i, foods[i]),
        ),
      );
    }
  }

  Widget _buildDishWidget(int index, String food) {
    return GestureDetector(
      onTap: () {
        _rotateTable((pi / 8) * (index - 4));
      },
      child: Image.asset(
        '$food',
        width: 120,
        height: 120,
      ),
    );
  }
}
