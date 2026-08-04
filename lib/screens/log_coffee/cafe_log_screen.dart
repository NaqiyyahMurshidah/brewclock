import 'package:flutter/material.dart';
import '../../widgets/common/selection_card.dart';

class CafeLogCoffee extends StatefulWidget {
  const CafeLogCoffee({super.key});

  @override
  State<CafeLogCoffee> createState() => _CafeLogCoffeeState();
}

class _CafeLogCoffeeState extends State<CafeLogCoffee> {
  String? selectedDrink;
  String? selectedSize;
  int? selectedShots;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final bool canLogCoffee =
        selectedDrink != null &&
        selectedSize != null &&
        selectedShots != null &&
        selectedTime != null;
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
              //page header here
              const SizedBox(height: 10),

              Text(
                "Pick a drink : ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

              const SizedBox(height: 10),

              //drink card 1 layer
              Row(
                children: [
                  Expanded(
                    child: SelectionCard(
                      label: "Espresso",
                      value: 110,
                      unit: "mg",
                      selected: selectedDrink == "Espresso",
                      onTap: () {
                        setState(() {
                          selectedDrink = selectedDrink == "Espresso"
                              ? null
                              : "Espresso";
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SelectionCard(
                      label: "Double Espresso",
                      value: 110,
                      unit: "mg",
                      selected: selectedDrink == "Double Espresso",
                      onTap: () {
                        setState(() {
                          selectedDrink = selectedDrink == "Double Espresso"
                              ? null
                              : "Double Espresso";
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: SelectionCard(
                      label: "Latte",
                      value: 110,
                      unit: "mg",
                      selected: selectedDrink == "Latte",
                      onTap: () {
                        setState(() {
                          selectedDrink = selectedDrink == "Latte"
                              ? null
                              : "Latte";
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SelectionCard(
                      label: "Cappuccino",
                      value: 110,
                      unit: "mg",
                      selected: selectedDrink == "Cappuccino",
                      onTap: () {
                        setState(() {
                          selectedDrink = selectedDrink == "Cappuccino"
                              ? null
                              : "Cappuccino";
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: SelectionCard(
                      label: "Americano",
                      value: 110,
                      unit: "mg",
                      selected: selectedDrink == "Americano",
                      onTap: () {
                        setState(() {
                          selectedDrink = selectedDrink == "Americano"
                              ? null
                              : "Americano";
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SelectionCard(
                      label: "Flat White",
                      value: 110,
                      unit: "mg",
                      selected: selectedDrink == "Flat White",
                      onTap: () {
                        setState(() {
                          selectedDrink = selectedDrink == "Flat White"
                              ? null
                              : "Flat White";
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: SelectionCard(
                      label: "Mocha",
                      value: 110,
                      unit: "mg",
                      selected: selectedDrink == "Mocha",
                      onTap: () {
                        setState(() {
                          selectedDrink = selectedDrink == "Mocha"
                              ? null
                              : "Mocha";
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),
                  Expanded(
                    child: SelectionCard(
                      label: "Macchiato",
                      value: 110,
                      unit: "mg",
                      selected: selectedDrink == "Macchiato",
                      onTap: () {
                        setState(() {
                          selectedDrink = selectedDrink == "Macchiato"
                              ? null
                              : "Macchiato";
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              //pick size
              Text(
                "Size : ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

              const SizedBox(height: 10),
              //select size
              Row(
                children: [
                  Expanded(
                    child: SelectionCard(
                      label: "Small",
                      value: 4,
                      unit: "oz",
                      selected: selectedSize == "Small",
                      onTap: () {
                        setState(() {
                          selectedSize = selectedSize == "Small"
                              ? null
                              : "Small";
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SelectionCard(
                      label: "Medium",
                      value: 8,
                      unit: "oz",
                      selected: selectedSize == "Medium",
                      onTap: () {
                        setState(() {
                          selectedSize = selectedSize == "Medium"
                              ? null
                              : "Medium";
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SelectionCard(
                      label: "Large",
                      value: 12,
                      unit: "oz",
                      selected: selectedSize == "Large",
                      onTap: () {
                        setState(() {
                          selectedSize = selectedSize == "Large"
                              ? null
                              : "Large";
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              //pick shots
              Text(
                "Shot : ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(child: _shotBox(1)),
                  const SizedBox(width: 12),

                  Expanded(child: _shotBox(2)),
                  const SizedBox(width: 12),

                  Expanded(child: _shotBox(3)),
                  const SizedBox(width: 12),

                  Expanded(child: _shotBox(4)),
                ],
              ),

              const SizedBox(height: 10),

              //pick time
              Text(
                "Time : ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

              const SizedBox(height: 10),

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

              //submit button
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addCoffee() {
    //later calculation caffeine
    debugPrint("Drink: $selectedDrink");
    debugPrint("Size: $selectedSize");
    debugPrint("Shots: $selectedShots");
    debugPrint("Time: $selectedTime");
  }

  Widget _shotBox(int shots) {
    final bool isSelected = selectedShots == shots;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        setState(() {
          selectedShots = selectedShots == shots ? null : shots;
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
            "${shots}x",
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
}
