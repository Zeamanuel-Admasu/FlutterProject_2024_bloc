import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traditional Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 38, 136, 41),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {},
                    ),
                    const Text(
                      'Traditional Booking',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Abebe Belete ----------------------',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 0, 204, 255)),
                    ),
                    SizedBox(width: 10.0),
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage('assets/Avatar.png'),
                    ),
                  ],
                ),
              ),
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
              const SizedBox(height: 20),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About us',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'Welcome to Our Traditional Table Reservation System, where we offer a gateway to an enriching and culturally immersive dining experience. Seamlessly reserve tables, plan special events with ease, and elevate your experience with exclusive VIP services for larger groups. Immerse yourself in Ethiopian culture through our diverse menu and ambiance. Save time, avoid hassle, and say goodbye to long waiting times. Join us today and experience the taste of tradition!',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "A",
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle explore button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Explore now'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.grey[200],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.green,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'At Traditional Booking, we are dedicated to revolutionizing the dining experience by seamlessly blending technology with the rich tapestry of Ethiopian culture. As a pioneering table reservation system, we connect patrons with the essence of Ethiopian hospitality, offering an easy and culturally immersive way to reserve tables. Our mission is to provide a platform that celebrates the vibrant flavors and traditions of Ethiopia, ensuring every dining experience is as special as the culture it represents.',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '© All rights Reserved. AAiT, 2024',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
