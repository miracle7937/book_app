class AudioModelResponse {
  bool? status;
  List<AudioData>? data;

  AudioModelResponse({this.status, this.data});

  AudioModelResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AudioData>[];
      json['data'].forEach((v) {
        data!.add(new AudioData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AudioData {
  String? audio;
  String? audioDuration;
  String? images;

  AudioData({this.audio, this.audioDuration, this.images});

  AudioData.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];
    audioDuration = json['audio_duration'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audio'] = this.audio;
    data['audio_duration'] = this.audioDuration;
    data['images'] = this.images;
    return data;
  }
}
