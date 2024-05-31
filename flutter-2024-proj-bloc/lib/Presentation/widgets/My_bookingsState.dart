import 'package:flutter/material.dart';
import '../others/bookingsClass.dart';
import '../screens/ExpandedBooking.dart';
import '../screens/bookings.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List<ReservedTable> currentTables = [
    ReservedTable(2, "2024-13-04", "11:34", "Business", "assets/buna.jpeg",
        "Buna", "Arat kilo"),
    ReservedTable(7, "2024-14-09", "01:00", "Non-Business",
        "assets/beyaynet.png", "Beyaynet", "Arat kilo"),
    ReservedTable(22, "2024-05-04", "5:09", "Business", "assets/kitfo.png",
        "kitfo", "Arat kilo")
  ];

  List<ReservedTable> pastTables = [
    ReservedTable(2, "2024-13-04", "11:34", "Business", "assets/buna.jpeg",
        "tibs", "Arat kilo"),
    ReservedTable(7, "2024-14-09", "01:00", "Non-Business",
        "assets/beyaynet.png", "Beyaynet", "Arat kilo"),
    ReservedTable(22, "2024-05-04", "5:09", "Business", "assets/pasta.jpeg",
        "Pasta", "Arat kilo")
  ];

  List<ReservedTable> canceledTables = [
    ReservedTable(2, "2024-13-04", "11:34", "Business", "assets/buna.jpeg",
        "canceled", "Tor hailoch"),
    ReservedTable(7, "2024-14-09", "01:00", "Non-Business",
        "assets/beyaynet.png", "Beyaynet", "Arat kilo"),
    ReservedTable(22, "2024-05-04", "5:09", "Business", "assets/pasta.jpeg",
        "Pasta", "Arat kilo")
  ];

  String _selectedChoice = 'current';

  @override
  Widget build(BuildContext context) {
    double screenWidth = (MediaQuery.of(context).size.width);
    List<ReservedTable> tables = [];

    switch (_selectedChoice) {
      case 'current':
        tables = currentTables;
        break;
      case 'past':
        tables = pastTables;
        break;
      case 'canceled':
        tables = canceledTables;
        break;
      default:
        tables = currentTables;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "My Bookings",
          ),
        ),
      ),
      backgroundColor: const Color(0xff101520),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            Wrap(
              spacing: 15,
              children: <Widget>[
                ChoiceChip(
                  label: const Text(
                    'Current',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  selected: _selectedChoice == 'current',
                  onSelected: (selected) {
                    setState(() {
                      _selectedChoice = selected ? 'current' : '';
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: const Color(0xff101520),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ChoiceChip(
                  label: const Text(
                    'Past',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  selected: _selectedChoice == 'past',
                  onSelected: (selected) {
                    setState(() {
                      _selectedChoice = selected ? 'past' : '';
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: const Color(0xff101520),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ChoiceChip(
                  label: const Text(
                    'Canceled',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  selected: _selectedChoice == 'canceled',
                  onSelected: (selected) {
                    setState(() {
                      _selectedChoice = selected ? 'canceled' : '';
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: const Color(0xff101520),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: tables.length,
                  itemBuilder: (BuildContext context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: const Color(0xff182032),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: Row(children: [
                                  SizedBox(
                                    width: 170,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.asset(
                                        "${tables[index].imageUrl}",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        "${tables[index].food}",
                                        style: const TextStyle(
                                            color: Colors.amberAccent,
                                            fontSize: 24),
                                      ),
                                      const SizedBox(height: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 5.0),
                                          Text(
                                            'Type: ${tables[index].type}',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 202, 193, 193)),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            'Number of Guests: ${tables[index].guests}',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 202, 193, 193)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ]),
                              ),
                              const Divider(
                                thickness: 1.4,
                                color: Colors.lightGreen,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color:
                                            Color.fromARGB(153, 56, 231, 202),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/detail',
                                          arguments: tables[index]);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "View Reservation",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                153, 56, 231, 202)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  if (_selectedChoice == 'current')
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Color.fromARGB(255, 221, 77,
                                              89), // Change color here
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Cancel Reservation",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 221, 77, 89)),
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
