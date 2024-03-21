import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mss_e_learning/widget/cached_image.dart';
import '../../controller/user_controller.dart';
import '../../screen/search/search_screen.dart';
class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            color: Color(0x17202529),
            offset: Offset(0, 1),
          )
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Hello, ',
                        style: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .override(
                            fontFamily: 'Poppins',
                            color:
                            FlutterFlowTheme.of(context).primaryText)),
                    Text('${UserController.user.value!.firstname}',
                        style: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                UserController.user.value!.profilepicture == null ? Icon(
                  Icons.person_2_outlined,
                  color: FlutterFlowTheme.of(context).primary,
                  size: MediaQuery.of(context).size.width * 0.1,
                ):
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.12),
                        child: CachedImage(
                          url:
                          '${UserController.user.value!.profilepicture}', fit: BoxFit.fill,
                        )
                      )
                    )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8,bottom: 8),
              child: Hero(
                  tag: 'Search',
                  child: GestureDetector(
                      onTap: () {
                        Get.to(() =>  SearchScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                            FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 2
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search for courses',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(FontAwesomeIcons.magnifyingGlass),
                                )
                              ]),
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
