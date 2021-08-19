import 'package:mbc_mobile/models/sapi_model.dart';

class PerlakuanModel {
  String responsecode = "";
  String responsemsg = "";
  List<Perlakuan> perlakuan = [];

  PerlakuanModel({required this.responsecode, required this.responsemsg, required this.perlakuan});

  PerlakuanModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['perlakuan'] != null) {
      json['perlakuan'].forEach((v) {
        perlakuan.add(new Perlakuan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['perlakuan'] = this.perlakuan.map((v) => v.toJson()).toList();
    return data;
  }
}

class Perlakuan {
  int id = 0 ;
  int sapiId = 0;
  String tglPerlakuan = "";
  String jenisObat = "";
  int dosisObat = 0;
  String vaksin = "";
  int dosisVaksin = 0;
  String vitamin = "";
  int dosisVitamin = 0;
  String hormon = "";
  int dosisHormon = 0;
  String ketPerlakuan = "";
  Sapi? sapi;

  Perlakuan(
      {required this.id,
      required this.sapiId,
      required this.tglPerlakuan,
      required this.jenisObat,
      required this.dosisObat,
      required this.vaksin,
      required this.dosisVaksin,
      required this.vitamin,
      required this.dosisVitamin,
      required this.hormon,
      required this.dosisHormon,
      required this.ketPerlakuan,
      this.sapi});

  Perlakuan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sapiId = json['sapi_id'];
    tglPerlakuan = json['tgl_perlakuan'];
    jenisObat = json['jenis_obat'];
    dosisObat = json['dosis_obat'];
    vaksin = json['vaksin'];
    dosisVaksin = json['dosis_vaksin'];
    vitamin = json['vitamin'];
    dosisVitamin = json['dosis_vitamin'];
    hormon = json['hormon'];
    dosisHormon = json['dosis_hormon'];
    ketPerlakuan = json['ket_perlakuan'];
    sapi = json['sapi'] != null ? new Sapi.fromJson(json['sapi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sapi_id'] = this.sapiId;
    data['tgl_perlakuan'] = this.tglPerlakuan;
    data['jenis_obat'] = this.jenisObat;
    data['dosis_obat'] = this.dosisObat;
    data['vaksin'] = this.vaksin;
    data['dosis_vaksin'] = this.dosisVaksin;
    data['vitamin'] = this.vitamin;
    data['dosis_vitamin'] = this.dosisVitamin;
    data['hormon'] = this.hormon;
    data['dosis_hormon'] = this.dosisHormon;
    data['ket_perlakuan'] = this.ketPerlakuan;
    if (this.sapi != null) {
      data['sapi'] = this.sapi!.toJson();
    }
    return data;
  }
}

