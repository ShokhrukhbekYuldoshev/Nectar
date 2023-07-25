import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/assets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final carouselController = CarouselController();
  int activeBannerIndex = 0;
  final _images = [
    Image.asset('assets/png/fail.png'),
    Image.asset('assets/png/mask.png'),
    Image.asset('assets/png/onboarding.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // share icon
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(SvgAssets.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  carouselController: carouselController,
                  items: _images,
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeBannerIndex = index;
                      });
                    },
                  ),
                ),
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
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Product Title',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        iconSize: 30,
                        icon: SvgPicture.asset(SvgAssets.favorite),
                      ),
                    ],
                  ),
                  // unit kg, g, ml, l
                  const Text(
                    '1 kg',
                    style: TextStyle(
                      height: 0.5,
                      fontSize: 16,
                      color: AppColors.lightGray,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            iconSize: 30,
                            icon: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              border: Border.all(
                                color: AppColors.lightBorderGray,
                              ),
                            ),
                            child: const Text(
                              '1',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {},
                            iconSize: 30,
                            icon: const Icon(
                              Icons.add,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '\$10.99',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  ExpansionTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    title: const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    expandedAlignment:
                        Alignment.centerLeft, // default is centerRight
                    expandedCrossAxisAlignment:
                        CrossAxisAlignment.start, // default is center
                    children: List.generate(
                      3,
                      (index) => Text('Description $index'),
                    ),
                  ),
                  const Divider(),
                  ExpansionTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    title: const Text(
                      'Nutritions',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    expandedAlignment:
                        Alignment.centerLeft, // default is centerRight
                    expandedCrossAxisAlignment:
                        CrossAxisAlignment.start, // default is center
                    children: List.generate(
                      3,
                      (index) => Text('Nutrition $index'),
                    ),
                  ),
                  const Divider(),
                  ExpansionTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    title: const Text(
                      'Reviews',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    expandedAlignment:
                        Alignment.centerLeft, // default is centerRight
                    expandedCrossAxisAlignment:
                        CrossAxisAlignment.start, // default is center
                    children: List.generate(
                      3,
                      (index) => Text(
                        'Review $index',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
