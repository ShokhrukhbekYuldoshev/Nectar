import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nectar/data/models/user.dart';
import 'package:nectar/data/services/firebase_firestore_service.dart';
import 'package:nectar/data/services/firebase_storage_service.dart';
import 'package:nectar/presentation/utils/helpers.dart';
import 'package:nectar/presentation/widgets/buttons/default_button.dart';

class MyDetailsPage extends StatefulWidget {
  const MyDetailsPage({Key? key}) : super(key: key);

  @override
  State<MyDetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(
    text: Hive.box('myBox').get('user').displayName,
  );
  final _emailController = TextEditingController(
    text: Hive.box('myBox').get('user').email,
  );
  final _phoneController = TextEditingController(
    text: Hive.box('myBox').get('user').phoneNumber,
  );

  XFile? _image;
  String? imageUrl = Hive.box('myBox').get('user').photoUrl;

  bool ignoring = false;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ignoring,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Details'),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
          child: DefaultButton(
            onTap: () async {
              try {
                setState(() {
                  ignoring = true;
                });

                // show loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                if (_formKey.currentState!.validate()) {
                  // upload image
                  if (_image != null) {
                    await FirebaseStorageService()
                        .uploadFile(
                      'users/${Hive.box('myBox').get('user').uid}',
                      File(_image!.path),
                    )
                        .then((value) {
                      imageUrl = value;
                      setState(() {});
                    });
                  }

                  // update user
                  await FirebaseFirestoreService().updateDocumentWithQuery(
                    collection: 'users',
                    field: 'uid',
                    value: Hive.box('myBox').get('user').uid,
                    data: {
                      'displayName': _nameController.text.trim(),
                      'email': _emailController.text.trim(),
                      'phoneNumber': _phoneController.text.trim(),
                      'photoUrl': imageUrl,
                    },
                  );

                  // update hive
                  User user = (Hive.box('myBox').get('user') as User).copyWith(
                    displayName: _nameController.text.trim(),
                    email: _emailController.text.trim(),
                    phoneNumber: _phoneController.text.trim(),
                    photoURL: imageUrl,
                  );

                  await Hive.box('myBox').put(
                    'user',
                    user,
                  );

                  // hide loading
                  if (mounted) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }

                  setState(() {
                    ignoring = false;
                  });
                }
              } catch (e, s) {
                debugPrintStack(label: e.toString(), stackTrace: s);

                // hide loading
                if (mounted) {
                  Navigator.pop(context);
                }

                setState(() {
                  ignoring = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                  ),
                );
              }
            },
            text: 'Save',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // image
                  GestureDetector(
                    onTap: () {
                      // show dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Select Image'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    // open camera
                                    _image = await ImagePicker().pickImage(
                                      source: ImageSource.camera,
                                      imageQuality: 30,
                                    );
                                    setState(() {});
                                  },
                                  leading: const Icon(Icons.camera),
                                  title: const Text('Camera'),
                                ),
                                ListTile(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    // open gallery
                                    _image = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 30,
                                    );
                                    setState(() {});
                                  },
                                  leading: const Icon(Icons.photo),
                                  title: const Text('Gallery'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: (_image != null)
                            ? FileImage(
                                File(_image!.path),
                              ) as ImageProvider<Object>?
                            : (imageUrl != null && imageUrl!.isNotEmpty)
                                ? CachedNetworkImageProvider(imageUrl!)
                                : null,
                      ),
                    ),
                  ),
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
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
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      } else if (!isValidEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
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
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your phone number',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
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
