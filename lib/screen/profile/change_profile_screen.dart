import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mss_e_learning/controller/change_password_controller.dart';
import 'package:mss_e_learning/layout/password/header_image_and_text.dart';
import 'package:mss_e_learning/util/app_constants.dart';
import 'package:mss_e_learning/widget/input_field.dart';
import '../../controller/change_profile_controllers.dart';

class ChangeProfileScreen extends StatefulWidget {


  const ChangeProfileScreen({super.key});

  @override
  _ChangeProfileScreenState createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
final TextEditingController firstController = TextEditingController(text: ChangeProfileController().firstname.value);
final TextEditingController lastController = TextEditingController(text: ChangeProfileController().lastname.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GetBuilder<ChangeProfileController>(
        init: ChangeProfileController(),
        builder: (controller) {
          return Form(
            child: Container(
              height: double.infinity,
              decoration: AppConstants.kAuthContainerGradient,
              alignment: const AlignmentDirectional(0, -1),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const HeaderImageAndText(
                          imagePath:
                          'assets/images/illustrations/change_profile.svg',
                          headerText: 'Change Profile'),
                      const SizedBox(
                        height: 10,
                      ),
                      buildBody(context).animateOnPageLoad(
                          ChangeProfileController()
                              .animationsMap['textOnPageLoadAnimation']!),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  bool loading = false;
ChangeProfileController controller = Get.put(ChangeProfileController());
  Container buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 570,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter new first and last names you want shown on your profile.',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ).animateOnPageLoad(ChangeProfileController()
                      .animationsMap['containerOnPageLoadAnimation1']!),
                  buildForm(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: FlutterFlowTheme.of(context).primary),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await ChangeProfileController().updateUser(controller.firstname.value, controller.lastname.value);
                      setState(() {
                        loading = false;
                      });
                    },
                    child: loading ? const CircularProgressIndicator(color: Colors.white,) : const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ])),
      ),
    );
  }

  Column buildForm() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: InputFieldWidget(
                textEditingController: firstController,
                focusNode: null,
                obscureText: false,
                onChanged: (val) {
                  print('CALLED');
                  controller.firstname.value = val!;
                  return null;
                },
                validator: (val) {
                  if (val!.length < 2) {
                    return 'First name must be at least 2 characters.';
                  }
                  return null;
                },
                passwordinput: false,
                label: "First name")),
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: InputFieldWidget(
                textEditingController: lastController,
                focusNode: null,
                obscureText: false,
                onChanged: (val) {
                  controller.lastname.value = val!;
                  return null;
                },
                validator: (val) {
                  if (val!.length < 2) {
                    return 'Last name must be at least 2 characters.';
                  }
                  return null;
                },
                passwordinput: false,
                label: "Last name")),
      ],
    );
  }
}
