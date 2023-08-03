import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/bloc/category_products/category_products_bloc.dart';
import 'package:nectar/data/models/category.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/presentation/utils/assets.dart';
import 'package:nectar/presentation/widgets/cards/product_card.dart';
import 'package:nectar/presentation/widgets/textfields/search_text_field.dart';

class CategoryProductsPage extends StatefulWidget {
  final Category category;
  const CategoryProductsPage({super.key, required this.category});

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final List<Product> _products = [];
  final TextEditingController _searchController = TextEditingController();
  final List<String> _brands = [];
  final List<String> _selectedBrands = [];

  final List<Product> _filteredProducts = [];

  void updateFilteredProducts() {
    _filteredProducts.clear();
    _filteredProducts.addAll(_products.where((product) {
      if (_selectedBrands.isEmpty) {
        return true;
      }
      return _selectedBrands.contains(product.brand);
    }));
    if (_searchController.text.isNotEmpty) {
      _filteredProducts.retainWhere((product) {
        return product.name
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoryProductsBloc>().add(
          FetchCategoryProducts(
            categoryId: widget.category.id!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (BuildContext context) {
                  return _buildFilterBottomSheet(context);
                },
              ).then(
                (value) => setState(
                  () {
                    updateFilteredProducts();
                  },
                ),
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
                onChanged: () {
                  setState(() {
                    updateFilteredProducts();
                  });
                },
                controller: _searchController,
                hintText: "Search products",
              ),
              const SizedBox(height: 20),
              // gridview
              BlocBuilder<CategoryProductsBloc, CategoryProductsState>(
                builder: (context, state) {
                  if (state is CategoryProductsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CategoryProductsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  if (state is CategoryProductsLoaded) {
                    _products.clear();
                    _products.addAll(state.products);

                    updateFilteredProducts();

                    _brands.clear();
                    for (final product in _products) {
                      if (product.brand == null) {
                        continue;
                      }
                      if (_brands.contains(product.brand)) {
                        continue;
                      }
                      _brands.add(product.brand!);
                    }
                  }
                  if (_products.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: const Center(
                        child: Text('No products found'),
                      ),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        product: _filteredProducts[index],
                      );
                    },
                  );
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
        padding: const EdgeInsets.only(
          right: 25,
          left: 25,
          bottom: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
