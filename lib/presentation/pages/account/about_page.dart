import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _getPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // package info
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _packageInfo.appName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Version ${_packageInfo.version}+${_packageInfo.buildNumber}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'About Nectar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nectar is an online groceries shopping app built with Flutter, Firebase and Bloc pattern. It allows users to browse and purchase groceries from the comfort of their own home, with fast and reliable delivery.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'At Nectar, our mission is to make grocery shopping as easy and convenient as possible. We believe that everyone should have access to fresh, healthy food, and we strive to make that a reality for our customers.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // package info
          ],
        ),
      ),
    );
  }
}
