import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nectar/bloc/explore/explore_bloc.dart';
import 'package:nectar/data/models/category.dart';
import 'package:nectar/presentation/widgets/cards/category_card.dart';
import 'package:nectar/presentation/widgets/textfields/search_text_field.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController searchController = TextEditingController();
  final List<Category> categories = [];

  List filteredCategories = [];

  @override
  void initState() {
    super.initState();
    context.read<ExploreBloc>().add(FetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExploreBloc, ExploreState>(
      listener: (context, state) {
        if (state is ExploreLoaded) {
          categories.clear();
          categories.addAll(state.categories);
          filteredCategories.addAll(state.categories);
        }
      },
      child: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          if (state is ExploreLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ExploreError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                'Explore',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
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
                          filteredCategories = categories
                              .where((category) => category.name
                                  .toLowerCase()
                                  .contains(searchController.text.trim()))
                              .toList();
                        });
                      },
                      controller: searchController,
                      hintText: "Search categories",
                    ),
                    const SizedBox(height: 20),
                    // gridview
                    GridView.builder(
                      itemCount: filteredCategories.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          category: filteredCategories[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
