import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mss_e_learning/controller/user_controller.dart';
import 'package:mss_e_learning/service/ads_service.dart';
import 'package:mss_e_learning/service/authorization_service.dart';
import 'package:mss_e_learning/util/ad_unit_ids.dart';
import '../model/sub_category.dart';
import '../screen/payment/payment_screen.dart';

class AdController extends GetxController {
  final _storage = GetStorage();
  UserController userController = Get.put(UserController());

  RxBool showAds = false.obs;


  @override
  void onInit() {
    super.onInit();
    // Fetch the show ads value from storage on initialization
    if (_storage.hasData('showAds')) {
      showAds.value = _storage.read('showAds') ?? true;
    }

  }

  void removeAds() async {
    try {
      String paymentLink = await AdsService().getPaymentLink(1);
      if (paymentLink == '') {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Could not get payment link. Try again later.')));
        return;
      }
      await Get.to(() => PaymentScreen(url: paymentLink));
      String? token = await AuthService.getAuthorizationToken();
      if (token == null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('You are not logged in.')));
        return;
      }
      userController.hasFetchedUser = false;
      await userController.fetchUser(token);
      if (UserController.user.value!.ad!.isPaid ?? false) {
        showAds.value = false;
        // Save the updated show ads value to storage
        _storage.write('showAds', showAds.value);

        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Ads removed'),
          ),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Payment failed or cancelled. Ads not removed'),
          ),
        );
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void show() {
    showAds.value = true;
    // Save the updated show ads value to storage
    _storage.write('showAds', showAds.value);
  }
}
