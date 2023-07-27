import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/bloc/account/account_bloc.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/app_router.dart';
import 'package:nectar/presentation/utils/assets.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountLoading) {
          // show loading dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else if (state is AccountLogoutFailure) {
          // close loading dialog
          Navigator.of(context).pop();
          // show error dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      // close dialog
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        } else if (state is AccountLogoutSuccess) {
          // close loading dialog
          Navigator.of(context).pop();
          // navigate to login page
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.loginRoute,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 35,
              bottom: 25,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 25),
                    // image
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Image.network(
                                'https://gweb-research-imagen.web.app/compositional/An%20oil%20painting%20of%20a%20British%20Shorthair%20cat%20wearing%20a%20cowboy%20hat%20and%20red%20shirt%20skateboarding%20on%20a%20beach./1_.jpeg',
                              ),
                            );
                          },
                        );
                      },
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://gweb-research-imagen.web.app/compositional/An%20oil%20painting%20of%20a%20British%20Shorthair%20cat%20wearing%20a%20cowboy%20hat%20and%20red%20shirt%20skateboarding%20on%20a%20beach./1_.jpeg',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // name
                          Text(
                            'John Doe',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // email
                          Text(
                            'johndoe@example.com',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // list of orders
                const Divider(height: 1),
                ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  leading: SvgPicture.asset(
                    SvgAssets.orders,
                  ),
                  title: const Text('Orders'),
                  onTap: () {
                    // navigate to orders page
                    Navigator.of(context).pushNamed(AppRouter.ordersRoute);
                  },
                ),
                const Divider(height: 1),
                // my details
                ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  leading: SvgPicture.asset(
                    SvgAssets.myDetails,
                  ),
                  title: const Text('My Details'),
                  onTap: () {
                    // navigate to details page
                    Navigator.of(context).pushNamed(AppRouter.myDetailsRoute);
                  },
                ),
                const Divider(height: 1),
                // delivery address
                ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  leading: SvgPicture.asset(
                    SvgAssets.deliveryAddress,
                  ),
                  title: const Text('Delivery Address'),
                  onTap: () {
                    // navigate to address page
                    Navigator.of(context)
                        .pushNamed(AppRouter.deliveryAddressRoute);
                  },
                ),
                const Divider(height: 1),
                // payment methods
                ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  leading: SvgPicture.asset(
                    SvgAssets.payment,
                  ),
                  title: const Text('Payment Methods'),
                  onTap: () {
                    // navigate to payment methods page
                    Navigator.of(context)
                        .pushNamed(AppRouter.paymentMethodsRoute);
                  },
                ),
                const Divider(height: 1),
                // promo codes
                ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  leading: SvgPicture.asset(
                    SvgAssets.promoCode,
                  ),
                  title: const Text('Promo Codes'),
                  onTap: () {
                    // navigate to promo codes page
                    Navigator.of(context).pushNamed(AppRouter.promoCodesRoute);
                  },
                ),
                const Divider(height: 1),
                // notifications
                ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  leading: SvgPicture.asset(
                    SvgAssets.notification,
                  ),
                  title: const Text('Notifications'),
                  onTap: () {
                    // navigate to notifications page
                    Navigator.of(context)
                        .pushNamed(AppRouter.notificationsRoute);
                  },
                ),
                const Divider(height: 1),
                // help
                ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  leading: SvgPicture.asset(
                    SvgAssets.help,
                  ),
                  title: const Text('Help'),
                  onTap: () {
                    // navigate to help page
                    Navigator.of(context).pushNamed(AppRouter.helpRoute);
                  },
                ),
                const Divider(height: 1),
                // about
                ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  leading: SvgPicture.asset(
                    SvgAssets.about,
                  ),
                  title: const Text('About'),
                  onTap: () {
                    // navigate to about page
                    Navigator.of(context).pushNamed(AppRouter.aboutRoute);
                  },
                ),
                const Divider(height: 1),
                const SizedBox(height: 50),
                // logout
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: const LogoutButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grayishLimeGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // show logout dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      // close dialog
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<AccountBloc>(context).add(
                        AccountLogout(),
                      );
                    },
                    child: const Text('Logout'),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: AppColors.primary,
              ),
              Expanded(
                child: Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
