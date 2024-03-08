import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mss_e_learning/controller/user_controller.dart';
import 'package:mss_e_learning/layout/profile/route_list.dart';
import 'package:mss_e_learning/layout/profile/user_screen_footer.dart';
import 'package:mss_e_learning/layout/profile/user_screen_header.dart';
import 'package:mss_e_learning/model/footer_data.dart';
import 'package:mss_e_learning/model/user.dart';
import 'package:mss_e_learning/screen/auth/log_in.dart';
import 'package:mss_e_learning/service/authorization_service.dart';
import 'package:mss_e_learning/widget/button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User user = UserController.user.value??User(firstname: ' ', lastname: ' ', email: '', id: -1);
    FooterData footerData = FooterData(
        copyWriteText: "MSS @ 2024",
        faceBookLink: "https://www.linkedin.com/",
        instagramLink: "https://www.linkedin.com/",
        telegramLink: "https://www.linkedin.com/",
        tiktokLink: "https://www.linkedin.com/",
        twitterLink: "https://www.linkedin.com/",
        linkedInLink: "https://www.linkedin.com/");
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: FlutterFlowTheme.of(context).primary));
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView(children: [
            const SizedBox(
              height: 10,
            ),
            UserScreenHeader(
              user: user,
            ),
            const SizedBox(
              height: 5,
            ),
            const RouteList(),
            const SizedBox(
              height: 5,
            ),
            Button(
              text: 'Logout',
              onPress: () async {
                await AuthService.logout();
                Get.offAll(() => const LogInWidget());
              },
            ),
            const SizedBox(
              height: 5,
            ),
            UserScreenFooter(footerData: footerData)
          ]),
        ),
      ),
    );
  }
}
