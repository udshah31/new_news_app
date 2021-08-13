import 'package:get/get.dart';
import 'package:new_design_news_app/model/news_model.dart';
import 'package:new_design_news_app/service/api_service.dart';

class DrawerNewsController extends GetxController {
  
  var isLoading = true.obs;
  var drawerNewsList = <News>[].obs;

  @override
  void onInit() {
    fetchDrawerNews();
    super.onInit();
  }

  Future<void> fetchDrawerNews({
    int drawerCategoryId = 0,
    int drawerPageNumber = 0,
    int drawerTotalRecords = 0,
  }) async {
    try {
      if (drawerNewsList.length == 0 || drawerPageNumber == 1) {
        isLoading(true);
        drawerNewsList.clear();
      }

      if (drawerNewsList.length < drawerTotalRecords) {
        var drawerNews =
            await APIService.drawerNews(drawerPageNumber, drawerCategoryId);
        if (drawerNews != null) {
          drawerNewsList.addAll(drawerNews);
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
