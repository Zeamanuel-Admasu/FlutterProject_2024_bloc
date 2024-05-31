import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Circular Food Table'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                image: DecorationImage(
                                    image: AssetImage("assets/table.jpg"),
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
                      SizedBox(width: 15),
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
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            '${foodDescription['${foodIndex[changingIndex]}']}',
                            style: GoogleFonts.palanquin(fontSize: 17),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FadeInTextExample(),
//     );
//   }
// }

// class FadeInTextExample extends StatefulWidget {
//   @override
//   _FadeInTextExampleState createState() => _FadeInTextExampleState();
// }

// class _FadeInTextExampleState extends State<FadeInTextExample> {
//   String _text1 = 'Text 1';
//   String _text2 = 'Text 2';
//   String _text3 = 'Text 3';
//   String _text4 = 'Text 4';

//   void _changeText() {
//     setState(() {
//       _text1 = 'New Text 1';
//       _text2 = 'New Text 2';
//       _text3 = 'New Text 3';
//       _text4 = 'New Text 4';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fade In Text Example'),
//       ),
//       backgroundColor: const Color(0xff101520),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AnimatedOpacity(
//               opacity: 1.0,
//               duration: Duration(seconds: 3),
//               child: Text(
//                 _text1,
//                 style: TextStyle(fontSize: 24),
//               ),
//             ),
//             AnimatedOpacity(
//               opacity: 1.0,
//               duration: Duration(seconds: 3),
//               child: Text(
//                 _text2,
//                 style: TextStyle(fontSize: 24),
//               ),
//             ),
//             AnimatedOpacity(
//               opacity: 1.0,
//               duration: Duration(seconds: 3),
//               child: Text(
//                 _text3,
//                 style: TextStyle(fontSize: 24),
//               ),
//             ),
//             AnimatedOpacity(
//               opacity: 1.0,
//               duration: Duration(seconds: 3),
//               child: Text(
//                 _text4,
//                 style: TextStyle(fontSize: 24),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _changeText,
//               child: Text('Change Text'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
