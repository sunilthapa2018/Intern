class NotificationRequest {
  List<String>? registrationIds;
  SendNotification? notification;

  NotificationRequest({this.registrationIds, this.notification});

  NotificationRequest.fromJson(Map<String, dynamic> json) {
    registrationIds = json['registration_ids'].cast<String>();
    notification = json['notification'] != null
        ? SendNotification.fromJson(json['notification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registration_ids'] = registrationIds;
    if (notification != null) {
      data['notification'] = notification!.toJson();
    }
    return data;
  }
}

class SendNotification {
  String? body;
  String? title;
  String? androidChannelId;
  String? image;
  bool? sound;

  SendNotification(
      {this.body, this.title, this.androidChannelId, this.image, this.sound});

  SendNotification.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    title = json['title'];
    androidChannelId = json['android_channel_id'];
    image = json['image'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    data['title'] = title;
    data['android_channel_id'] = androidChannelId;
    data['image'] = image;
    data['sound'] = sound;
    return data;
  }
}
