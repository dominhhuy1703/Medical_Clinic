class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String imageUrl;

  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });


  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      specialty: json['specialty'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      imageUrl: json['imageUrl'],
    );
  }
}
