enum HomePrep { sachet, instant, ground, capsule, espresso }

class _HomeProduct {
  final int mg;
  final double perUnit;
  const _HomeProduct(this.mg, [this.perUnit = 1]);
}

class CaffeineCalculator {
  //cafe intake
  static const int caffeinePerShot = 63;

  static int calculateCafeCoffee({
    required String drink,
    required String size,
    required int shots,
  }) {
    return caffeinePerShot * shots;
  }

  //home intake
  static const Map<HomePrep, Map<String, _HomeProduct>> _homeData = {
    HomePrep.sachet: {
      "OldTown White Coffee (35g)": _HomeProduct(60),
      "Aik Cheong (20g)": _HomeProduct(62),
      "Ah Huat (38g)": _HomeProduct(60),
      "Nescafé 3-in-1": _HomeProduct(65),
    },
    HomePrep.instant: {
      //70 mg per 2g serving
      "Nescafé Classic": _HomeProduct(70, 2),
      "Maxwell House": _HomeProduct(70, 2),
      "Moccona": _HomeProduct(70, 2),
    },
    HomePrep.capsule: {
      "Nespresso": _HomeProduct(65),
      "Starbucks": _HomeProduct(65),
      "Nescafé Dolce Gusto": _HomeProduct(70),
    },
    HomePrep.ground: {
      // 10 mg per gram (provisional)
      "Starbucks": _HomeProduct(10),
      "Lavazza": _HomeProduct(10),
      "Illy": _HomeProduct(10),
    },
    HomePrep.espresso: {
      //63 mg per shot
      "Breville": _HomeProduct(63),
      "De'Longhi": _HomeProduct(63),
      "La Marzocco": _HomeProduct(63),
      "Lelit & Rocket Espresso": _HomeProduct(63),
    },
  };

  //[amount] meaning depends on prep
  //sachet = sachets | instant = gram | ground = gram | capsule = capsules | espresso = shots
  static int calculateHomeCoffee({
    required HomePrep prep,
    required String brand,
    required double amount,
  }) {
    if (amount <= 0) return 0;

    final product = _homeData[prep]?[brand];
    if (product == null) {
      throw ArgumentError('Unknown brand "$brand" for $prep');
    }

    return (product.mg * amount / product.perUnit).round();
  }

  static List<String> brandsFor(HomePrep prep) =>
      _homeData[prep]?.keys.toList() ?? [];

  //---for custom caffeine intake ---//
  static const String customBrand = "Other";
  static const double maxPerUnit = 300; //how much limit user can put

  static bool isValid(double? mg) => mg != null && mg > 0 && mg <= maxPerUnit;

  static int calcCustom({required double mgPerUnit, required double amount}) {
    if (amount <= 0) return 0;
    if (!isValid(mgPerUnit)) {
      throw ArgumentError('Invalid caffeine value: $mgPerUnit');
    }
    return (mgPerUnit * amount).round();
  }
}

extension HomePrepInfo on HomePrep {
  String get label => switch (this) {
    HomePrep.sachet => "Coffee Sachet",
    HomePrep.instant => "Instant Coffee",
    HomePrep.ground => "Ground Coffee",
    HomePrep.capsule => "COffee Capsule",
    HomePrep.espresso => "Espresso Machine",
  };

  //what user count
  String get unitLabel => switch (this) {
    HomePrep.sachet => "sachet",
    HomePrep.instant => "teaspoon",
    HomePrep.ground => "tablespoon",
    HomePrep.capsule => "capsule",
    HomePrep.espresso => "shot",
  };

  //convert ui into unit the calculator expects
  // (instant/ground = grmas, others = 1:1)
  double get amountMultiplier => switch (this) {
    HomePrep.instant => 2.0, //1 tsp = 2g
    HomePrep.ground => 5.0, //1 lev tbsp = 5g
    _ => 1.0,
  };
}
