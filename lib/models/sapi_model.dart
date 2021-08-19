import 'package:mbc_mobile/models/peternak_model.dart';

class SapiModel {
  String responsecode = "";
  String responsemsg = "";
  List<Sapi> sapi = [];

  SapiModel({required this.responsecode, required this.responsemsg, required this.sapi});

  SapiModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['sapi'] != null) {
      json['sapi'].forEach((v) {
        sapi.add(new Sapi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    if (this.sapi != null) {
      data['sapi'] = this.sapi.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sapi {
  int id = 0;
  int jenisSapiId = 0;
  int peternakId = 0;
  String ertag = "";
  String ertagInduk = "";
  String namaSapi = "";
  String tanggalLahir = "";
  String kelamin = "";
  String kondisiLahir = "";
  String anakKe = "";
  String fotoDepan = "";
  String fotoBelakang = "";
  String fotoKanan = "";
  String fotoKiri = "";
  JenisSapi? jenisSapi;
  Peternak? peternak;

  Sapi(
      {required this.id,
        required this.jenisSapiId,
        required this.peternakId,
        required this.ertag,
        required this.ertagInduk,
        required this.namaSapi,
        required this.tanggalLahir,
        required this.kelamin,
        required this.kondisiLahir,
        required this.anakKe,
        required this.fotoDepan,
        required this.fotoBelakang,
        required this.fotoKanan,
        required this.fotoKiri,
        this.jenisSapi,
        this.peternak});

  Sapi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenisSapiId = json['jenis_sapi_id'];
    peternakId = json['peternak_id'];
    ertag = json['ertag'];
    ertagInduk = json['ertag_induk'];
    namaSapi = json['nama_sapi'];
    tanggalLahir = json['tanggal_lahir'];
    kelamin = json['kelamin'];
    kondisiLahir = json['kondisi_lahir'];
    anakKe = json['anak_ke'];
    fotoDepan = json['foto_depan'];
    fotoBelakang = json['foto_belakang'];
    fotoKanan = json['foto_kanan'];
    fotoKiri = json['foto_kiri'];
    jenisSapi = json['jenis_sapi'] != null
        ? new JenisSapi.fromJson(json['jenis_sapi'])
        : null;
    peternak = json['peternak'] != null
        ? new Peternak.fromJson(json['peternak'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jenis_sapi_id'] = this.jenisSapiId;
    data['peternak_id'] = this.peternakId;
    data['ertag'] = this.ertag;
    data['ertag_induk'] = this.ertagInduk;
    data['nama_sapi'] = this.namaSapi;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['kelamin'] = this.kelamin;
    data['kondisi_lahir'] = this.kondisiLahir;
    data['anak_ke'] = this.anakKe;
    data['foto_depan'] = this.fotoDepan;
    data['foto_belakang'] = this.fotoBelakang;
    data['foto_kanan'] = this.fotoKanan;
    data['foto_kiri'] = this.fotoKiri;
    if (this.jenisSapi != null) {
      data['jenis_sapi'] = this.jenisSapi!.toJson();
    }
    if (this.peternak != null) {
      data['peternak'] = this.peternak!.toJson();
    }
    return data;
  }
}

class JenisSapi {
  int id = 0;
  String jenis = "";
  String ketJenis = "";

  JenisSapi(
      {required this.id, required this.jenis, required this.ketJenis});

  JenisSapi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenis = json['jenis'];
    ketJenis = json['ket_jenis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jenis'] = this.jenis;
    data['ket_jenis'] = this.ketJenis;
    return data;
  }
}


