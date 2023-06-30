import 'package:mymoviesapp/Domain/Models/MoviesDetails/Cast.dart';

class CastDTO {
  CastDTO({
      this.name, 
      this.characterName, 
      this.urlSmallImage, 
      this.imdbCode,});

  CastDTO.fromJson(dynamic json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }
  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['character_name'] = characterName;
    map['url_small_image'] = urlSmallImage;
    map['imdb_code'] = imdbCode;
    return map;
  }

  Cast toDomain(){
    return Cast(
      name: name,
      urlSmallImage: urlSmallImage,
      characterName: characterName
    );
  }
}