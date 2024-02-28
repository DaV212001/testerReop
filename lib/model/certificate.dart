import 'package:mss_e_learning/model/sub_category.dart';

class Certificates {
  final SubCategory subcategory;
  final String url;

  Certificates({required this.subcategory, required this.url});

  factory Certificates.fromJson(Map<String, dynamic> json) {
    print(json);
    return Certificates(
      subcategory: SubCategory.fromJson(json['subcategory']),
      url: json['url'],
    );
  }
}