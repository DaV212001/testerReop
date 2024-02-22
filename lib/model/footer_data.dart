class FooterData {
  String copyWriteText;
  String? faceBookLink;
  String? linkedInLink;
  String? youtubeLink;
  String? instagramLink;
  String? twitterLink;
  String? telegramLink;
  String? tiktokLink;

  FooterData({
    required this.copyWriteText,
    this.faceBookLink,
    this.instagramLink,
    this.linkedInLink,
    this.twitterLink,
    this.youtubeLink,
    this.telegramLink,
    this.tiktokLink,
  });

  factory FooterData.fromJson(Map<String, dynamic> json) {
    return FooterData(
        copyWriteText: json["copy_right_text"],
        faceBookLink: json["facebook"],
        instagramLink: json["instagram"],
        linkedInLink: json["linkedin"],
        twitterLink: json["twitter"],
        youtubeLink: json["youtube"],
        telegramLink: json["telegram"],
        tiktokLink: json["tiktok"]);
  }

  @override
  String toString() {
    return 'FooterData{copyWriteText: $copyWriteText, '
        'faceBookLink: $faceBookLink, '
        'linkedInLink: $linkedInLink, '
        'youtubeLink: $youtubeLink, '
        'instagramLink: $instagramLink, '
        'twitterLink: $twitterLink, '
        'telegramLink: $telegramLink, '
        'tiktokLink: $tiktokLink}';
  }
}
