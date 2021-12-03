import 'package:get/state_manager.dart';
import 'package:mydevapp/api/api_services.dart';
import 'package:mydevapp/modal/api_models.dart';

class UserProfileController extends GetxController {
  var isLoading = true.obs;
  var userprofilelist = <DataFormUser>[].obs;

  @override
  void onInit() {
    _fetchUserProfile();
    super.onInit();
  }

  _fetchUserProfile() async {
    try {
      isLoading(true);
      var userprofile = await ApiManeger.getUserProfile();
      print("hello user profile list of item $userprofile");
      if (userprofile != null) {
        userprofilelist.value == userprofile;
      }
    } finally {
      isLoading(false);
    }
  }
}
