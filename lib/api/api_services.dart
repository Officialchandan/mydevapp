import 'package:dio/dio.dart';
import 'package:mydevapp/modal/api_models.dart';

class ApiManeger {
  static Future<DataFormUser?> getUserProfile() async {
    final Dio dio = Dio();

    String url = "https://myjson.dit.upm.es/api/bins/gbt5";
    DataFormUser userfrofile;
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      print('User Info: ${response.data}');
      userfrofile = DataFormUser.fromJson(response.data);
      print('User Info: $userfrofile');
    } else {
      return null;
    }
    return userfrofile;
  }
}
