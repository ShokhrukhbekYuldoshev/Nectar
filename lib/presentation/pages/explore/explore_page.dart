import 'package:flutter/material.dart';
import 'package:nectar/presentation/widgets/cards/category_card.dart';
import 'package:nectar/presentation/widgets/textfields/search_text_field.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                controller: searchController,
                hintText: "Search products",
              ),
              const SizedBox(height: 20),
              // gridview
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.8,
                children: const [
                  CategoryCard(
                    title: 'Fruits & Vegetables',
                    imageUrl:
                        'https://www.freepnglogos.com/uploads/vegetables-png/buy-high-quality-organic-vegetables-and-fruits-online-7.png',
                  ),
                  CategoryCard(
                    title: 'Cereals & Pulses',
                    imageUrl:
                        'https://www.pngarts.com/files/13/Milk-Cereal-Transparent-Background.png',
                  ),
                  CategoryCard(
                    title: 'Bakery & Snacks',
                    imageUrl:
                        'https://www.pngmart.com/files/17/Fresh-Bakery-PNG-Transparent-Image.png',
                  ),
                  CategoryCard(
                    title: 'Dairy & Eggs',
                    imageUrl:
                        'https://www.pngarts.com/files/1/Dairy-PNG-Transparent-Image.png',
                  ),
                  CategoryCard(
                    title: 'Meat & Fish',
                    imageUrl:
                        'https://www.pngall.com/wp-content/uploads/2016/03/Meat.png',
                  ),
                  CategoryCard(
                    title: 'Beverages',
                    imageUrl:
                        'https://static.wixstatic.com/media/946ce3_0a6d07d9c6e647fd8038678b25a66faa~mv2.png/v1/fill/w_640,h_526,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/946ce3_0a6d07d9c6e647fd8038678b25a66faa~mv2.png',
                  ),
                  CategoryCard(
                    title: 'Personal Care',
                    imageUrl:
                        'https://static.wixstatic.com/media/3e7e03_761f3d9561bb4ec0a5f5ff650dbc4665~mv2.png/v1/fill/w_286,h_286,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/Hair%20Care.png',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
