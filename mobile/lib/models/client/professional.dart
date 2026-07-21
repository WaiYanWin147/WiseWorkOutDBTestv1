class Professional {
  final String name;
  final String specialties;
  final double rating;
  final int reviewCount;
  final int yearsExp;

  const Professional({
    required this.name,
    required this.specialties,
    required this.rating,
    required this.reviewCount,
    this.yearsExp = 10,
  });
}

class Review {
  final String reviewer;
  final double rating;
  final String text;

  const Review({
    required this.reviewer,
    required this.rating,
    required this.text,
  });
}

class ChatMessage {
  final String text;
  final bool fromMe;
  final String? planTitle;

  const ChatMessage({
    required this.text,
    this.fromMe = false,
    this.planTitle,
  });
}
