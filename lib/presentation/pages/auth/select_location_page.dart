import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/assets.dart';
import 'package:nectar/presentation/widgets/buttons/default_button.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  // available locations, and their cities
  final Map<String, List<String>> locations = {
    'Nigeria': ['Lagos', 'Abuja', 'Port Harcourt'],
    'Ghana': ['Accra', 'Kumasi', 'Tamale'],
    'Kenya': ['Nairobi', 'Mombasa', 'Kisumu'],
    'USA': ['New York', 'Los Angeles', 'Chicago'],
    'UK': ['London', 'Manchester', 'Birmingham, Liverpool', 'Leeds'],
    'Canada': ['Toronto', 'Montreal', 'Vancouver'],
  };

  // selected country
  String selectedCountry = 'Nigeria';

  // selected city
  String selectedCity = 'Lagos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              PngAssets.mask,
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 30,
                left: 25,
                right: 25,
                bottom: 90,
              ),
              child: Column(
                children: [
                  // back button
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SvgPicture.asset(
                    SvgAssets.selectLocation,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Select your location',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Select your location to start ordering',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 90),
                  // location dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.lightBorderGray),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.lightBorderGray),
                      ),
                      labelText: 'Select country',
                      labelStyle: TextStyle(
                        color: AppColors.gray,
                      ),
                    ),
                    value: selectedCountry,
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value!;
                        selectedCity = locations[value]!.first;
                      });
                    },
                    items: locations.keys
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.lightBorderGray),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.lightBorderGray),
                      ),
                      labelText: 'Select city',
                      labelStyle: TextStyle(
                        color: AppColors.gray,
                      ),
                    ),
                    value: selectedCity,
                    items: locations[selectedCountry]!
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DefaultButton(
                    text: "Submit",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
