import 'MovieDTO.dart';

class DataDTO {
  DataDTO({
      this.movie,});

  DataDTO.fromJson(dynamic json) {
    movie = json['movie'] != null ? MovieDTO.fromJson(json['movie']) : null;
  }
  MovieDTO? movie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (movie != null) {
      map['movie'] = movie?.toJson();
    }
    return map;
  }

}