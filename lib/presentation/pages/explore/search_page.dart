import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:nectar/bloc/search/search_bloc.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/presentation/widgets/cards/product_card.dart';

class SearchPage extends StatefulWidget {
  final String query;
  const SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query);
    context.read<SearchBloc>().add(SearchProducts(query: widget.query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search products',
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                context
                    .read<SearchBloc>()
                    .add(SearchProducts(query: _searchController.text));
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
          ),
          onSubmitted: (query) {
            context.read<SearchBloc>().add(SearchProducts(query: query));
          },
        ),
      ),
      // ? note: search query should exactly match the product name, otherwise no results will be shown. This is because we are using Firestore's where() method to query the products collection. If you want to learn more about Firestore's querying capabilities, check out the documentation here: https://firebase.google.com/docs/firestore/query-data/queries
      bottomNavigationBar: BottomAppBar(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text:
                  'Note: search query should exactly match the product name, otherwise no results will be shown. This is because we are using Firestore\'s ',
              style: const TextStyle(
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'where()',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      const url =
                          'https://firebase.google.com/docs/firestore/query-data/queries';
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                ),
                const TextSpan(
                  text:
                      ' method to query the products collection. If you want to learn more about Firestore\'s querying capabilities, check out the documentation here: ',
                ),
                TextSpan(
                  text:
                      'https://firebase.google.com/docs/firestore/query-data/queries',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      const url =
                          'https://firebase.google.com/docs/firestore/query-data/queries';
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is SearchLoaded) {
            final List<Product> products = state.products;
            if (products.isEmpty) {
              return const Center(
                child: Text('No products found'),
              );
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
