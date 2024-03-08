import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controller/verification_controller.dart';

class HeaderImageAndText extends StatelessWidget {
  final String imagePath;
  final String headerText;
  final bool showbackButton;
  final Color? color;
  final bool? isChangeProfile;
  const HeaderImageAndText({
    super.key, required this.imagePath, required this.headerText, required this.showbackButton, this.color, this.isChangeProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(showbackButton)Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded
                  )
                ),
              )
            ],
          ),
        ),
        if(isChangeProfile == null)Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: SvgPicture.asset(
              imagePath,
              height: MediaQuery.of(context).size.height * 0.2,
            )
        ).animateOnPageLoad(VerificationController().animationsMap['containerOnPageLoadAnimation1']!),
        Text(
          headerText,
          style: FlutterFlowTheme.of(context).displaySmall.override(
            fontFamily: 'Outfit',
            color: color??Colors.white,),
          textAlign: TextAlign.center,
        ).animateOnPageLoad(VerificationController().animationsMap['containerOnPageLoadAnimation1']!),
        SizedBox(height: 10,),
      ],
    );
  }
}
