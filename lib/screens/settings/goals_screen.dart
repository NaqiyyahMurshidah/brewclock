import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/settings/goals/goals_sum_card.dart';
import '../../widgets/settings/goals/caff_limit_goal_card.dart';
import '../../widgets/settings/goals/sleep_goal_card.dart';
import '../../widgets/settings/goals/preferred_bedtime_card.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  static const Color _backgroundColor = Color(0xFF1A1411);

  static const Color _cardColor = Color(0xFF30261F);

  static const Color _accentColor = Color(0xFFD8A15B);

  static const Color _secondaryText = Color(0xFFB8A99F);

  double _caffeineLimit = 400;
  int _sleepGoal = 8;

  TimeOfDay _preferredBedtime = const TimeOfDay(hour: 23, minute: 0);

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final data = snapshot.data();

      if (data != null && mounted) {
        final double loadedCaffeine =
            (data['caffeineLimit'] as num?)?.toDouble() ?? 400;

        final int loadedSleep = (data['sleepGoalHours'] as num?)?.toInt() ?? 8;

        final int loadedBedtime =
            (data['preferredBedtimeMinutes'] as num?)?.toInt() ?? 1380;

        setState(() {
          _caffeineLimit = loadedCaffeine.clamp(100, 500).toDouble();

          _sleepGoal = loadedSleep.clamp(6, 9);

          final int safeBedtime = loadedBedtime.clamp(0, 1439);

          _preferredBedtime = TimeOfDay(
            hour: safeBedtime ~/ 60,
            minute: safeBedtime % 60,
          );
        });
      }
    } catch (error) {
      debugPrint('Error loading goals: $error');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _selectBedtime() async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: _preferredBedtime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: _accentColor,
              onPrimary: _backgroundColor,
              surface: _cardColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selected != null) {
      setState(() {
        _preferredBedtime = selected;
      });
    }
  }

  Future<void> _saveGoals() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _showMessage('Please log in again');
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final int bedtimeMinutes =
          _preferredBedtime.hour * 60 + _preferredBedtime.minute;

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'caffeineLimit': _caffeineLimit.round(),
        'sleepGoalHours': _sleepGoal,
        'preferredBedtimeMinutes': bedtimeMinutes,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (!mounted) return;

      _showMessage('Goals updated successfully');

      Navigator.pop(context, true);
    } on FirebaseException catch (error) {
      if (!mounted) return;

      _showMessage(error.message ?? 'Unable to save goals');
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: _cardColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Caffeine & Sleep Goals',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: _accentColor))
          : SafeArea(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(
                  context,
                ).copyWith(overscroll: false),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 30),
                  children: [
                    const Text(
                      'Set goals that fit your daily routine',
                      style: TextStyle(color: _secondaryText, fontSize: 14),
                    ),

                    const SizedBox(height: 25),

                    GoalsSummaryCards(
                      caffeineLimit: _caffeineLimit.round(),
                      sleepGoal: _sleepGoal,
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Your Goals',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    CaffeineLimitGoalCard(
                      caffeineLimit: _caffeineLimit,
                      onChanged: (value) {
                        setState(() {
                          _caffeineLimit = value;
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    SleepGoalCard(
                      sleepGoal: _sleepGoal,
                      onChanged: (hours) {
                        setState(() {
                          _sleepGoal = hours;
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    PreferredBedtimeCard(
                      bedtime: _preferredBedtime,
                      onTap: _selectBedtime,
                    ),

                    const SizedBox(height: 18),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.lightbulb_outline, color: _accentColor),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Used to personalise your reminders and insights.',
                              style: TextStyle(
                                color: _secondaryText,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveGoals,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentColor,
                          foregroundColor: _backgroundColor,
                          disabledBackgroundColor: _accentColor.withValues(
                            alpha: 0.5,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 23,
                                height: 23,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: _backgroundColor,
                                ),
                              )
                            : const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
