import 'package:get/get.dart';
import 'package:new_design_news_app/model/user_model.dart';
import 'package:new_design_news_app/service/api_service.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var userModel = User(
      id: 0,
      name: '',
      url: '',
      description: '',
      link: '',
      slug: '',
      avatarUrls: {}).obs;

  Future<void> fetchUser(int userId) async {
    try {
      isLoading(true);
      var users = await APIService.fetchUser(userId);
      if (users != null) {
        userModel.value = users;
      }
    } finally {
      isLoading(false);
    }
  }
}
