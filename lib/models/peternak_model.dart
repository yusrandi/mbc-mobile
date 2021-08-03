class PeternakModel {
  String responsecode = "";
  String responsemsg = "";
  List<Peternak> peternak = [];

  PeternakModel({required this.responsecode, required this.responsemsg, required this.peternak});

  PeternakModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['peternak'] != null) {
      json['peternak'].forEach((v) {
        peternak.add(new Peternak.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    if (this.peternak != null) {
      data['peternak'] = this.peternak.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Peternak {
  int id = 0;
  String kodePeternak = "";
  String namaPeternak = "";
  String noHp = "";
  String tglLahir = "";
  String jumlahAnggota = "";
  String luasLahan = "";
  String kelompok = "";
  int desaId = 0;
  Desa? desa;

  Peternak(
      {required this.id,
      required this.kodePeternak,
      required this.namaPeternak,
      required this.noHp,
      required this.tglLahir,
      required this.jumlahAnggota,
      required this.luasLahan,
      required this.kelompok,
      required this.desaId,
      this.desa});

  Peternak.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodePeternak = json['kode_peternak'];
    namaPeternak = json['nama_peternak'];
    noHp = json['no_hp'];
    tglLahir = json['tgl_lahir'];
    jumlahAnggota = json['jumlah_anggota'];
    luasLahan = json['luas_lahan'];
    kelompok = json['kelompok'];
    desaId = json['desa_id'];
    desa = json['desa'] != null ? new Desa.fromJson(json['desa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_peternak'] = this.kodePeternak;
    data['nama_peternak'] = this.namaPeternak;
    data['no_hp'] = this.noHp;
    data['tgl_lahir'] = this.tglLahir;
    data['jumlah_anggota'] = this.jumlahAnggota;
    data['luas_lahan'] = this.luasLahan;
    data['kelompok'] = this.kelompok;
    data['desa_id'] = this.desaId;
    if (this.desa != null) {
      data['desa'] = this.desa!.toJson();
    }
    return data;
  }
}

class Desa {
  int id = 0;
  int kecamatanId = 0;
  String name = "";
  Kecamatan? kecamatan;

  Desa(
      {required this.id,
      required this.kecamatanId,
      required this.name,
      this.kecamatan});

  Desa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kecamatanId = json['kecamatan_id'];
    name = json['name'];
    kecamatan = json['kecamatan'] != null
        ? new Kecamatan.fromJson(json['kecamatan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kecamatan_id'] = this.kecamatanId;
    data['name'] = this.name;
    if (this.kecamatan != null) {
      data['kecamatan'] = this.kecamatan!.toJson();
    }
    return data;
  }
}

class Kecamatan {
  int id = 0;
  int kabupatenId = 0;
  String name = "";
  Kabupaten? kabupaten;

  Kecamatan(
      {required this.id,
      required this.kabupatenId,
      required this.name,
      this.kabupaten});

  Kecamatan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kabupatenId = json['kabupaten_id'];
    name = json['name'];
    kabupaten = json['kabupaten'] != null
        ? new Kabupaten.fromJson(json['kabupaten'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kabupaten_id'] = this.kabupatenId;
    data['name'] = this.name;
    if (this.kabupaten != null) {
      data['kabupaten'] = this.kabupaten!.toJson();
    }
    return data;
  }
}

class Kabupaten {
  int id = 0;
  String name = "";

  Kabupaten({required this.id, required this.name});

  Kabupaten.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

