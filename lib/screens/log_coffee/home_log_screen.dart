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
  String? selectedPrep;
  String? selectedBrand;
  TimeOfDay? selectedTime;
  int? selectedAmount;

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> brandOptions = {
      "Instant Coffee": ["Nescafé Classic", "Maxwell House", "Moccona"],
      "Ground Coffee": ["Starbucks", "Lavazza", "Illy"],
      "Coffee Sachet": ["OldTown", "Aik Cheong", "Ah Huat", "Nescafé"],
      "Coffee Capsule": ["Nespresso", "Starbucks", "L'OR", "Dolce Gusto"],
      "Espresso Machine": ["Lavazza", "Illy", "Starbucks", "Custom Beans"],
    };

    final Map<String, String> amountUnits = {
      "Instant Coffee": "teaspoon",
      "Ground Coffee": "tablespoon",
      "Coffee Sachet": "sachet",
      "Coffee Capsule": "capsule",
      "Espresso Machine": "shots",
    };

    final bool canAddCoffee =
        selectedPrep != null &&
        selectedBrand != null &&
        selectedTime != null &&
        selectedAmount != null;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Log Coffee", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1A1411),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: ListView(
            children: [
              //prep coffe section How did you prepare your coffee?
              const Text(
                "Preparation :",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(child: _prepCard("Instant Coffee")),
                  const SizedBox(width: 12),

                  Expanded(child: _prepCard("Ground Coffee")),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(child: _prepCard("Coffee Sachet")),

                  const SizedBox(width: 12),

                  Expanded(child: _prepCard("Coffee Capsule")),
                ],
              ),

              const SizedBox(height: 10),

              _prepCard("Espresso Machine"),

              if (selectedPrep != null) ...[
                const SizedBox(height: 28),

                //select brand next
                const Text(
                  "Brand :",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                ...brandOptions[selectedPrep]!.map((brand) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _brandCard(brand),
                  );
                }),
              ],

              if (selectedPrep != null) ...[
                const SizedBox(height: 10),

                Text(
                  "${amountUnits[selectedPrep]} Amount :",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
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

              //amount (spoon/sachet/capsule)
              const SizedBox(height: 12),
              Text(
                "Time : ",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              //time pick
              InkWell(
                onTap: _pickTime,
                borderRadius: BorderRadius.circular(18),

                child: Container(
                  width: 330,
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
    );
  }

  Widget _prepCard(String prep) {
    return SelectionCard(
      label: prep,
      selected: selectedPrep == prep,

      onTap: () {
        setState(() {
          if (selectedPrep == prep) {
            selectedPrep = null;
            selectedBrand = null;
          } else {
            selectedPrep = prep;

            //reset previous brand
            selectedBrand = null;
          }
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

    final int calculatedCaffeineMg = CaffeineCalculator.calculateHomeCoffee(
      prep: selectedPrep!,
      brand: selectedBrand!,
      amount: selectedAmount!,
    );

    final DateTime now = DateTime.now();

    final DateTime consumedAt = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    final CaffeineLog log = CaffeineLog.home(
      preparation: selectedPrep!,
      brand: selectedBrand!,
      quantity: selectedAmount!,
      caffeineMg: calculatedCaffeineMg,
      consumedAt: consumedAt,
    );

    try {
      //save to firebase
      await CoffeeFirestoreService.addCoffeeLog(log);

      debugPrint("Home coffee added!");
      debugPrint("Preparation: ${log.preparation}");
      debugPrint("Brand: ${log.brand}");
      debugPrint("Amount: ${log.quantity}");
      debugPrint("Caffeine: ${log.caffeineMg} mg");
      debugPrint("Time: ${log.consumedAt}");

      //make sure page exist
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
