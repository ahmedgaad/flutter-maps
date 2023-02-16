// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps/core/utils/color_manager.dart';
import 'package:maps/core/utils/components_manager.dart';
import 'package:maps/core/utils/routes_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../phone_auth/presentation/cubit/phone_auth_cubit.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  Widget buildDrawerListItems({
    required IconData leadingIcon,
    required String title,
    Widget? trailing,
    Function()? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? ColorManager.blue,
      ),
      title: Text(title),
      trailing: trailing ??
          const Icon(
            Icons.arrow_right,
            color: ColorManager.blue,
          ),
      onTap: onTap,
    );
  }

  Widget buildIconItem({
    required IconData icon,
    required String url,
  }) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: Icon(
        icon,
        color: ColorManager.blue,
        size: 35.0,
      ),
    );
  }

  Widget buildSocialMediaIcon() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildIconItem(
            icon: FontAwesomeIcons.instagram,
            url: 'https://www.instagram.com/ahmed_gad_116/',
          ),
          const SizedBox(
            width: 15.0,
          ),
          buildIconItem(
            icon: FontAwesomeIcons.telegram,
            url: 'https://t.me/ahmedmohamedgad',
          ),
          const SizedBox(
            width: 15.0,
          ),
          buildIconItem(
            icon: FontAwesomeIcons.whatsapp,
            url: 'https://wa.me/qr/N7X4UC7I7RPAE1',
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Future<void> _launchUrl(String url) async {
    await canLaunch(url)
        ? await launch(url)
        : throw "Couldn't launch$url";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 250,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('----- Clickable image');
                    },
                    child:  CircleAvatar(
                      backgroundImage: const NetworkImage(
                          'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
                      radius: 52,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.add_a_photo,
                            size: 19,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Ahmed Gad',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    '0106 129 3297',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
          ),
          buildDrawerListItems(
            leadingIcon: Icons.person,
            title: 'Profile',
          ),
          divider(),
          buildDrawerListItems(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {},
          ),
          divider(),
          buildDrawerListItems(
            leadingIcon: Icons.settings,
            title: 'Settings',
          ),
          divider(),
          buildDrawerListItems(
            leadingIcon: Icons.help,
            title: 'Help',
          ),
          divider(),
          BlocProvider<PhoneAuthCubit>(
            create: (context) => phoneAuthCubit,
            child: buildDrawerListItems(
              leadingIcon: Icons.logout,
              title: 'Logout',
              onTap: () async {
                await phoneAuthCubit.signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context)
                    .pushReplacementNamed(Routes.phoneAuthRoute);
              },
              color: Colors.red,
              trailing: const SizedBox(),
            ),
          ),
          const SizedBox(
            height: 230,
          ),
          ListTile(
            leading: Text(
              'Follow Us',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          buildSocialMediaIcon(),
        ],
      ),
    );
  }
}
