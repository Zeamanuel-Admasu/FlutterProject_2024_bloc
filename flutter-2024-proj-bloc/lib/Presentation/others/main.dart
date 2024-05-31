// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Reservation Form',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const ReservationFormPage(),
//     );
//   }
// }

// class ReservationFormPage extends StatefulWidget {
//   const ReservationFormPage({Key? key}) : super(key: key);

//   @override
//   _ReservationFormPageState createState() => _ReservationFormPageState();
// }

// class _ReservationFormPageState extends State<ReservationFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _numberOfPeopleController =
//       TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();
//   String _typeValue = '';
//   bool _isDateFocused = false;
//   bool _isTimeFocused = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reservation Form'),
//       ),
//       backgroundColor: const Color.fromRGBO(8, 68, 104, 1),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   onTap: () {
//                     setState(() {
//                       _isDateFocused = false;
//                       _isTimeFocused = false;
//                     });
//                   },
//                   controller: _numberOfPeopleController,
//                   keyboardType: TextInputType.number,
//                   style: const TextStyle(
//                     color: Color.fromRGBO(159, 188, 204, 1),
//                     fontSize: 20,
//                   ),
//                   decoration: InputDecoration(
//                     labelText: 'Number of People',
//                     labelStyle: TextStyle(
//                       color: !(_isDateFocused || _isTimeFocused)
//                           ? Colors.white
//                           : Color.fromRGBO(159, 188, 204, 1),
//                       fontSize: !(_isDateFocused || _isTimeFocused) ? 24 : 22,
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.people,
//                       color: Color.fromRGBO(245, 154, 123, 1),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                           color: Color.fromRGBO(159, 188, 204, 1), width: 1.8),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:
//                           const BorderSide(color: Colors.blue, width: 3),
//                     ),
//                     contentPadding: const EdgeInsets.all(25),
//                   ),
//                   validator: (value) {
//                     if (value?.isEmpty ?? true) {
//                       return 'Please enter the number of people';
//                     }
//                     int? numberOfPeople = int.tryParse(value!);
//                     if (numberOfPeople == null) {
//                       return 'Please enter a valid number';
//                     }
//                     if (numberOfPeople > 35) {
//                       return 'Maximum number of people exceeded';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 40),
//                 TextFormField(
//                   controller: _dateController,
//                   readOnly: true,
//                   style: TextStyle(
//                     color: _isDateFocused
//                         ? Colors.white
//                         : Color.fromRGBO(159, 188, 204, 1),
//                     fontSize: _isDateFocused
//                         ? 20
//                         : 20, // Increase label font size when focused
//                   ),
//                   onTap: () {
//                     setState(() {
//                       _isDateFocused = true;
//                       _isTimeFocused = false;
//                     });
//                     DatePicker.showDatePicker(
//                       context,
//                       showTitleActions: true,
//                       minTime: DateTime.now(),
//                       onChanged: (date) {},
//                       onConfirm: (date) {
//                         setState(() {
//                           _dateController.text =
//                               "${date.year}-${date.month}-${date.day}";
//                         });
//                       },
//                       currentTime: DateTime.now(),
//                     );
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Date',
//                     labelStyle: TextStyle(
//                       color: _isDateFocused
//                           ? Colors.white
//                           : Color.fromRGBO(159, 188, 204, 1),
//                       fontSize: _isDateFocused
//                           ? 24
//                           : 23, // Increase label font size when focused
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.date_range,
//                       color: Color.fromRGBO(245, 154, 123, 1),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                           color: Color.fromRGBO(159, 188, 204, 1), width: 1.8),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:
//                           const BorderSide(color: Colors.blue, width: 3),
//                     ),
//                     contentPadding: const EdgeInsets.all(25),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 TextFormField(
//                   controller: _timeController,
//                   readOnly: true,
//                   style: TextStyle(
//                     color: _isTimeFocused
//                         ? Colors.white
//                         : Color.fromRGBO(159, 188, 204, 1),
//                     fontSize: _isTimeFocused
//                         ? 20
//                         : 20, // Increase label font size when focused
//                   ),
//                   onTap: () {
//                     setState(() {
//                       _isTimeFocused = true;
//                       _isDateFocused = false;
//                     });
//                     DatePicker.showTimePicker(
//                       context,
//                       showTitleActions: true,
//                       onChanged: (time) {},
//                       onConfirm: (time) {
//                         setState(() {
//                           _timeController.text = "${time.hour}:${time.minute}";
//                         });
//                       },
//                       currentTime: DateTime.now(),
//                     );
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Time',
//                     labelStyle: TextStyle(
//                       color: _isTimeFocused
//                           ? Colors.white
//                           : Color.fromRGBO(159, 188, 204, 1),
//                       fontSize: _isTimeFocused
//                           ? 24
//                           : 23, // Increase label font size when focused
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.access_time,
//                       color: Color.fromRGBO(245, 154, 123, 1),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                           color: Color.fromRGBO(159, 188, 204, 1), width: 1.8),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:
//                           const BorderSide(color: Colors.blue, width: 3),
//                     ),
//                     contentPadding: const EdgeInsets.all(25),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Type',
//                   style: TextStyle(color: Colors.white, fontSize: 22),
//                 ),
//                 const SizedBox(height: 20),
//                 Wrap(
//                   children: <Widget>[
//                     ChoiceChip(
//                       label: const Padding(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 6, horizontal: 4),
//                         child: Text(
//                           'Business',
//                           style: TextStyle(fontSize: 19),
//                         ),
//                       ),
//                       // labelStyle: TextStyle(fontSize: 17),
//                       selected: _typeValue == 'Business',
//                       onSelected: (selected) {
//                         setState(() {
//                           _typeValue = selected ? 'Business' : '';
//                         });
//                       },
//                       selectedColor: const Color.fromRGBO(0, 224, 231, 1),
//                       backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
//                     ),
//                     const SizedBox(width: 10),
//                     ChoiceChip(
//                       label: const Padding(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 6, horizontal: 4),
//                         child: Text(
//                           'Non-Business',
//                           style: TextStyle(fontSize: 19),
//                         ),
//                       ),
//                       selected: _typeValue == 'Non-Business',
//                       onSelected: (selected) {
//                         setState(() {
//                           _typeValue = selected ? 'Non-Business' : '';
//                         });
//                       },
//                       selectedColor: const Color.fromRGBO(0, 224, 231, 1),
//                       backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       print(
//                           'Number of People: ${_numberOfPeopleController.text}');
//                       print('Date: ${_dateController.text}');
//                       print('Time: ${_timeController.text}');
//                       print('Type: $_typeValue');
//                     }
//                   },
//                   child: const Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
