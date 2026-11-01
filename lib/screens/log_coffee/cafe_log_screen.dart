import 'package:flutter/material.dart';
import '../../widgets/common/selection_card.dart';
import '../../models/coffee_log.dart';
import '../../services/caffeine/caffeine_calculator.dart';
import '../log_coffee/done_log_screen.dart';
import '../../services/firestore/coffee_firestore_service.dart';

class CafeLogCoffee extends StatefulWidget {
  const CafeLogCoffee({super.key});

  @override
  State<CafeLogCoffee> createState() => _CafeLogCoffeeState();
}

class _CafeLogCoffeeState extends State<CafeLogCoffee> {
  String? selectedDrink;
  String? selectedSize;
  int? selectedQuantity; // shots or servings, depending on the drink
  TimeOfDay? selectedTime;

  // custom "Other" inputs
  final TextEditingController _customNameController = TextEditingController();
  final TextEditingController _customMgController = TextEditingController();

  static const TextStyle _sectionStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  @override
  void dispose() {
    _customNameController.dispose();
    _customMgController.dispose();
    super.dispose();
  }

  bool get _isCustom => selectedDrink == CaffeineCalculator.customDrink;

  double? get _customMg =>
      double.tryParse(_customMgController.text.trim().replaceAll(',', '.'));

  bool get _customValid => CaffeineCalculator.isValid(_customMg);

