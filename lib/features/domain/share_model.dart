class ShareModel{
  final String platform;
  final String url;
  final String urlImage;

  ShareModel({required this.platform, required this.url, required this.urlImage});
  factory ShareModel.fromMap(Map<String,dynamic> map){
    return ShareModel(
      platform: map["platform"],
     url: map['url'],
      urlImage: map['urlImage']);
  }
}