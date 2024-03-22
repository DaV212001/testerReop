import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/faq_controller.dart';
import 'package:mss_e_learning/model/faq.dart';

import '../../util/app_constants.dart';


class FAQScreen extends StatelessWidget {
  final faqController = Get.put(FAQController());

  FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Obx(
            () {
          if (faqController.isLoading.isTrue && faqController.faqs.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: AppConstants.primary,),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: faqController.faqs.length,
                    itemBuilder: (context, index) {
                      final FAQ faq = faqController.faqs[index];
                      return ListTile(
                        title: Text(faq.title),
                        subtitle: Text(faq.description),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: faqController.currentPage > 1 ? faqController.previousPage : null,
                      disabledColor: Colors.grey,
                    ),
                    Text('Page ${faqController.currentPage}'),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: faqController.currentPage < faqController.lastPage ? faqController.nextPage : null,
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
