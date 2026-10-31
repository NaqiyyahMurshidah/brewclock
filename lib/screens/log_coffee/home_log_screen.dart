import 'package:flutter/material.dart';
import '../../widgets/common/selection_card.dart';
import '../../services/caffeine/caffeine_calculator.dart';
import '../../models/coffee_log.dart';
import '../log_coffee/done_log_screen.dart';
import '../../services/firestore/coffee_firestore_service.dart';

class HomeLogCoffee extends StatefulWidget {
  const HomeLogCoffee({super.key});

  @override
  State<HomeLogCoffee> createState() => _HomeLogCoffeeState();
}

class _HomeLogCoffeeState extends State<HomeLogCoffee> {
  HomePrep? selectedPrep;
  String? selectedBrand;
  TimeOfDay? selectedTime;
  int? selectedAmount;

  //custom other input
  final TextEditingController _customNameController = TextEditingController();
  final TextEditingController _customMgController = TextEditingController();

  static const TextStyle _sectionStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  @override
  void dispose() {
    _customNameController.dispose();
    _customMgController.dispose();
    super.dispose();
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : "${s[0].toUpperCase()}${s.substring(1)}";

  bool get _isCustom => selectedBrand == CaffeineCalculator.customBrand;

  double? get _customMg =>
      double.tryParse(_customMgController.text.trim().replaceAll(',', '.'));

  bool get _customValid => CaffeineCalculator.isValid(_customMg);

  @override
  Widget build(BuildContext context) {
    final bool canAddCoffee =
        selectedPrep != null &&
        selectedBrand != null &&
        selectedTime != null &&
        selectedAmount != null &&
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
                // Preparation
                const Text("Preparation :", style: _sectionStyle),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(child: _prepCard(HomePrep.instant)),
                    const SizedBox(width: 12),
                    Expanded(child: _prepCard(HomePrep.ground)),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(child: _prepCard(HomePrep.sachet)),
                    const SizedBox(width: 12),
                    Expanded(child: _prepCard(HomePrep.capsule)),
                  ],
                ),
                const SizedBox(height: 10),

                _prepCard(HomePrep.espresso),

                // Brand
                if (selectedPrep != null) ...[
                  const SizedBox(height: 28),
                  const Text("Brand :", style: _sectionStyle),
                  const SizedBox(height: 12),

                  ...[
                    ...CaffeineCalculator.brandsFor(selectedPrep!),
                    CaffeineCalculator.customBrand,
                  ].map((brand) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _brandCard(brand),
                    );
                  }),
                ],

                //custom caffeien inputs
                if (selectedPrep != null && _isCustom) ...[
                  const SizedBox(height: 6),
                  _customField(
                    controller: _customNameController,
                    label: "Brand name (optional)",
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 12),
                  _customField(
                    controller: _customMgController,
                    label: "Caffeine per ${selectedPrep!.unitLabel} (mg)",
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
                    "Check the packaging, or enter your best estimate.",
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                ],

                // Amount
                if (selectedPrep != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    "${_capitalize(selectedPrep!.unitLabel)} Amount :",
                    style: _sectionStyle,
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: List.generate(4, (index) {
                      final amountValue = index + 1;

                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: amountValue == 4 ? 0 : 12,
                          ),
                          child: SelectionCard(
                            label: "$amountValue",
                            selected: selectedAmount == amountValue,
                            onTap: () {
                              setState(() {
                                selectedAmount = selectedAmount == amountValue
                                    ? null
                                    : amountValue;
                              });
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ],

                // Time
                const SizedBox(height: 24),
                const Text("Time :", style: _sectionStyle),
                const SizedBox(height: 12),

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

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: canAddCoffee ? _addCoffee : null,
                    child: const Text("Add Coffee"),
                  ),
                ),
              ],
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

  Widget _prepCard(HomePrep prep) {
    return SelectionCard(
      label: prep.label,
      selected: selectedPrep == prep,
      onTap: () {
        setState(() {
          selectedPrep = selectedPrep == prep ? null : prep;

          // brands and units differ per prep, so reset both
          selectedBrand = null;
          selectedAmount = null;
          _customNameController.clear();
          _customMgController.clear();
        });
      },
    );
  }

  Widget _brandCard(String brand) {
    return SelectionCard(
      label: brand,
      selected: selectedBrand == brand,
      onTap: () {
        setState(() {
          selectedBrand = selectedBrand == brand ? null : brand;
        });
      },
    );
  }

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
    if (selectedPrep == null ||
        selectedBrand == null ||
        selectedAmount == null ||
        selectedTime == null) {
      return;
    }

    final HomePrep prep = selectedPrep!;
    final bool isCustom = _isCustom;

    if (isCustom && !_customValid) return;

    //brand name to save
    final String typeName = _customNameController.text.trim();
    final String brandToSave = !isCustom
        ? selectedBrand!
        : (typeName.isEmpty ? CaffeineCalculator.customBrand : typeName);

    // Convert UI unit (tsp / tbsp) into what the calculator expects (grams)
    final int calculatedCaffeineMg = isCustom
        ? CaffeineCalculator.calcCustom(
            mgPerUnit: _customMg!,
            amount: selectedAmount!.toDouble(),
          )
        : CaffeineCalculator.calculateHomeCoffee(
            prep: prep,
            brand: brandToSave,
            amount: selectedAmount! * prep.amountMultiplier,
          );
    final DateTime now = DateTime.now();

    DateTime consumedAt = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    // If the chosen time is later than now, it must be from yesterday
    if (consumedAt.isAfter(now)) {
      consumedAt = consumedAt.subtract(const Duration(days: 1));
    }

    final CaffeineLog log = CaffeineLog.home(
      preparation: prep.label, // readable string for Firestore
      brand: brandToSave,
      quantity: selectedAmount!, // what the user actually entered
      caffeineMg: calculatedCaffeineMg,
      consumedAt: consumedAt,
      isCustom: isCustom,
      customMgPerUnit: isCustom ? _customMg : null,
    );

    try {
      await CoffeeFirestoreService.addCoffeeLog(log);

      debugPrint("Home coffee added!");
      debugPrint("Preparation: ${log.preparation}");
      debugPrint("Brand: ${log.brand}");
      debugPrint("Amount: ${log.quantity}");
      debugPrint("Caffeine: ${log.caffeineMg} mg");
      debugPrint("Time: ${log.consumedAt}");

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
