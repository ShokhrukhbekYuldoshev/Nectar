import 'package:flutter/material.dart';

// TODO: Implement MyDetailsPage

class MyDetailsPage extends StatefulWidget {
  const MyDetailsPage({Key? key}) : super(key: key);

  @override
  State<MyDetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  String _name = '';
  String _email = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Details'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Phone',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
              ),
              onChanged: (value) {
                setState(() {
                  _phone = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
