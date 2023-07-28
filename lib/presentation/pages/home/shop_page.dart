import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nectar/bloc/shop/shop_bloc.dart';
import 'package:nectar/data/models/address.dart';
import 'package:nectar/data/models/store.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/assets.dart';
import 'package:nectar/presentation/widgets/cards/product_card.dart';
import 'package:nectar/presentation/widgets/textfields/search_text_field.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({
    super.key,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController searchController = TextEditingController();
  final CarouselController carouselController = CarouselController();

  int activeBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ShopBloc>().add(FetchShopScreenData());
  }

  @override
  Widget build(BuildContext context) {
    Address address = Hive.box('myBox').get('user').address as Address;

    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ShopLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ShopLoaded) {
          return _buildLoaded(state, address);
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );
        }
      },
    );
  }

  Widget _buildBanner({
    required BuildContext context,
    required String imageUrl,
    required String title,
    required String secondaryText,
  }) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement banner tap logic
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Positioned(
            // center right
            right: 0,
            top: 35,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  secondaryText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoaded(ShopLoaded state, Address address) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            bottom: 25,
          ),
          child: Column(
            children: [
              // logo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child:
                    SvgPicture.asset(SvgAssets.carrot, height: 40, width: 40),
              ),
              const SizedBox(height: 10),
              // location
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SvgAssets.location),
                    const SizedBox(width: 5),
                    Text(
                      '${address.city}, ${address.country}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SearchTextField(
                  onPressed: () {},
                  controller: searchController,
                  hintText: 'Search for products',
                ),
              ),
              const SizedBox(height: 20),
              // banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Stack(
                  children: [
                    CarouselSlider(
                      carouselController: carouselController,
                      items: [
                        _buildBanner(
                          context: context,
                          imageUrl:
                              'https://e1.pxfuel.com/desktop-wallpaper/103/525/desktop-wallpaper-fruit-and-vegetable-backgrounds-fruits-and-vegetables.jpg',
                          title: 'Summer Sale',
                          secondaryText: 'Up to 50% off',
                        ),
                        _buildBanner(
                          context: context,
                          imageUrl:
                              'https://e1.pxfuel.com/desktop-wallpaper/436/448/desktop-wallpaper-fruits-and-vegetables-vegetable.jpg',
                          title: 'New Arrivals',
                          secondaryText: 'Shop now',
                        ),
                        _buildBanner(
                          context: context,
                          imageUrl:
                              'https://e0.pxfuel.com/wallpapers/648/385/desktop-wallpaper-organic-vegetables-for-cooking-spices-herbs-and-fresh-vegetables-for-cooking-on-dark-metal-background-with-sp-vegetables-fresh-vegetables-organic-vegetables-organic-food.jpg',
                          title: 'Limited Time Offer',
                          secondaryText: 'Don\'t miss out',
                        ),
                      ],
                      options: CarouselOptions(
                        height: 115,
                        enableInfiniteScroll: true,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeBannerIndex = index;
                          });
                        },
                      ),
                    ), // expanding dots
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: AnimatedSmoothIndicator(
                          onDotClicked: (index) {
                            carouselController.animateToPage(index);
                          },
                          activeIndex: activeBannerIndex,
                          count: 3,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 5,
                            dotWidth: 8,
                            dotColor: Colors.grey,
                            activeDotColor: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // exclusive offer
              if (state.exclusiveProducts.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Exclusive Offer',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.exclusiveProducts.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          ProductCard(
                            product: state.exclusiveProducts[index],
                          ),
                          // if not last item
                          if (index != state.exclusiveProducts.length - 1)
                            const SizedBox(width: 20),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
              // best selling
              if (state.bestSellingProducts.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Best Selling',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    itemCount: state.bestSellingProducts.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          ProductCard(
                            product: state.bestSellingProducts[index],
                          ),
                          // if not last item
                          if (index != state.bestSellingProducts.length - 1)
                            const SizedBox(width: 15),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
              // stores
              if (state.stores.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Stores',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // vertical list
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.stores.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        StoreCard(
                          store: state.stores[index],
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // background color can be random from
    const List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.cyan,
      Colors.amber,
      Colors.lime,
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.deepPurple,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
    ];

    final Color randomColor = colors[Random().nextInt(colors.length)];

    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: randomColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          // image or icon
          if (store.image != null)
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  image: AssetImage(store.image!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: randomColor,
              ),
              child: const Center(
                child: Icon(
                  Icons.store,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          const SizedBox(width: 15),
          Text(
            store.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
