import 'package:dio/dio.dart';
import 'package:mydevapp/getx_state_manegement/model.dart';

// class RemoteServices {
//   static Future<List<DataFormUser>> fetchProducts() async {
//     var dio = Dio();
//     String url =
//         'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline';

//     var response = await dio.get(url);
//     if (response.statusCode == 200) {
//       var jsonString = response.data[0];
//       print("----vchdandan${jsonString.toString()}");
//       return dataFormUserFromJson(response.data.toString());
//     }
//     print("data---->>>>>${response.data} ");
//     print("statuscode---->>>>>${response.statusCode} ");
//     print("statusMessage--->>>>>${response.statusMessage} ");

//     return null!;
//   }
// }

import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<List<DataFormUser>> fetchProducts() async {
    var response = await client.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return dataFormUserFromJson(jsonString);
    } else {
      //show error message
      return null!;
    }
  }
}
