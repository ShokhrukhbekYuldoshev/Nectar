import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/bloc/product/product_bloc.dart';
import 'package:nectar/data/repositories/product_repository.dart';
import 'package:nectar/presentation/pages/explore/explore_page.dart';
import 'package:nectar/presentation/pages/account/account_page.dart';
import 'package:nectar/presentation/pages/home/favorites_page.dart';
import 'package:nectar/presentation/pages/home/shop_page.dart';
import 'package:nectar/presentation/pages/order/cart_page.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x7FE6EAF3),
              blurRadius: 37,
              offset: Offset(0, -12),
              spreadRadius: 0,
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(
                SvgAssets.shop,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(SvgAssets.shop),
              label: 'Shop',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                SvgAssets.explore,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(SvgAssets.explore),
              label: 'Explore',
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return NavigationDestination(
                  icon: Badge(
                    backgroundColor: AppColors.primary,
                    isLabelVisible: ProductRepository.cart.isNotEmpty,
                    label: Text(
                      ProductRepository.cart.length.toString(),
                    ),
                    offset: const Offset(10, -10),
                    child: SvgPicture.asset(
                      SvgAssets.cart,
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  selectedIcon: Badge(
                    backgroundColor: AppColors.primary,
                    isLabelVisible: ProductRepository.cart.isNotEmpty,
                    label: Text(
                      ProductRepository.cart.length.toString(),
                    ),
                    offset: const Offset(10, -10),
                    child: SvgPicture.asset(SvgAssets.cart),
                  ),
                  label: 'Cart',
                );
              },
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                SvgAssets.favorite,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(SvgAssets.favorite),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                SvgAssets.user,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(SvgAssets.user),
              label: 'Account',
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          ShopPage(),
          ExplorePage(),
          CartPage(),
          FavoritesPage(),
          AccountPage(),
        ],
      ),
    );
  }
}
