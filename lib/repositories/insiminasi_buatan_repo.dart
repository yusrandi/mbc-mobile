import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/insiminasi_buatan_model.dart';

abstract class InsiminasiBuatanRepository {
  Future<InsiminasiBuatanModel> insiminasiBuatanFetchData();
  Future<InsiminasiBuatanModel> insiminasiBuatanStore(InsiminasiBuatan insiminasiBuatan);
  Future<InsiminasiBuatanModel> insiminasiBuatanUpdate(InsiminasiBuatan insiminasiBuatan);
  Future<InsiminasiBuatanModel> insiminasiBuatanDelete(InsiminasiBuatan insiminasiBuatan);
  
}

class InsiminasiBuatanRepositoryImpl implements InsiminasiBuatanRepository {

  static const String TAG = "InsiminasiBuatanRepositoryImpl";

  @override
  Future<InsiminasiBuatanModel> insiminasiBuatanFetchData() async{
    var _response = await http.get(Uri.parse(Api.instance.ibURL));
    print("$TAG, InsiminasiBuatanFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("InsiminasiBuatanFetchData $data");
      InsiminasiBuatanModel model = InsiminasiBuatanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<InsiminasiBuatanModel> insiminasiBuatanStore(InsiminasiBuatan insiminasiBuatan) async {
    var _response = await http.post(Uri.parse(Api.instance.ibURL), body: {
          "sapiId" : insiminasiBuatan.sapiId.toString(),
          "strowId" : insiminasiBuatan.strowId.toString(),
          "waktu" : insiminasiBuatan.waktuIb,
          "dosis" : insiminasiBuatan.dosisIb.toString(),
      });
    print("$TAG, InsiminasiBuatanStore ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      InsiminasiBuatanModel model = InsiminasiBuatanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<InsiminasiBuatanModel> insiminasiBuatanUpdate(InsiminasiBuatan insiminasiBuatan) async {
    var url = Api.instance.ibURL+"/"+insiminasiBuatan.id.toString();

    var _response = await http.put(Uri.parse(url), body: {
          "sapiId" : insiminasiBuatan.sapiId.toString(),
          "strowId" : insiminasiBuatan.strowId.toString(),
          "waktu" : insiminasiBuatan.waktuIb,
          "dosis" : insiminasiBuatan.dosisIb.toString(),
    });
    print("$TAG, InsiminasiBuatanUpdate ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      InsiminasiBuatanModel model = InsiminasiBuatanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<InsiminasiBuatanModel> insiminasiBuatanDelete(InsiminasiBuatan insiminasiBuatan) async{
    var _response = await http.delete(Uri.parse(Api.instance.ibURL+"/"+insiminasiBuatan.id.toString()));
    print("$TAG, InsiminasiBuatanDelete ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      InsiminasiBuatanModel model = InsiminasiBuatanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
  
}