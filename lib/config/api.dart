class Api {
  //* Creating instance constructor;
  static Api instance = Api();
  //* Base API URL
  static const domain = "http://192.168.1.10/mbc";
  static const baseURL = domain+"/public/api";
  static const imageURL =
      domain+"/storage/app/public/produk_photo";

  String getKabupatens = "$baseURL/kabupaten";
  String peternakURL = "$baseURL/peternak";
}
