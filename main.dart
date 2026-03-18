import 'package:flutter/material.dart';

void main() {
  runApp(const AngkasApp());
}

class AngkasApp extends StatelessWidget {
  const AngkasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Angkas Booking',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomeScreen(),
    );
  }
}

// ------------------ HOME SCREEN ------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'CHARIDE!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellowAccent.shade700,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookingScreen()),
                  );
                },
                child: const Text(
                  'Book a Ride',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ BOOKING SCREEN ------------------
class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String pickup = '';
  String dropoff = '';
  String bikeType = 'Standard';
  final List<String> bikeOptions = ['Standard', 'Premium', 'Cargo'];

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Ride'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Pickup Location',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.location_on, color: Colors.orange),
                  errorText: showError && pickup.isEmpty
                      ? 'Pickup required'
                      : null,
                  filled: true,
                  fillColor: Colors.white70,
                ),
                onChanged: (val) {
                  setState(() {
                    pickup = val;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Drop-off Location',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.flag, color: Colors.green),
                  errorText: showError && dropoff.isEmpty
                      ? 'Drop-off required'
                      : null,
                  filled: true,
                  fillColor: Colors.white70,
                ),
                onChanged: (val) {
                  setState(() {
                    dropoff = val;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Bike Type',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                value: bikeType,
                items: bikeOptions
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    bikeType = val!;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellowAccent.shade700,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    showError = true;
                  });
                  if (pickup.isNotEmpty && dropoff.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationScreen(
                          pickup: pickup,
                          dropoff: dropoff,
                          bikeType: bikeType,
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ CONFIRMATION SCREEN ------------------
class ConfirmationScreen extends StatelessWidget {
  final String pickup;
  final String dropoff;
  final String bikeType;

  const ConfirmationScreen({
    super.key,
    required this.pickup,
    required this.dropoff,
    required this.bikeType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            color: Colors.white70,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '🎉 Ride Booked!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Pickup: $pickup', style: const TextStyle(fontSize: 18)),
                  Text('Drop-off: $dropoff', style: const TextStyle(fontSize: 18)),
                  Text('Bike Type: $bikeType', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text('Book Another Ride', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
