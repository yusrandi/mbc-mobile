class Api {
  //* Creating instance constructor;
  static Api instance = Api();
  //* Base API URL
  static const domain = "http://192.168.1.4/mbc";
  static const baseURL = domain+"/public/api";
  static const imageURL =
      domain+"/storage/app/public/produk_photo";

  String getKabupatens = "$baseURL/kabupaten";
  String peternakURL = "$baseURL/peternak";
  String loginURL = "$baseURL/login";
  String periksaKebuntinganURL = "$baseURL/pk";
  String sapiURL = "$baseURL/sapi";
  String performaURL = "$baseURL/performa";
  String strowURL = "$baseURL/strow";
  String ibURL = "$baseURL/ib";
  String perlakuanURL = "$baseURL/perlakuan";
  String notifURL = "$baseURL/notif";
}