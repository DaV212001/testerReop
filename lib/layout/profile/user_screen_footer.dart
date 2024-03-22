import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mss_e_learning/generated/assets.dart';
import 'package:mss_e_learning/model/footer_data.dart';
import 'package:mss_e_learning/widget/svg_icon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/app_constants.dart';

class UserScreenFooter extends StatelessWidget {
  final FooterData footerData;

  const UserScreenFooter({super.key, required this.footerData});

  @override
  Widget build(BuildContext context) {
    Color color = AppConstants.primary.withOpacity(0.85);
    return Column(
      children: [
        Text(footerData.copyWriteText,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            socialMediaButton(
                color, footerData.faceBookLink, Assets.socialFacebook),
            socialMediaButton(
                color, footerData.youtubeLink, Assets.socialYoutube),
            socialMediaButton(
                color, footerData.instagramLink, Assets.socialInstagram),
            socialMediaButton(
                color, footerData.linkedInLink, Assets.socialLinkedin),
            socialMediaButton(
                color, footerData.twitterLink, Assets.socialTwitter),
            socialMediaButton(
                color, footerData.telegramLink, Assets.socialTelegram),
            socialMediaButton(
                color, footerData.tiktokLink, Assets.socialTiktok),
          ],
        )
      ],
    );
  }

  Widget socialMediaButton(Color color, String? link, String image) {
    if (link == null || link == "") return const SizedBox.shrink();
    return Ink(
      child: InkWell(
        onTap: () {
          _launchUrl(link);
        },
        child: SvgIcon(
          color: color,
          image: image,
          size: 55,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      const SnackBar(
          content: Text(
        'open_link_failed',
        style: TextStyle(fontSize: 15),
      ));
    }
  }
}
