
class UploadVideo{
  String? videoUrl;
  String?downloadUrl;
  String?videoId;

  UploadVideo({
    this.downloadUrl,
    this.videoUrl,
    this.videoId
});

  UploadVideo.fromJson(json){
    this.videoUrl=json['videoUrl'];
    this.downloadUrl=json['downloadUrl'];
    this.videoId=json['videoId'];

  }
  toJson(){
    return {
      'videoUrl': this.videoUrl,
      'downloadUrl': this.downloadUrl,
      'videoId': this.videoId,
    };
  }
}

