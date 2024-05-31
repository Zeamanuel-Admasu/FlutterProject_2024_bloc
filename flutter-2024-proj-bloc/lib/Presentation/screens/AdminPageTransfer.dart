import 'package:flutter/material.dart';
import 'admin_page.dart';

void main() {
  runApp(AdminPageTransfer());
}

class AdminPageTransfer extends StatefulWidget {
  @override
  _AdminPageTransferState createState() => _AdminPageTransferState();
}

class _AdminPageTransferState extends State<AdminPageTransfer> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Page',
      home: AnimatedSwitcher(
        duration: Duration(milliseconds: 100),
        child: AdminPage(
          isDarkMode: _isDarkMode,
          toggleTheme: () {
            setState(() {
              _isDarkMode = !_isDarkMode;
            });
          },
        ),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
    );
  }
}
