class CaffeineCalculator {
  static int calculatedCafeCoffee({
    required String drink,
    required String size,
    required int shots,
  }) {
    const int caffeinePerShot = 63;
    return caffeinePerShot * shots;
  }
}
