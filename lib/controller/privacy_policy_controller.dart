import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mss_e_learning/model/privacy_policy.dart';
import 'package:mss_e_learning/service/privacy_policy_service.dart';

import '../model/error_data.dart';
import '../util/api_call_status.dart';
import '../util/error_util.dart';

class PrivacyPolicyControl extends GetxController {
  final errorData = ErrorData(title: "", body: "", image: "").obs;
  final status = ApiCallStatus.holding.obs;

  final PrivacyPolicyService _privacyPolicyService = PrivacyPolicyService();

  Rx<PrivacyPolicy> privacyPolicy = PrivacyPolicy().obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    print('CALLEDDDD');
    status.value = ApiCallStatus.loading;
    try {

      final PrivacyPolicy? fetchedPrivacyPolicy = await _privacyPolicyService.getPrivacyPolicy();

      privacyPolicy.value = fetchedPrivacyPolicy!;

      status.value = ApiCallStatus.success;

    } on Exception catch (fetchError) {

      status.value = ApiCallStatus.error;
      errorData.value = ErrorUtil.getErrorData(fetchError.toString());

    }
  }

}