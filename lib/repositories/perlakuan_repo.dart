import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/perlakuan_model.dart';

abstract class PerlakuanRepository {
  Future<PerlakuanModel> perlakuanFetchData();
  Future<PerlakuanModel> perlakuanStore(Perlakuan perlakuan);
  Future<PerlakuanModel> perlakuanUpdate(Perlakuan perlakuan);
  Future<PerlakuanModel> perlakuanDelete(Perlakuan perlakuan);
  
}

class PerlakuanRepositoryImpl implements PerlakuanRepository {

  static const String TAG = "PerlakuanRepositoryImpl";

  @override
  Future<PerlakuanModel> perlakuanFetchData() async{
    var _response = await http.get(Uri.parse(Api.instance.perlakuanURL));
    print("$TAG, PerlakuanFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("PerlakuanFetchData $data");
      PerlakuanModel model = PerlakuanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PerlakuanModel> perlakuanStore(Perlakuan perlakuan) async {
    var _response = await http.post(Uri.parse(Api.instance.perlakuanURL), body: {
          "sapi_id" : perlakuan.sapiId.toString(), 
          "tgl" : perlakuan.tglPerlakuan,
          "obat" : perlakuan.jenisObat,
          "obat_dosis" : perlakuan.dosisObat.toString(),
          "vaksin" : perlakuan.vaksin,
          "vaksin_dosis" : perlakuan.dosisVaksin.toString(),
          "vitamin" : perlakuan.vitamin,
          "vitamin_dosis" : perlakuan.dosisVitamin.toString(),
          "hormon" : perlakuan.hormon,
          "hormon_dosis" : perlakuan.dosisHormon.toString(),
          "keterangan" : perlakuan.ketPerlakuan
    });

    print("$TAG, PerlakuanStore ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      PerlakuanModel model = PerlakuanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PerlakuanModel> perlakuanUpdate(Perlakuan perlakuan) async {
    var url = Api.instance.perlakuanURL+"/"+perlakuan.id.toString();
    var _response = await http.put(Uri.parse(url), body: {
          "sapi_id" : perlakuan.sapiId.toString(), 
          "tgl" : perlakuan.tglPerlakuan,
          "obat" : perlakuan.jenisObat,
          "obat_dosis" : perlakuan.dosisObat.toString(),
          "vaksin" : perlakuan.vaksin,
          "vaksin_dosis" : perlakuan.dosisVaksin.toString(),
          "vitamin" : perlakuan.vitamin,
          "vitamin_dosis" : perlakuan.dosisVitamin.toString(),
          "hormon" : perlakuan.hormon,
          "hormon_dosis" : perlakuan.dosisHormon.toString(),
          "keterangan" : perlakuan.ketPerlakuan
    });
    print("$TAG, PerlakuanUpdate ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      PerlakuanModel model = PerlakuanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PerlakuanModel> perlakuanDelete(Perlakuan perlakuan) async{
    var _response = await http.delete(Uri.parse(Api.instance.perlakuanURL+"/"+perlakuan.id.toString()));
    print("$TAG, PerlakuanDelete ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      PerlakuanModel model = PerlakuanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
  
}