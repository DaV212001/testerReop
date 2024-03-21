import 'package:get/get.dart';
import '../model/terms_and_conditions.dart';
import '../service/terms_and_conditions_service.dart';

class TermAndConditionController extends GetxController {
  final termAndConditionService = TermAndConditionService();
  final termAndCondition = TermAndCondition(id: 0, title: '', description: '', createdAt: '', updatedAt: '').obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTermAndCondition();
  }

  Future<void> fetchTermAndCondition() async {
    try {
      isLoading(true);
      final fetchedTermAndCondition = await termAndConditionService.fetchTermAndCondition();
      termAndCondition.value = fetchedTermAndCondition;
    } catch (e) {
      print('Error fetching Terms and Conditions: $e');
    } finally {
      isLoading(false);
    }
  }
}
