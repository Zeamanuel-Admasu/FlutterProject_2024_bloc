import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_application_1/application/user/user_bloc.dart';
import 'package:flutter_application_1/application/user/user_event.dart';
import 'package:flutter_application_1/application/user/user_state.dart';
import 'package:flutter_application_1/infrastructure/Repository/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../widgets/themes.dart';
import '../widgets/info_card.dart';
import '../widgets/drawer_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;
  File? image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(userService: UserService()),
      child: BlocBuilder<TokenBloc, TokenState>(
        builder: (context, tokenState) {
          if (tokenState is TokenUpdated) {
            context.read<UserBloc>().add(LoadUser(tokenState.token));
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: isDarkMode ? darkTheme : lightTheme,
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
                    icon: isDarkMode
                        ? const Icon(Icons.light_mode)
                        : const Icon(Icons.dark_mode),
                    onPressed: () {
                      setState(() {
                        isDarkMode = !isDarkMode;
                      });
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
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
                                image != null ? FileImage(image!) : null,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              onPressed: _pickImage,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        if (userState is UserLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (userState is UserLoaded) {
                          return Column(
                            children: [
                              InfoCard(
                                  label: 'First Name',
                                  value: userState.userData[0]),
                              const SizedBox(height: 5),
                              InfoCard(
                                  label: 'Email', value: userState.userData[1]),
                            ],
                          );
                        } else if (userState is UserError) {
                          return Center(child: Text(userState.message));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).goNamed('editProfile');
                      },
                      child: const Text('Edit Profile'),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      key: const Key("logout"),
                      onPressed: () async {
                        try {
                          final token =
                              (context.read<TokenBloc>().state as TokenUpdated)
                                  .token;
                          const url = 'http://192.168.1.110:5000/auth/logout';
                          final response = await http
                              .get(Uri.parse(url), headers: {'token': token});

                          if (response.statusCode >= 200 &&
                              response.statusCode < 300) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Logged out successfully'),
                              duration: const Duration(seconds: 1),
                            ));
                            GoRouter.of(context).go("/login");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error logging out'),
                              duration: const Duration(seconds: 1),
                            ));
                          }
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error occurred: $error'),
                            duration: const Duration(seconds: 1),
                          ));
                        }
                      },
                      child: const Text('Log Out'),
                    ),
                    const SizedBox(height: 40),
                  ],
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
                        title: 'Home',
                        onTap: () => print('Selected item: Home')),
                    DrawerItem(
                        title: 'About',
                        onTap: () => print('Selected item: About')),
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
        },
      ),
    );
  }
}
