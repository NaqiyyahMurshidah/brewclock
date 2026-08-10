class CaffeineCalculator {
  static int calculateCafeCoffee({
    required String drink,
    required String size,
    required int shots,
  }) {
    const int caffeinePerShot = 63;
    return caffeinePerShot * shots;
  }

  static int calculateHomeCoffee({
    required String prep,
    required String brand,
    required int amount,
  }) {
    final int caffeinePerUnit = _getHomeCaffeinePerUnit(
      prep: prep,
      brand: brand,
    );

    return caffeinePerUnit * amount;
  }

  static int _getHomeCaffeinePerUnit({
    required String prep,
    required String brand,
  }) {
    const Map<String, Map<String, int>> caffeineData = {
      "Instant Coffee": {
        "Nescafé Classic": 30,
        "Maxwell House": 35,
        "Moccona": 32,
      },

      "Ground Coffee": {"Starbucks": 60, "Lavazza": 60, "Illy": 60},

      "Coffee Sachet": {
        "OldTown": 50,
        "Aik Cheong": 50,
        "Ah Huat": 50,
        "Nescafé": 50,
      },

      "Coffee Capsule": {
        "Nespresso": 60,
        "Starbucks": 60,
        "L'OR": 60,
        "Dolce Gusto": 60,
      },

      "Espresso Machine": {
        "Lavazza": 63,
        "Illy": 63,
        "Starbucks": 63,
        "Custom Beans": 63,
      },
    };

    return caffeineData[prep]?[brand] ?? 0;
  }
}
