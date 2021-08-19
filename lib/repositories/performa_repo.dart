import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/performa_model.dart';

abstract class PerformaRepository {
  Future<PerformaModel> performaFetchData();
  Future<PerformaModel> performaStore(Performa performa);
  Future<PerformaModel> performaUpdate(Performa performa);
  Future<PerformaModel> performaDelete(Performa performa);
  
}

class PerformaRepositoryImpl implements PerformaRepository {

  static const String TAG = "PerformaRepositoryImpl";

  @override
  Future<PerformaModel> performaFetchData() async{
    var _response = await http.get(Uri.parse(Api.instance.performaURL));
    print("$TAG, PerformaFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("PerformaFetchData $data");
      PerformaModel model = PerformaModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PerformaModel> performaStore(Performa performa) async {
    var _response = await http.post(Uri.parse(Api.instance.performaURL), body: {
          "tanggal" : performa.tanggalPerforma,
          "tinggi" : performa.tinggiBadan.toString(),
          "berat" : performa.beratBadan.toString(),
          "panjang" : performa.panjangBadan.toString(),
          "lingkar" : performa.lingkarDada.toString(),
          "bsc" : performa.bsc.toString(),
          "sapiId" : performa.sapiId.toString(),
      });
    print("$TAG, PerformaStore ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PerformaModel model = PerformaModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PerformaModel> performaUpdate(Performa performa) async {
    var url = Api.instance.performaURL+"/"+performa.id.toString();

    var _response = await http.put(Uri.parse(url), body: {
          "tanggal" : performa.tanggalPerforma,
          "tinggi" : performa.tinggiBadan.toString(),
          "berat" : performa.beratBadan.toString(),
          "panjang" : performa.panjangBadan.toString(),
          "lingkar" : performa.lingkarDada.toString(),
          "bsc" : performa.bsc.toString(),
          "sapiId" : performa.sapiId.toString(),
    });
    print("$TAG, PerformaUpdate ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PerformaModel model = PerformaModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PerformaModel> performaDelete(Performa performa) async{
    var _response = await http.delete(Uri.parse(Api.instance.performaURL+"/"+performa.id.toString()));
    print("$TAG, PerformaDelete ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PerformaModel model = PerformaModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
  
}