import 'package:cloud_firestore/cloud_firestore.dart';

enum CoffeeSource { home, cafe }

class CaffeineLog {
  // Cafe
  final String? drinkName;
  final String? size;
  final int? sizeOz;
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

  // create a cafe log
  factory CaffeineLog.cafe({
    required String drinkName,
    required String size,
    required int sizeOz,
    required int shots,
    required int caffeineMg,
    required DateTime consumedAt,
  }) {
    return CaffeineLog(
      source: CoffeeSource.cafe,
      drinkName: drinkName,
      size: size,
      sizeOz: sizeOz,
      shots: shots,
      caffeineMg: caffeineMg,
      consumedAt: consumedAt,
    );
  }

  //create a home log
  factory CaffeineLog.home({
    required String brand,
    required String preparation,
    required int quantity,
    required int caffeineMg,
    required DateTime consumedAt,
  }) {
    return CaffeineLog(
      source: CoffeeSource.home,
      brand: brand,
      preparation: preparation,
      quantity: quantity,
      caffeineMg: caffeineMg,
      consumedAt: consumedAt,
    );
  }

  // Convert object to Map (useful for Firebase)
  Map<String, dynamic> toMap() {
    return {
       'source': source.name,

      // Cafe
      'drinkName': drinkName,
      'size': size,
      'sizeOz': sizeOz,
      'shots': shots,

      // Home
      'brand': brand,
      'preparation': preparation,
      'quantity': quantity,

      // Common
      'caffeineMg': caffeineMg,
      'consumedAt': Timestamp.fromDate(consumedAt)
    };
  }

  // Create object from Map
  factory CaffeineLog.fromMap(Map<String, dynamic> map) {
    return CaffeineLog(
      source: CoffeeSource.values.firstWhere(
        (source) => source.name == map['source'],
        orElse: () => CoffeeSource.home,
      ),

      // Cafe
      drinkName: map['drinkName'] as String?,
      size: map['size'] as String?,
      sizeOz: (map['sizeOz'] as num?)?.toInt(),
      shots: (map['shots'] as num?)?.toInt(),

      // Home
      brand: map['brand'] as String?,
      preparation: map['preparation'] as String?,
      quantity: (map['quantity'] as num?)?.toInt(),

      // Common
      caffeineMg: (map['caffeineMg'] as num).toInt(),
      consumedAt: (map['consumedAt'] as Timestamp).toDate(),
    );
  }
}
