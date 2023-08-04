import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:nectar/bloc/shop/shop_bloc.dart';
import 'package:nectar/data/models/address.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/app_router.dart';
import 'package:nectar/presentation/utils/assets.dart';
import 'package:nectar/presentation/widgets/cards/product_card.dart';
import 'package:nectar/presentation/widgets/cards/store_card.dart';
import 'package:nectar/presentation/widgets/textfields/search_text_field.dart';

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
                  'https://e1.pxfuel.com/desktop-wallpaper/103/525/desktop-wallpaper-fruit-and-vegetable-backgrounds-fruits-and-vegetables.jpg',
              title: 'Summer Sale',
              secondaryText: 'Up to 50% off',
            ),
            CarouselItem(
              context: context,
              imageUrl:
                  'https://e1.pxfuel.com/desktop-wallpaper/436/448/desktop-wallpaper-fruits-and-vegetables-vegetable.jpg',
              title: 'New Arrivals',
              secondaryText: 'Shop now',
            ),
            CarouselItem(
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
