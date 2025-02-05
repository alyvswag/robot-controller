class MessageModel {
  final String direction;

  MessageModel({
    required this.direction,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : direction = json['direction'];

  Map<String, dynamic> toJson() => {
        'direction': direction,
      };
}
