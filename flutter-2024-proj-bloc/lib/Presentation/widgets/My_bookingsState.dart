import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/others/bookingsClass.dart';

import 'package:flutter_application_1/application/booking/booking_bloc.dart';
import 'package:flutter_application_1/application/booking/booking_event.dart';
import 'package:flutter_application_1/application/booking/booking_state.dart';
import 'package:flutter_application_1/application/cancel/cancel_bloc.dart';
import 'package:flutter_application_1/application/cancel/cancel_event.dart';
import 'package:flutter_application_1/application/cancel/cancel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  String _selectedType = 'current';

  @override
  void initState() {
    super.initState();
    // Dispatch the initial event to load current bookings
    context.read<BookingBloc>().add(LoadBookings(_selectedType));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("My Bookings"),
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
                _buildChoiceChip(context, 'current', 'Current'),
                _buildChoiceChip(context, 'past', 'Past'),
                _buildChoiceChip(context, 'canceled', 'Canceled'),
              ],
            ),
            const SizedBox(height: 10),
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                if (state is BookingLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookingLoaded) {
                  return _buildBookingList(state.bookings, state.type, context);
                } else if (state is BookingError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  ChoiceChip _buildChoiceChip(BuildContext context, String type, String label) {
    return ChoiceChip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      selected: _selectedType == type,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedType = type;
          });
          context.read<BookingBloc>().add(LoadBookings(type));
        }
      },
      selectedColor: Colors.blue,
      backgroundColor: const Color(0xff101520),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  Widget _buildBookingList(
      List<ReservedTable> bookings, String type, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
          itemCount: bookings.length,
          itemBuilder: (BuildContext context, index) {
            final booking = bookings[index];
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
                                "${booking.imageUrl}",
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "${booking.food}",
                                style: const TextStyle(
                                    color: Colors.amberAccent, fontSize: 24),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Type: ${booking.type}',
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 202, 193, 193)),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Number of Guests: ${booking.guests}',
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 202, 193, 193)),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ]),
                      ),
                      const Divider(thickness: 1.4, color: Colors.lightGreen),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color.fromARGB(153, 56, 231, 202),
                              ),
                            ),
                            onPressed: () {
                              context.goNamed("detail", extra: booking);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "View Reservation",
                                style: TextStyle(
                                    color: Color.fromARGB(153, 56, 231, 202)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (type == 'current')
                            BlocConsumer<CancelBloc, CancelState>(
                              listener: (context, state) {
                                if (state is CancelFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.error)),
                                  );
                                } else if (state is CancelSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Reservation Cancelled')),
                                  );
                                  context
                                      .read<BookingBloc>()
                                      .add(LoadBookings('current'));
                                }
                              },
                              builder: (context, state) {
                                return OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color.fromARGB(255, 221, 77, 89),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<CancelBloc>().add(
                                        CancelReservation(booking.time!,
                                            booking.tablesNum, context));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Cancel Reservation",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 221, 77, 89)),
                                    ),
                                  ),
                                );
                              },
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
    );
  }
}
