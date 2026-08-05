enum CoffeeSource { home, cafe }

class CaffeineLog {
  // Cafe
  final String? drinkName;
  final String? size;
  final String? sizeOz;
  final int? shots;

  // Home
  final String? brand;
  final String? preparation;
  final int? quantity;

  //for both source
  final int caffeineMg;
  final DateTime consumedAt;
  final CoffeeSource source;

  const CaffeineLog({
    required this.source,

    //cafe
    this.drinkName,
    this.size,
    this.shots,
    this.sizeOz,

    //home
    this.brand,
    this.preparation,
    this.quantity,

    required this.caffeineMg,
    required this.consumedAt,
  });

  // Convert object to Map (useful for Firebase)
  Map<String, dynamic> toMap() {
    return {
      'source': source,
      'drinkName': drinkName,
      'caffeineMg': caffeineMg,
      'consumedAt': consumedAt.toIso8601String(),
    };
  }

  // Create object from Map
  factory CaffeineLog.fromMap(Map<String, dynamic> map) {
    return CaffeineLog(
      source: map['source'],
      drinkName: map['drinkName'],
      caffeineMg: map['caffeineMg'],
      consumedAt: DateTime.parse(map['consumedAt']),
    );
  }
}
