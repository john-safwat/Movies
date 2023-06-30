import 'package:mymoviesapp/Data/Models/MovieResponse/@metaDTO.dart';
import 'package:mymoviesapp/Domain/Models/MoviesDetails/MovieDetailsResponse.dart';

import 'DataDTO.dart';

class MovieDetailsResponseDTO {
  MovieDetailsResponseDTO({
      this.status, 
      this.statusMessage, 
      this.data, 
      this.meta,});

  MovieDetailsResponseDTO.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? DataDTO.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? metaDTO.fromJson(json['@meta']) : null;
  }
  String? status;
  String? statusMessage;
  DataDTO? data;
  metaDTO? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (meta != null) {
      map['@meta'] = meta?.toJson();
    }
    return map;
  }

  MovieDetailsResponse toDomain(){
    return MovieDetailsResponse(
      statusMessage: statusMessage,
      status: status,
      movie: data!.movie!.toDomain()
    );
  }

}