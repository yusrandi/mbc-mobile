import 'dart:convert';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:http/http.dart' as http;


abstract class SapiRepository {
  Future<SapiModel> sapiFetchData();
}

class SapiRepositoryImpl implements SapiRepository {

  static const String TAG = "SapiRepositoryImpl";

  @override
  Future<SapiModel> sapiFetchData() async{
    var _response = await http.get(Uri.parse(Api.instance.sapiURL));
    print("$TAG, sapiFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("sapiFetchData $data");
      SapiModel model = SapiModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
