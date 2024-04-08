import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';
import 'package:mss_e_learning/controller/ad_controller.dart';
import 'package:mss_e_learning/util/ad_unit_ids.dart';

import '../util/app_constants.dart';
import 'authorization_service.dart';

class AdsService {
  final AdController _adController = Get.find();

  Future<List<BannerAd>> loadBannerAds({required int count}) async {
    if (_adController.showAds.value == false) {
      return [];
    }
    List<BannerAd> bannerAds = [];
    for (int i = 0; i < count; i++) {
      final BannerAd bannerAd = BannerAd(
        adUnitId: AdUnitId.bannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('Ad loaded: $ad');
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('Ad failed to load: $error');
          },
        ),
      );
      await bannerAd.load();
      bannerAds.add(bannerAd);
    }
    return bannerAds;
  }

  Future<void> showAppOpenAd() async {
    if (_adController.showAds.value == true) {
      await AppOpenAd.load(
        adUnitId: AdUnitId.appOpenAdUnitID, //Your ad Id from admob
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (ad) {
              ad.show();
            },
            onAdFailedToLoad: (error) {}),
      );
    }
  }

  Future<void> showInterstitialAd() async {

    if (_adController.showAds.value == true) {
      await InterstitialAd.load(
          adUnitId: AdUnitId.interstitialAdUnitId,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
            ad.show();
            ad.fullScreenContentCallback =
                FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
                  print('SCHEDULED FOR: ${DateTime.now().add(const Duration(minutes: 5)).hour}:${DateTime.now().add(const Duration(minutes: 5)).minute}');
              Future.delayed(const Duration(minutes: 5), () async {
                print('SCHEDULED FOR: ${DateTime.now().add(const Duration(minutes: 5)).hour}:${DateTime.now().add(const Duration(minutes: 5)).minute}');
                await showInterstitialAd();
              });
              ad.dispose();
            });
          }, onAdFailedToLoad: (aderr) {
          }));
    }
  }

  Future<String> getPaymentLink(int certificateID) async {

    String? token = await AuthService.getAuthorizationToken();
    if (token == null) {
      return '';
    }

    final response = await post(
        Uri.parse('${AppConstants.api}/user_payment_for_ads'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    String paymentLink = '';
    print('CHECKING MAKE PAYMENT: ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String checkoutUrl =
          responseData['data'][0]['chapa']['data']['checkout_url'];
      print('CHECKING URL: $checkoutUrl');
      paymentLink = checkoutUrl;
    }
    return paymentLink;
  }
}
