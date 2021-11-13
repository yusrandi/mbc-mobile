import 'package:mbc_mobile/models/sapi_model.dart';

class MasterSapiModel {
  String responsecode = "";
  String responsemsg = "";
  List<JenisSapi> jenisSapi = [];
  List<StatusSapi> statusSapi = [];

  MasterSapiModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.jenisSapi,
      required this.statusSapi});

  MasterSapiModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['jenis_sapi'] != null) {
      jenisSapi = <JenisSapi>[];
      json['jenis_sapi'].forEach((v) {
        jenisSapi.add(new JenisSapi.fromJson(v));
      });
    }
    if (json['status_sapi'] != null) {
      statusSapi = <StatusSapi>[];
      json['status_sapi'].forEach((v) {
        statusSapi.add(new StatusSapi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    if (this.jenisSapi != null) {
      data['jenis_sapi'] = this.jenisSapi.map((v) => v.toJson()).toList();
    }
    if (this.statusSapi != null) {
      data['status_sapi'] = this.statusSapi.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
