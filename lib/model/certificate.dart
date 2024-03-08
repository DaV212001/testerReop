import 'package:mss_e_learning/model/sub_category.dart';
import 'package:mss_e_learning/model/test_result.dart';
import 'package:mss_e_learning/util/app_constants.dart';

class Certificates {
  final TestResult testResult;
  final String url;

  Certificates({required this.testResult, required this.url});

  factory Certificates.fromJson(Map<String, dynamic> json) {
    print(json);
    return Certificates(
      testResult: TestResult.fromJson(json['test_result']),
      url: AppConstants.imagebaseurl + json['certificate'],
    );
  }
}