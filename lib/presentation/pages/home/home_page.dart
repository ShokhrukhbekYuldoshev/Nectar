import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/presentation/pages/explore/explore_page.dart';
import 'package:nectar/presentation/pages/account/account_page.dart';
import 'package:nectar/presentation/pages/home/favorites_page.dart';
import 'package:nectar/presentation/pages/home/shop_page.dart';
import 'package:nectar/presentation/pages/order/cart_page.dart';
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
            NavigationDestination(
              icon: SvgPicture.asset(
                SvgAssets.cart,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(SvgAssets.cart),
              label: 'Cart',
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
              label: 'Favorite',
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
