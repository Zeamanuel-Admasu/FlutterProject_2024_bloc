import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/table/bloc/table_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  AdminPage({Key? key, required this.isDarkMode, required this.toggleTheme})
      : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController num_of_people1 = TextEditingController();
  final TextEditingController tableNum1 = TextEditingController();
  final TextEditingController tableNum2 = TextEditingController();
  final TextEditingController floorNum1 = TextEditingController();
  final TextEditingController type1 = TextEditingController();
  final TextEditingController num_of_people3 = TextEditingController();
  final TextEditingController tableNum3 = TextEditingController();
  final TextEditingController tableNum4 = TextEditingController();
  final TextEditingController floorNum3 = TextEditingController();
  final TextEditingController type3 = TextEditingController();

  // Variable to track which action is being performed
  String currentAction = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Admin Page',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: widget.toggleTheme,
          ),
        ],
        leading: IconButton(
          key: const Key("loginfromadmin"),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAddTableCard(context),
            const SizedBox(height: 16),
            _buildGetTableCard(context),
            const SizedBox(height: 16),
            _buildUpdateTableCard(context),
            const SizedBox(height: 16),
            _buildDeleteTableCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAddTableCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Table',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              key: const Key("add1"),
              controller: tableNum1,
              decoration: const InputDecoration(labelText: 'Table Number'),
            ),
            TextFormField(
              key: const Key("add2"),
              controller: num_of_people1,
              decoration: const InputDecoration(labelText: 'Number of Seats'),
            ),
            TextFormField(
              key: const Key("add3"),
              controller: floorNum1,
              decoration: const InputDecoration(labelText: 'Floor Number'),
            ),
            TextFormField(
              key: const Key("add4"),
              controller: type1,
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                key: const Key("addbtn"),
                onPressed: () async {
                  setState(() {
                    currentAction = 'add';
                  });
                  final String seats = num_of_people1.text;
                  final String floor = floorNum1.text;
                  final String typem = type1.text;
                  final String tableNumber = tableNum1.text;

                  BlocProvider.of<TableBloc>(context).add(AddTable(
                    seats: seats,
                    type: typem,
                    floor: floor,
                    tableNum: tableNumber,
                  ));
                },
                child: const Text('Add'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            BlocListener<TableBloc, TableState>(
              listener: (context, state) {
                if (state is TableFailure && currentAction == 'add') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${state.error}'),
                    duration: const Duration(seconds: 5),
                  ));
                } else if (state is TableSuccess && currentAction == 'add') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Successfully Added'),
                    duration: const Duration(seconds: 5),
                  ));
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetTableCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get Table',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              key: const Key("get"),
              controller: tableNum2,
              decoration: const InputDecoration(labelText: 'Table Number'),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                key: const Key("getbtn"),
                onPressed: () async {
                  setState(() {
                    currentAction = 'get';
                  });
                  final String tableNumber = tableNum2.text;

                  BlocProvider.of<TableBloc>(context)
                      .add(GetTable(tableNum: tableNumber));
                },
                child: const Text('Get Table'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            BlocListener<TableBloc, TableState>(
              listener: (context, state) {
                if (state is TableFailure && currentAction == 'get') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${state.error}'),
                    duration: const Duration(seconds: 5),
                  ));
                } else if (state is TableSuccess && currentAction == 'get') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Table ${state.table['tableNumber']}'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Number of Seats: ${state.table['seats']}'),
                            Text('Floor Number: ${state.table['floor']}'),
                            Text('Type: ${state.table['type']}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateTableCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Table',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              key: const Key("update1"),
              controller: tableNum3,
              decoration: const InputDecoration(labelText: 'Table Number'),
            ),
            TextFormField(
              key: const Key("update2"),
              controller: num_of_people3,
              decoration: const InputDecoration(labelText: 'Number of Seats'),
            ),
            TextFormField(
              key: const Key("update3"),
              controller: floorNum3,
              decoration: const InputDecoration(labelText: 'Floor Number'),
            ),
            TextFormField(
              key: const Key("update4"),
              controller: type3,
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                key: const Key("updatebtn"),
                onPressed: () async {
                  setState(() {
                    currentAction = 'update';
                  });
                  final String seats = num_of_people3.text;
                  final String floor = floorNum3.text;
                  final String typem = type3.text;
                  final String tableNumber = tableNum3.text;

                  BlocProvider.of<TableBloc>(context).add(UpdateTable(
                    seats: seats,
                    type: typem,
                    floor: floor,
                    tableNum: tableNumber,
                  ));
                },
                child: const Text('Update Table'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            BlocListener<TableBloc, TableState>(
              listener: (context, state) {
                if (state is TableFailure && currentAction == 'update') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${state.error}'),
                    duration: const Duration(seconds: 5),
                  ));
                } else if (state is TableSuccess && currentAction == 'update') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Successfully Updated'),
                    duration: const Duration(seconds: 5),
                  ));
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteTableCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete Table',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              key: const Key("delete"),
              controller: tableNum4,
              decoration: const InputDecoration(labelText: 'Table Number'),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                key: const Key("deletebtn"),
                onPressed: () async {
                  setState(() {
                    currentAction = 'delete';
                  });
                  final String tableNumber = tableNum4.text;

                  BlocProvider.of<TableBloc>(context)
                      .add(DeleteTable(tableNum: tableNumber));
                },
                child: const Text('Delete Table'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            BlocListener<TableBloc, TableState>(
              listener: (context, state) {
                if (state is TableFailure && currentAction == 'delete') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${state.error}'),
                    duration: const Duration(seconds: 5),
                  ));
                } else if (state is TableSuccess && currentAction == 'delete') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Successfully Deleted'),
                    duration: const Duration(seconds: 5),
                  ));
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
