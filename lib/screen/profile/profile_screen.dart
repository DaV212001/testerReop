import 'package:flutter/material.dart';
import 'package:mss_e_learning/layout/profile/route_list.dart';
import 'package:mss_e_learning/layout/profile/user_screen_footer.dart';
import 'package:mss_e_learning/layout/profile/user_screen_header.dart';
import 'package:mss_e_learning/model/footer_data.dart';
import 'package:mss_e_learning/model/user.dart';
import 'package:mss_e_learning/widget/button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
            children: [],
          )),
    );
  }

  Widget buildUserScreen(User user, FooterData footerData) {
    return Center(
        child: ListView(scrollDirection: Axis.vertical,
            children: [
              UserScreenHeader(
                user: user,
              ),
              RouteList(
                user: user,
                refresh: () {},
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                height: 50,
                child: Button(
                  text: 'Logout',
                  onPress: () {},
                ),
              ),
              UserScreenFooter(footerData: footerData)
            ]));
  }
}
