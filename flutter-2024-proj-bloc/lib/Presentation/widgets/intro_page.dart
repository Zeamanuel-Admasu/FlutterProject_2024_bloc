import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/login_page.dart';

class IntroBody extends StatefulWidget {
  const IntroBody({Key? key}) : super(key: key);

  @override
  _IntroBodyState createState() => _IntroBodyState();
}

class _IntroBodyState extends State<IntroBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff182032),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: const Color(0xff182032),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      color: const Color.fromARGB(255, 29, 36, 54),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 36),
                            Container(
                              height: 300,
                              width: 300,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/F.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            FadeTransition(
                              opacity: _animation,
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  const Center(
                                    child: Text(
                                      "Manage Your Table",
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontFamily: "B",
                                        color: Color.fromARGB(255, 221, 77, 89),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Center(
                                    child: Text(
                                      "Reservation",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontFamily: "B",
                                        color: Color.fromARGB(255, 221, 77, 89),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).go("/login");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "Let's Start",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
