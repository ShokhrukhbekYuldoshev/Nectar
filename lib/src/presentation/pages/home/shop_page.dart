import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:nectar/src/bloc/shop/shop_bloc.dart';
import 'package:nectar/src/data/models/address.dart';
import 'package:nectar/src/presentation/utils/app_colors.dart';
import 'package:nectar/src/presentation/utils/app_router.dart';
import 'package:nectar/src/presentation/utils/assets.dart';
import 'package:nectar/src/presentation/widgets/cards/product_card.dart';
import 'package:nectar/src/presentation/widgets/cards/store_card.dart';
import 'package:nectar/src/presentation/widgets/textfields/search_text_field.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({
    super.key,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController searchController = TextEditingController();

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

  Widget _buildLoaded(ShopLoaded state, Address address) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            SvgPicture.asset(SvgAssets.carrot, height: 40, width: 40),
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
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SearchTextField(
                  onSubmitted: () {
                    if (searchController.text.isNotEmpty) {
                      Navigator.of(context).pushNamed(
                        AppRouter.searchRoute,
                        arguments: searchController.text,
                      );
                    }
                  },
                  controller: searchController,
                  hintText: 'Search for products',
                ),
              ),
              const SizedBox(height: 20),
              // banner
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CarouselWithIndicator(),
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
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AppRouter.storesRoute,
                          );
                        },
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

class CarouselItem extends StatelessWidget {
  final BuildContext context;
  final String imageUrl;
  final String title;
  final String secondaryText;

  const CarouselItem({
    super.key,
    required this.context,
    required this.imageUrl,
    required this.title,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
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
              errorWidget: (context, url, error) => Center(
                child: Container(
                  color: Colors.red,
                  width: double.infinity,
                  height: double.infinity,
                  child: const Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
              ),
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
}

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({super.key});

  @override
  State<CarouselWithIndicator> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  final CarouselController carouselController = CarouselController();
  int activeBannerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          items: [
            CarouselItem(
              context: context,
              imageUrl:
                  'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              title: 'Summer Sale',
              secondaryText: 'Up to 50% off',
            ),
            CarouselItem(
              context: context,
              imageUrl:
                  'https://images.unsplash.com/photo-1499244571948-7ccddb3583f1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHNhbGUlMjBuZXd8ZW58MHx8MHx8fDA%3D',
              title: 'New Arrivals',
              secondaryText: 'Shop now',
            ),
            CarouselItem(
              context: context,
              imageUrl:
                  'https://images.unsplash.com/photo-1472289065668-ce650ac443d2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHNhbGUlMjBuZXd8ZW58MHx8MHx8fDA%3D',
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
        ),
        // expanding dots
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
    );
  }
}
