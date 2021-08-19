import 'package:mbc_mobile/models/sapi_model.dart';

class PeriksaKebuntinganModel {
  String responsecode = "";
  String responsemsg = "";
  List<PeriksaKebuntingan> periksaKebuntingan = [];

  PeriksaKebuntinganModel(
      {required this.responsecode, required this.responsemsg, required this.periksaKebuntingan});

  PeriksaKebuntinganModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['periksa_kebuntingan'] != null) {
      json['periksa_kebuntingan'].forEach((v) {
        periksaKebuntingan.add(new PeriksaKebuntingan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['periksa_kebuntingan'] =
        this.periksaKebuntingan.map((v) => v.toJson()).toList();
    return data;
  }
}

class PeriksaKebuntingan {
  int id = 0;
  int sapiId = 0;
  String waktuPk = "";
  String metode = "";
  String hasil = "";
  Sapi? sapi;

  PeriksaKebuntingan(
      {required this.id,
      required this.sapiId,
      required this.waktuPk,
      required this.metode,
      required this.hasil,
      this.sapi});

  PeriksaKebuntingan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sapiId = json['sapi_id'];
    waktuPk = json['waktu_pk'];
    metode = json['metode'];
    hasil = json['hasil'];
    sapi = json['sapi'] != null ? new Sapi.fromJson(json['sapi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sapi_id'] = this.sapiId;
    data['waktu_pk'] = this.waktuPk;
    data['metode'] = this.metode;
    data['hasil'] = this.hasil;
    if (this.sapi != null) {
      data['sapi'] = this.sapi!.toJson();
    }
    return data;
  }
}



