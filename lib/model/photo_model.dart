
class PhotoModel{

  String imageSrc;
  String photographer;

  PhotoModel({
    required this.imageSrc,
    required this.photographer
  });

  static PhotoModel fromApi2App(Map<String, dynamic> photoMap){
    return PhotoModel(
        imageSrc: photoMap['src']['portrait'],
        photographer: photoMap['photographer'],
    );
  }
}