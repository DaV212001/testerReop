import 'package:get/get.dart';
import '../model/faq.dart';
import '../service/faq_service.dart';

class FAQController extends GetxController {
  final _faqService = FAQService();
  final faqs = <FAQ>[].obs;
  final isLoading = true.obs;
  int currentPage = 1;
  int lastPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchFAQs();
  }

  Future<void> fetchFAQs() async {
    try {
      isLoading(true);
      final fetchedFAQs = await _faqService.fetchFAQs(page: currentPage);
      lastPage = fetchedFAQs.isEmpty ? currentPage : currentPage + 1;
      faqs.assignAll(fetchedFAQs);
    } catch (e) {
      print('Error fetching FAQs: $e');
    } finally {
      isLoading(false);
    }
  }

  void nextPage() {
    if (currentPage < lastPage) {
      currentPage++;
      fetchFAQs();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      fetchFAQs();
    }
  }
}
