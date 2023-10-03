import 'package:http/http.dart'as http;

Future<bool> isvalidNetworkImage({required url}) async {
  try {
    var aa = await http.head(Uri.parse(url));
    return aa.statusCode == 200;
  } catch (error) {
    return false;
  }
}