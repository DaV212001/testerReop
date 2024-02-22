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
    User user = User(
        firstName: "Dagim", lastName: "Mebrate", email: "dagimcodes@gmail.com");
    FooterData footerData = FooterData(
        copyWriteText: "MSS @ 2024",
        faceBookLink: "https://www.linkedin.com/",
        instagramLink: "https://www.linkedin.com/",
        telegramLink: "https://www.linkedin.com/",
        tiktokLink: "https://www.linkedin.com/",
        twitterLink: "https://www.linkedin.com/",
        linkedInLink: "https://www.linkedin.com/");
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(children: [
          UserScreenHeader(
            user: user,
          ),
          const Spacer(),
          const RouteList(),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            height: 50,
            child: Button(
              text: 'Logout',
              onPress: () {},
            ),
          ),
          UserScreenFooter(footerData: footerData)
        ]),
      ),
    );
  }
}
