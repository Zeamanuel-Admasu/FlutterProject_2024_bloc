import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/table_bloc.dart';
import '../blocs/table_event.dart';
import '../blocs/table_state.dart';
import '../services/table_service.dart';
import '../Presentation/widgets/toggle_button.dart';
import '../Presentation/widgets/date_picker.dart';

class AdminPage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const AdminPage({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TableBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Center(
                  child: Text(
                'Admin Page',
                style: TextStyle(color: Colors.white),
              )),
              actions: [
                ToggleButton(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Center(
                      child: DatePickerWidget(
                        onDateSelected: (DateTime? pickedDate) {
                          if (pickedDate != null) {
                            print('Selected date: $pickedDate');
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<TableBloc, TableState>(
                    builder: (context, state) {
                      if (state is TableLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TableLoaded) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.tables.length,
                          itemBuilder: (context, index) {
                            final table = state.tables[index];
                            return ListTile(
                              title: Text('Table Number: ${table['tableNumber']}'),
                              subtitle: Text('Seats: ${table['Number_of_seats']} | Type: ${table['Type']}'),
                            );
                          },
                        );
                      } else if (state is TableError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildAddTableForm(context),
                  const SizedBox(height: 16),
                  _buildGetSingleTableForm(context),
                  const SizedBox(height: 16),
                  _buildUpdateTableForm(context),
                  const SizedBox(height: 16),
                  _buildDeleteTableForm(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddTableForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _tableNumController = TextEditingController();
    final _seatsController = TextEditingController();
    final _typeController = TextEditingController();
    final _floorController = TextEditingController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Table',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: _tableNumController,
                decoration: const InputDecoration(labelText: 'Table Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a table number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _seatsController,
                decoration: const InputDecoration(labelText: 'Number of Seats'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of seats';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _floorController,
                decoration: const InputDecoration(labelText: 'Floor Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the floor number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final tableData = {
                        'tableNUM': _tableNumController.text,
                        'seats': _seatsController.text,
                        'type': _typeController.text,
                        'floor': _floorController.text,
                      };
                      print(tableData);
                      context.read<TableBloc>().add(AddTable(tableData));
                    }
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGetSingleTableForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _tableNumController = TextEditingController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get Single Table',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: _tableNumController,
                decoration: const InputDecoration(labelText: 'Table Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a table number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<TableBloc>(context).add(GetSingleTable(int.parse(_tableNumController.text)));
                    }
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
              BlocBuilder<TableBloc, TableState>(
                builder: (context, state) {
                  if (state is SingleTableLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Table Info: ${state.table.toString()}'),
                    );
                  } else if (state is TableError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Error: ${state.message}'),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateTableForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _tableNumController = TextEditingController();
    final _seatsController = TextEditingController();
    final _typeController = TextEditingController();
    final _floorController = TextEditingController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Table',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: _tableNumController,
                decoration: const InputDecoration(labelText: 'Table Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a table number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _seatsController,
                decoration: const InputDecoration(labelText: 'Number of Seats'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of seats';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _floorController,
                decoration: const InputDecoration(labelText: 'Floor Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the floor number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final tableData = {
                        'updseats': int.parse(_seatsController.text),
                        'updtype': _typeController.text,
                        'updfloor': int.parse(_floorController.text),
                      };
                      BlocProvider.of<TableBloc>(context).add(UpdateTable(int.parse(_tableNumController.text), tableData));
                    }
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteTableForm(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final _tableNumController = TextEditingController();

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete Table',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              controller: _tableNumController,
              decoration: const InputDecoration(labelText: 'Table Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a table number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final tableNumber = int.parse(_tableNumController.text);
                    context.read<TableBloc>().add(DeleteTable(tableNumber));
                  }
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
          ],
        ),
      ),
    ),
  );
}

}
