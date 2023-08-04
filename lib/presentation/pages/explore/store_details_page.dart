import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/bloc/store_details/store_details_bloc.dart';
import 'package:nectar/data/models/store.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/assets.dart';
import 'package:nectar/presentation/utils/extensions.dart';
import 'package:nectar/presentation/utils/helpers.dart';
import 'package:nectar/presentation/widgets/cards/product_card.dart';

class StoreDetailsPage extends StatefulWidget {
  final Store store;

  const StoreDetailsPage({super.key, required this.store});

  @override
  State<StoreDetailsPage> createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  @override
  void initState() {
    super.initState();
    // fetches store products and reviews
    context.read<StoreDetailsBloc>().add(
          FetchStoreDetailsEvent(widget.store.id!),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
          builder: (context, state) {
            if (state is StoreDetailsLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is StoreDetailsLoaded) {
              return Column(
                children: [
                  StoreDetailsHeader(
                    store: widget.store,
                  ),
                  StoreDetailsBody(
                    store: widget.store,
                    products: state.products,
                    reviews: state.reviews,
                  ),
                ],
              );
            } else if (state is StoreDetailsError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}

class StoreDetailsHeader extends StatelessWidget {
  final Store store;

  const StoreDetailsHeader({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        store.image == null || store.image!.isEmpty
            ? Container(
                height: 400,
                decoration: BoxDecoration(
                  color: generateRandomColor().darken(),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.store,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(store.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        Positioned(
          top: 40,
          left: 20,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          top: 40,
          right: 20,
          child: IconButton(
            onPressed: () {
              // TODO: Implement share functionality
            },
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class StoreDetailsBody extends StatelessWidget {
  final Store store;
  final List products;
  final List reviews;

  const StoreDetailsBody({
    super.key,
    required this.store,
    required this.products,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // name
                Text(
                  store.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // location
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    SvgAssets.location,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // description
          if (store.description != null && store.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                store.description!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (products.isEmpty)
            const Center(
              child: Text('No products found'),
            ),
          if (products.isNotEmpty)
            SizedBox(
              height: 250,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Row(
                    children: [
                      ProductCard(product: product),
                      if (index != products.length - 1)
                        const SizedBox(width: 20),
                    ],
                  );
                },
              ),
            ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Reviews',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (reviews.isEmpty)
            const Center(
              child: Text('No reviews found'),
            ),
          if (reviews.isNotEmpty)
            SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                scrollDirection: Axis.horizontal,
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 20),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.message,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.yellow),
                              const SizedBox(width: 10),
                              Text(
                                review.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
