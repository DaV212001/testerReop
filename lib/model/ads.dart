class Ad {
  int? id;
  bool? isPaid;

  Ad({
    this.id,
    this.isPaid
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json['id'],
      isPaid: json['is_paid']
    );
  }
}