  /// "shot" or "serving" for the selected drink
  String get _unitText {
    if (selectedDrink == null || _isCustom) return "serving";
    return CaffeineCalculator.cafeDrink(selectedDrink!)?.unit.label ??
        "serving";
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : "${s[0].toUpperCase()}${s.substring(1)}";

  @override
  Widget build(BuildContext context) {
    final bool canLogCoffee =
        selectedDrink != null &&
        selectedSize != null &&
        selectedQuantity != null &&
        selectedTime != null &&
        (!_isCustom || _customValid);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Log Coffee", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1A1411),
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                const SizedBox(height: 10),

                const Text("Pick a drink : ", style: _sectionStyle),
                const SizedBox(height: 10),

                // Drink cards, two per row, built from the calculator table
                ..._buildDrinkRows(),

                // Custom inputs
                if (_isCustom) ...[
                  const SizedBox(height: 6),
                  _customField(
                    controller: _customNameController,
                    label: "Drink name (optional)",
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 12),
                  _customField(
                    controller: _customMgController,
                    label: "Caffeine per serving (mg)",
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    errorText:
                        _customMgController.text.trim().isNotEmpty &&
                            !_customValid
                        ? "Enter a value between 1 and "
                              "${CaffeineCalculator.maxPerUnit.toInt()} mg"
                        : null,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Check the cafe menu or packaging, or enter your best estimate.",
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                ],

                const SizedBox(height: 20),

                // Size (saved to the log; does not change the caffeine)
                const Text("Size : ", style: _sectionStyle),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(child: _sizeCard("Small", 4)),
                    const SizedBox(width: 12),
                    Expanded(child: _sizeCard("Medium", 8)),
                    const SizedBox(width: 12),
                    Expanded(child: _sizeCard("Large", 12)),
                  ],
                ),

                // Quantity (shots or servings)
                if (selectedDrink != null) ...[
                  const SizedBox(height: 20),
                  Text("${_capitalize(_unitText)} : ", style: _sectionStyle),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(child: _quantityBox(1)),
                      const SizedBox(width: 12),
                      Expanded(child: _quantityBox(2)),
                      const SizedBox(width: 12),
                      Expanded(child: _quantityBox(3)),
                      const SizedBox(width: 12),
                      Expanded(child: _quantityBox(4)),
                    ],
                  ),
                ],

                const SizedBox(height: 20),

                // Time
                const Text("Time : ", style: _sectionStyle),
                const SizedBox(height: 10),

                InkWell(
                  onTap: _pickTime,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: double.infinity,
                    height: 65,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A291F),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedTime == null
                              ? "Select time"
                              : selectedTime!.format(context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),

                // Submit
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: canLogCoffee ? _addCoffee : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD8B17B),
                      foregroundColor: const Color(0xFF1A1411),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Add Coffee",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- drink grid ----------

  List<Widget> _buildDrinkRows() {
    final List<String> names = CaffeineCalculator.cafeDrinkNamesWithCustom;
    final List<Widget> rows = [];

    for (int i = 0; i < names.length; i += 2) {
      final bool hasSecond = i + 1 < names.length;

      rows.add(
        Row(
          children: [
            Expanded(child: _drinkCard(names[i])),
            const SizedBox(width: 12),
            Expanded(
              child: hasSecond ? _drinkCard(names[i + 1]) : const SizedBox(),
            ),
          ],
        ),
      );
      rows.add(const SizedBox(height: 10));
    }

    return rows;
  }

  Widget _drinkCard(String name) {
    final CafeDrink? data = CaffeineCalculator.cafeDrink(name);

    void onTap() {
      setState(() {
        selectedDrink = selectedDrink == name ? null : name;

        // pre-fill the quantity (e.g. Flat White = 2 shots)
        selectedQuantity = (selectedDrink == null || data == null)
            ? null
            : data.defaultQuantity;

        _customNameController.clear();
        _customMgController.clear();
      });
    }

    // "Other" has no fixed caffeine value to show
    if (data == null) {
      return SelectionCard(
        label: name,
        selected: selectedDrink == name,
        onTap: onTap,
      );
    }

    return SelectionCard(
      label: name,
      value: data.mgPerUnit * data.defaultQuantity,
      unit: "mg",
      selected: selectedDrink == name,
      onTap: onTap,
    );
  }

  Widget _sizeCard(String label, int oz) {
    return SelectionCard(
      label: label,
      value: oz,
      unit: "oz",
      selected: selectedSize == label,
      onTap: () {
        setState(() {
          selectedSize = selectedSize == label ? null : label;
        });
      },
    );
  }

  Widget _quantityBox(int quantity) {
    final bool isSelected = selectedQuantity == quantity;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        setState(() {
          selectedQuantity = selectedQuantity == quantity ? null : quantity;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD8B17B) : const Color(0xFF3A291F),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            "${quantity}x",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFF1A1411) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _customField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        errorText: errorText,
        filled: true,
        fillColor: const Color(0xFF3A291F),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.white54),
        ),
      ),
    );
  }

  // ---------- actions ----------

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> _addCoffee() async {
    if (selectedDrink == null ||
        selectedSize == null ||
        selectedQuantity == null ||
        selectedTime == null) {
      return;
    }

    final bool isCustom = _isCustom;
    if (isCustom && !_customValid) return;

    // convert selected size into oz
    final int sizeOz = switch (selectedSize!) {
      "Small" => 4,
      "Medium" => 8,
      "Large" => 12,
      _ => 0,
    };

    // caffeine: custom = mg per serving x servings,
    // otherwise table value per shot / serving x quantity
    final int calculatedCaffeineMg = isCustom
        ? CaffeineCalculator.calcCustom(
            mgPerUnit: _customMg!,
            amount: selectedQuantity!.toDouble(),
          )
        : CaffeineCalculator.calculateCafeCoffee(
            drink: selectedDrink!,
            quantity: selectedQuantity!,
          );

    // drink name to save
    final String typedName = _customNameController.text.trim();
    final String drinkToSave = !isCustom
        ? selectedDrink!
        : (typedName.isEmpty ? CaffeineCalculator.customDrink : typedName);

    // combine today's date with the selected time
    final DateTime now = DateTime.now();

    DateTime consumedAt = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    // a time later than now must be from yesterday
    if (consumedAt.isAfter(now)) {
      consumedAt = consumedAt.subtract(const Duration(days: 1));
    }

    final CaffeineLog log = CaffeineLog(
      source: CoffeeSource.cafe,
      drinkName: drinkToSave,
      size: selectedSize!,
      sizeOz: sizeOz,
      shots: selectedQuantity!, // shots or servings
      caffeineMg: calculatedCaffeineMg,
      consumedAt: consumedAt,
      isCustom: isCustom,
      customMgPerUnit: isCustom ? _customMg : null,
    );

    try {
      await CoffeeFirestoreService.addCoffeeLog(log);

      debugPrint("Coffee added successfully");
      debugPrint("Drink: ${log.drinkName}");
      debugPrint("Size: ${log.size}");
      debugPrint("Size oz: ${log.sizeOz}");
      debugPrint("Quantity: ${log.shots}");
      debugPrint("Caffeine: ${log.caffeineMg} mg");
      debugPrint("Consumed at: ${log.consumedAt}");

      if (!mounted) return;

      Navigator.pushReplacement<void, bool>(
        context,
        MaterialPageRoute(
          builder: (context) => DoneLogScreen(
            drinkName: log.drinkName ?? "Coffee",
            caffeineMg: log.caffeineMg,
          ),
        ),
        result: true,
      );
    } catch (error) {
      debugPrint("Failed to save coffee: $error");

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to save coffee: $error")));
    }
  }
}
