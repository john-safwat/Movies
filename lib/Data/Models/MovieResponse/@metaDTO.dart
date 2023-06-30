class metaDTO {
  metaDTO({
      this.serverTime, 
      this.serverTimezone, 
      this.apiVersion, 
      this.executionTime,});

  metaDTO.fromJson(dynamic json) {
    serverTime = json['server_time'];
    serverTimezone = json['server_timezone'];
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }
  num? serverTime;
  String? serverTimezone;
  num? apiVersion;
  String? executionTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['server_time'] = serverTime;
    map['server_timezone'] = serverTimezone;
    map['api_version'] = apiVersion;
    map['execution_time'] = executionTime;
    return map;
  }

}