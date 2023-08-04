import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nectar/data/models/address.dart';
import 'package:nectar/data/models/user.dart';
import 'package:nectar/data/services/firebase_firestore_service.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/app_router.dart';
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
    'USA': ['New York', 'Los Angeles', 'Chicago'],
    'UK': ['London', 'Manchester', 'Birmingham, Liverpool', 'Leeds'],
    'Canada': ['Toronto', 'Montreal', 'Vancouver'],
    'Australia': ['Sydney', 'Melbourne', 'Brisbane'],
    'India': ['Mumbai', 'Delhi', 'Bangalore', 'Hyderabad'],
    'UAE': ['Dubai', 'Abu Dhabi', 'Sharjah'],
    'Singapore': ['Singapore', 'Jurong East', 'Woodlands'],
    'France': ['Paris', 'Marseille', 'Lyon'],
    'Germany': ['Berlin', 'Hamburg', 'Munich', 'Cologne'],
    'Italy': ['Rome', 'Milan', 'Naples', 'Turin', 'Palermo', 'Genoa'],
    'Spain': [
      'Madrid',
      'Barcelona',
      'Valencia',
      'Seville',
      'Zaragoza',
      'Málaga',
      'Murcia',
      'Palma',
      'Las Palmas de Gran Canaria',
      'Bilbao'
    ],
    'Mexico': [
      'Mexico City',
      'Ecatepec',
      'Guadalajara',
      'Puebla',
      'Ciudad Juárez',
      'Tijuana',
      'León',
      'Zapopan',
      'Monterrey',
      'Nezahualcóyotl'
    ],
    'Nigeria': ['Lagos', 'Abuja', 'Port Harcourt'],
    'Ghana': ['Accra', 'Kumasi', 'Tamale'],
    'Kenya': ['Nairobi', 'Mombasa', 'Kisumu'],
  };

  // selected country
  String selectedCountry =
      Hive.box('myBox').get('user', defaultValue: 'USA').address.country;

  // selected city
  String selectedCity =
      Hive.box('myBox').get('user', defaultValue: 'New York').address.city;

  // selected address
  String selectedAddress =
      Hive.box('myBox').get('user', defaultValue: '').address.street;

  @override
  Widget build(BuildContext context) {
    if (selectedCountry.isEmpty) {
      selectedCountry = 'USA';
    }

    if (selectedCity.isEmpty) {
      selectedCity = 'New York';
    }

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
                        selectedAddress = '';
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
                        selectedAddress = '';
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  if (selectedAddress.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightBorderGray,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Selected location',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // remove selected location
                              IconButton(
                                onPressed: () async {
                                  selectedAddress = '';
                                  setState(() {});
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$selectedAddress, $selectedCity, $selectedCountry',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  // select location in the city
                  DefaultButton(
                    backgroundColor: AppColors.lightGray,
                    text: "Select location",
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.setLocationMapRoute,
                      ).then((value) async {
                        if (value != null) {
                          setState(() {
                            selectedAddress = value as String;
                          });
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // submit button
                  DefaultButton(
                    text: "Submit",
                    onTap: () async {
                      try {
                        if (selectedAddress.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select your location',
                              ),
                              backgroundColor: AppColors.error,
                            ),
                          );
                          return;
                        }
                        // show loading
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        final user = Hive.box("myBox").get("user") as User;
                        user.address = Address(
                          country: selectedCountry,
                          city: selectedCity,
                          street: selectedAddress,
                          createdAt: user.address.createdAt,
                          updatedAt: DateTime.now(),
                        );
                        await Hive.box("myBox").put("user", user);
                        await FirebaseFirestoreService()
                            .updateDocumentWithQuery(
                          collection: "users",
                          field: "uid",
                          value: user.uid,
                          data: user.toMap(),
                        );

                        // hide loading and navigate to home
                        if (mounted) {
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouter.homeRoute,
                            (route) => false,
                          );
                        }
                      } catch (e, s) {
                        debugPrintStack(label: e.toString(), stackTrace: s);
                      }
                    },
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
