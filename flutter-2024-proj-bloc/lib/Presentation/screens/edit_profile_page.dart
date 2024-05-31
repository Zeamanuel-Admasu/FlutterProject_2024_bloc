import 'package:flutter/material.dart';
// import 'package:user_profile/lib/pages/edit_profile_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration:const InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              decoration:const InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              decoration:const InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              decoration:const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save profile changes
              },
              child:const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
