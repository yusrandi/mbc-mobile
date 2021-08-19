import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/models/strow_model.dart';

class InsiminasiBuatanModel {
  String responsecode = "";
  String responsemsg = "";
  List<InsiminasiBuatan> insiminasiBuatan = [];

  InsiminasiBuatanModel(
      {required this.responsecode, required this.responsemsg, required this.insiminasiBuatan});

  InsiminasiBuatanModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['insiminasi_buatan'] != null) {
      json['insiminasi_buatan'].forEach((v) {
        insiminasiBuatan.add(new InsiminasiBuatan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['insiminasi_buatan'] =
        this.insiminasiBuatan.map((v) => v.toJson()).toList();
    return data;
  }
}

class InsiminasiBuatan {
  int id = 0;
  String waktuIb = "";
  int dosisIb = 0;
  int strowId = 0;
  int sapiId = 0;
  Sapi? sapi;
  Strow? strow;

  InsiminasiBuatan(
      {required this.id,
      required this.waktuIb,
      required this.dosisIb,
      required this.strowId,
      required this.sapiId,
      this.sapi,
      this.strow});

  InsiminasiBuatan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    waktuIb = json['waktu_ib'];
    dosisIb = json['dosis_ib'];
    strowId = json['strow_id'];
    sapiId = json['sapi_id'];
    sapi = json['sapi'] != null ? new Sapi.fromJson(json['sapi']) : null;
    strow = json['strow'] != null ? new Strow.fromJson(json['strow']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['waktu_ib'] = this.waktuIb;
    data['dosis_ib'] = this.dosisIb;
    data['strow_id'] = this.strowId;
    data['sapi_id'] = this.sapiId;
    if (this.sapi != null) {
      data['sapi'] = this.sapi!.toJson();
    }
    if (this.strow != null) {
      data['strow'] = this.strow!.toJson();
    }
    return data;
  }
}

