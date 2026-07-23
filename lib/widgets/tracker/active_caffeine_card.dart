import 'package:flutter/material.dart';

class ActiveCaffeineCard extends StatelessWidget {
  const ActiveCaffeineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF3A291F),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Active Caffeine",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "Peaked 1h 2m ago",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.white24),
                    ),
                  ),
                  child: Text("LOW", style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Center(
              child: SizedBox(
                width: 190,
                height: 190,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: CircularProgressIndicator(
                        value: 0.15,
                        strokeWidth: 12,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation(Color(0xFFD8A15B)
                        ),
                      ),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("20", style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                       Text(
                          "MG ACTIVE",
                          style: TextStyle(
                            color: Colors.white70,
                            letterSpacing: 2,
                          ),
                        ),

                         SizedBox(height: 8),

                        Text( 
                          "LOW",
                          style: TextStyle(
                            color: Color(0xFFD8A15B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ),

              )
          ],
        ),
      ),
    );
  }
}
