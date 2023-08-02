String assetPath(String imageName, {String last = "png"}) {
  return "assets/images/$imageName.$last";
}

class ImageName {
  static String homeIcon = assetPath('home_icon');
  static String bankIcon = assetPath('bank_icon');
  static String person = assetPath('person');
  static String airtel = assetPath('airtel');
  static String etisalat = assetPath('etisalat');
  static String glo = assetPath('glo');
  static String mtn = assetPath('mtn');
  static String search = assetPath('search');
  static String call = assetPath('call');
  static String loader = assetPath("loader", last: "gif");
}
