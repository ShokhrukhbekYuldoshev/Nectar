import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/presentation/utils/assets.dart';
import 'package:nectar/presentation/widgets/cards/product_card.dart';
import 'package:nectar/presentation/widgets/textfields/search_text_field.dart';

class ProductsPage extends StatefulWidget {
  final String title;
  const ProductsPage({super.key, required this.title});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController searchController = TextEditingController();
  final List<String> _selectedCategories = [];
  final List<String> _selectedBrands = [];

  final _categories = [
    'Fruits & Vegetables',
    'Cereals & Pulses',
    'Dairy & Bakery',
    'Snacks & Beverages',
    'Personal Care',
    'Home Care',
    'Noodles & Sauces',
    'Pet Care',
    'Meat & Seafood',
    'Baby Care',
    'Others',
  ];

  final _brands = [
    'Head & Shoulders',
    'Horlicks',
    'Kellogg\'s',
    'Kissan',
    'Lakme',
    'Lay\'s',
    'L\'Oreal',
    'Maggi',
    'Nestle',
    'Nivea',
    'Nutella',
    'Pepsi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        // filter icon
        // filter icon
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                builder: (BuildContext context) {
                  return _buildFilterBottomSheet(context);
                },
              );
            },
            icon: SvgPicture.asset(SvgAssets.filter),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),
          child: Column(
            children: [
              SearchTextField(
                onPressed: () {},
                controller: searchController,
                hintText: "Search products",
              ),
              const SizedBox(height: 20),
              // gridview
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBottomSheet(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.only(
          right: 25,
          left: 25,
          bottom: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = _categories[index];
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(category),
                    value: _selectedCategories.contains(category),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedCategories.add(category);
                        } else {
                          _selectedCategories.remove(category);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Brand',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _brands.length,
                itemBuilder: (BuildContext context, int index) {
                  final brand = _brands[index];
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(brand),
                    value: _selectedBrands.contains(brand),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedBrands.add(brand);
                        } else {
                          _selectedBrands.remove(brand);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategories.clear();
                        _selectedBrands.clear();
                      });
                    },
                    child: const Text('Clear'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
