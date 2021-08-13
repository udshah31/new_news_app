import 'package:get/get.dart';
import 'package:new_design_news_app/model/news_model.dart';
import 'package:new_design_news_app/service/api_service.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var newsList = <News>[].obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  Future<void> fetchNews({
    int categoryId = 0,
    int pageNumber = 0,
    int totalRecords = 0,
  }) async {
    try {
      if (newsList.length == 0 || pageNumber == 1) {
        isLoading(true);
        newsList.clear();
      }

      if (newsList.length < totalRecords) {
        var news = await APIService.news(pageNumber, categoryId);
        // ignore: unnecessary_null_comparison
        if (news != null) {
          newsList.addAll(news);
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
