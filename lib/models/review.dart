class Review {
  final String name;
  final String distance;
  final int userId;
  final String review;
  final int rating;

  Review({
    required this.name,
    required this.distance,
    required this.userId,
    required this.review,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      name: json['name'],
      distance: json['foodId'], // ชื่อต้องตรงกับ json db
      userId: json['userId'],
      review: json['review'],
      rating: json['rating'],
    );
  }
}
