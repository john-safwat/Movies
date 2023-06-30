import 'package:mymoviesapp/Domain/Models/Movies/MovieResponse.dart';

import 'DataDTO.dart';
import '@metaDTO.dart';

class MovieResponseDTO {
  MovieResponseDTO({
      this.status, 
      this.statusMessage, 
      this.data, 
      this.metaa,});

  MovieResponseDTO.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? DataDTO.fromJson(json['data']) : null;
    metaa = json['@meta'] != null ? metaDTO.fromJson(json['@meta']) : null;
  }
  String? status;
  String? statusMessage;
  DataDTO? data;
  metaDTO? metaa;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (metaDTO != null) {
      map['@meta'] = metaa?.toJson();
    }
    return map;
  }
  MovieResponse toDomain(){
    return MovieResponse(
      statusMessage: statusMessage,
      status: status,
      movies: data!.movies!.map((e) => e.toDomain()).toList(),
    );
  }
}