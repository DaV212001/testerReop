import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mss_e_learning/generated/assets.dart';
import 'package:mss_e_learning/model/footer_data.dart';
import 'package:mss_e_learning/widget/svg_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreenFooter extends StatelessWidget {
  final FooterData footerData;

  const UserScreenFooter({super.key, required this.footerData});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      children: [
        Text(footerData.copyWriteText,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 15.sp)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (footerData.faceBookLink != "")
              socialMediaButton(
                  color, footerData.faceBookLink, Assets.socialFacebook),
            if (footerData.youtubeLink != "")
              socialMediaButton(
                  color, footerData.youtubeLink, Assets.socialYoutube),
            if (footerData.instagramLink != "")
              socialMediaButton(
                  color, footerData.instagramLink, Assets.socialInstagram),
            if (footerData.linkedInLink != "")
              socialMediaButton(
                  color, footerData.linkedInLink, Assets.socialLinkedin),
            if (footerData.twitterLink != "")
              socialMediaButton(
                  color, footerData.twitterLink, Assets.socialTwitter),
            if (footerData.telegramLink != "")
              socialMediaButton(
                  color, footerData.telegramLink, Assets.socialTelegram),
            if (footerData.tiktokLink != "")
              socialMediaButton(
                  color, footerData.tiktokLink, Assets.socialTiktok),
          ],
        )
      ],
    );
  }

  Widget socialMediaButton(Color color, String? link, String image) {
    if (link == null) return const SizedBox.shrink();
    return Ink(
      child: InkWell(
        onTap: () {
          _launchUrl(link);
        },
        child: SvgIcon(
          color: color,
          image: image,
          size: 50,
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
