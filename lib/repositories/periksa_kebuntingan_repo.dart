import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/periksa_kebuntingan_model.dart';

abstract class PeriksaKebuntinganRepository {
  Future<PeriksaKebuntinganModel> periksaKebuntinganFetchData();
  Future<PeriksaKebuntinganModel> periksaKebuntinganStore(PeriksaKebuntingan periksaKebuntingan);
  Future<PeriksaKebuntinganModel> periksaKebuntinganUpdate(PeriksaKebuntingan periksaKebuntingan);
  Future<PeriksaKebuntinganModel> periksaKebuntinganDelete(PeriksaKebuntingan periksaKebuntingan);
  
}

class PeriksaKebuntinganRepositoryImpl implements PeriksaKebuntinganRepository {

  static const String TAG = "PeriksaKebuntinganRepositoryImpl";

  @override
  Future<PeriksaKebuntinganModel> periksaKebuntinganFetchData() async{
    var _response = await http.get(Uri.parse(Api.instance.periksaKebuntinganURL));
    print("$TAG, PeriksaKebuntinganFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("PeriksaKebuntinganFetchData $data");
      PeriksaKebuntinganModel model = PeriksaKebuntinganModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PeriksaKebuntinganModel> periksaKebuntinganStore(PeriksaKebuntingan periksaKebuntingan) async {
    var _response = await http.post(Uri.parse(Api.instance.periksaKebuntinganURL), body: {
      "waktu_pk": periksaKebuntingan.waktuPk,
      "metode" : periksaKebuntingan.metode,
      "hasil" : periksaKebuntingan.hasil,
      "sapi_id" : periksaKebuntingan.sapiId.toString(),
      });
    print("$TAG, PeriksaKebuntinganStore ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PeriksaKebuntinganModel model = PeriksaKebuntinganModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PeriksaKebuntinganModel> periksaKebuntinganUpdate(PeriksaKebuntingan periksaKebuntingan) async {
    var url = Api.instance.periksaKebuntinganURL+"/"+periksaKebuntingan.id.toString();

    var _response = await http.put(Uri.parse(url), body: {
      "waktu_pk": periksaKebuntingan.waktuPk,
      "metode" : periksaKebuntingan.metode,
      "hasil" : periksaKebuntingan.hasil,
      "sapi_id" : periksaKebuntingan.sapiId.toString(),
    });
    print("$TAG, PeriksaKebuntinganUpdate ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PeriksaKebuntinganModel model = PeriksaKebuntinganModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PeriksaKebuntinganModel> periksaKebuntinganDelete(PeriksaKebuntingan periksaKebuntingan) async{
    var _response = await http.delete(Uri.parse(Api.instance.periksaKebuntinganURL+"/"+periksaKebuntingan.id.toString()));
    print("$TAG, PeriksaKebuntinganDelete ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PeriksaKebuntinganModel model = PeriksaKebuntinganModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
  
}