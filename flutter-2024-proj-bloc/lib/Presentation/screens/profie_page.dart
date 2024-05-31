import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/themes.dart';
import './edit_profile_page.dart';
import '../widgets/info_card.dart';
import '../widgets/drawer_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkMode = false;
  File? _image;
  final String _firstName = '';
  final String _lastName = '';
  final String _phone = '';
  final String _email = '';

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? darkTheme : lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: _isDarkMode
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/background.jpg'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: _pickImage,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                InfoCard(label: 'First Name', value: _firstName),
                const SizedBox(height: 40),
                InfoCard(label: 'Last Name', value: _lastName),
                const SizedBox(height: 40),
                InfoCard(label: 'Phone', value: _phone),
                const SizedBox(height: 40),
                InfoCard(label: 'Email', value: _email),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage()),
                    );
                  },
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Implement sign out functionality
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text('Menu'),
              ),
              const SizedBox(height: 20),
              DrawerItem(
                  title: 'Home', onTap: () => print('Selected item: Home')),
              DrawerItem(
                  title: 'About', onTap: () => print('Selected item: About')),
              DrawerItem(
                  title: 'Booking History',
                  onTap: () => print('Selected item: Booking History')),
              DrawerItem(
                  title: 'Reservation',
                  onTap: () => print('Selected item: Reservation')),
              DrawerItem(
                  title: 'Sign Out',
                  onTap: () => print('Selected item: Sign Out')),
            ],
          ),
        ),
      ),
    );
  }
}
