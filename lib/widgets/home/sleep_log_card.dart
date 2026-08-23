import 'package:flutter/material.dart';
import '../../models/sleep_log.dart';
import '../../services/firestore/sleep_firestore_service.dart';

class SleepLogCard extends StatefulWidget {
  final TimeOfDay? initialBedtime;
  final TimeOfDay? initialWakeup;
  final void Function(TimeOfDay bedtime, TimeOfDay wakeup, Duration duration)?
  onSaved;

  const SleepLogCard({
    super.key,
    this.initialBedtime,
    this.initialWakeup,
    this.onSaved,
  });

  @override
  State<SleepLogCard> createState() => _SleepLogCardState();
}

class _SleepLogCardState extends State<SleepLogCard> {
  TimeOfDay? bedtime;
  TimeOfDay? wakeup;

  @override
  void initState() {
    super.initState();

    bedtime = widget.initialBedtime;
    wakeup = widget.initialWakeup;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SleepLog>>(
      stream: SleepFirestoreService.getSleepLogs(),

      builder: (context, snapshot) {
        final List<SleepLog> logs = snapshot.data ?? [];
        final SleepLog? latestLog = logs.isEmpty ? null : logs.last;

        final TimeOfDay? displayBedtime =
            bedtime ??
            (latestLog == null
                ? null
                : TimeOfDay.fromDateTime(latestLog.bedtime));

        final TimeOfDay? displayWakeup =
            wakeup ??
            (latestLog == null
                ? null
                : TimeOfDay.fromDateTime(latestLog.wakeTime));

        final Duration? displayDuration = latestLog?.duration;

        return Container(
          padding: const EdgeInsets.all(18),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF30261F),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.bedtime_rounded,
                color: Color(0xFFD8A15B),
                size: 32,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Last Night's Sleep",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      latestLog == null
                          ? "Not recorded yet"
                          : "${_formatTime(displayBedtime!)} – "
                                "${_formatTime(displayWakeup!)} • "
                                "${_formatDuration(displayDuration!)}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              OutlinedButton(
                onPressed: _timeLog,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFD8A15B),
                  side: const BorderSide(color: Color(0xFFD8A15B)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(latestLog == null ? "Log Sleep" : "Edit"),
              ),
            ],
          ),
        );
      },
    );
  }

  //show user input log wakeup time
  Future<void> _timeLog() async {
    //selection inside sheet
    TimeOfDay? selectedBedtime = bedtime;
    TimeOfDay? selectedWakeup = wakeup;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final Duration? duration = _calcSleepDuration(
              selectedBedtime,
              selectedWakeup,
            );

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
              decoration: const BoxDecoration(
                color: Color(0xFF2B1F19),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //drag habdler
                  Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Last Night's Sleep",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                        },
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),

                  const Text(
                    "Click to enter last night's sleep time",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [
                      Expanded(
                        child: _TimeCard(
                          title: "Bedtime",
                          time: selectedBedtime,
                          icon: Icons.bedtime_rounded,
                          onTap: () async {
                            final TimeOfDay? result = await showTimePicker(
                              context: sheetContext,
                              initialTime:
                                  selectedBedtime ??
                                  const TimeOfDay(hour: 23, minute: 0),
                            );

                            if (result != null) {
                              setSheetState(() {
                                selectedBedtime = result;
                              });
                            }
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _TimeCard(
                          title: "Wake-up",
                          time: selectedWakeup,
                          icon: Icons.wb_sunny_rounded,
                          onTap: () async {
                            final TimeOfDay? result = await showTimePicker(
                              context: sheetContext,
                              initialTime:
                                  selectedWakeup ??
                                  const TimeOfDay(hour: 7, minute: 0),
                            );

                            if (result != null) {
                              setSheetState(() {
                                selectedWakeup = result;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B2A20),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF6A4A37)),
                    ),

                    child: Column(
                      children: [
                        const Text(
                          "Sleep Duration",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          duration == null
                              ? "No Data"
                              : _formatDuration(duration),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: duration == null
                          ? null
                          : () async {
                              final SleepLog sleepLog = _createSleepLog(
                                bedtime: selectedBedtime!,
                                wakeTime: selectedWakeup!,
                              );

                              try {
                                // Save to Firestore first
                                await SleepFirestoreService.addSleepLog(
                                  sleepLog,
                                );

                                if (!mounted) {
                                  return;
                                } //check whether the context is safe
                                if (!sheetContext.mounted) {
                                  return;
                                } //check the context its exist

                                setState(() {
                                  bedtime = TimeOfDay.fromDateTime(
                                    sleepLog.bedtime,
                                  );

                                  wakeup = TimeOfDay.fromDateTime(
                                    sleepLog.wakeTime,
                                  );
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Sleep successfully recorded",
                                    ),
                                  ),
                                );

                                Navigator.pop(sheetContext);
                              } catch (error) {
                                debugPrint("Failed to save sleep: $error");

                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Failed to save sleep. Please try again.",
                                    ),
                                  ),
                                );
                              }
                            },

                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFD8A15B),
                        disabledForegroundColor: Colors.white30,
                        side: BorderSide(
                          color: duration == null
                              ? Colors.white24
                              : const Color(0xFFD8A15B),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "Save Sleep",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Duration? _calcSleepDuration(TimeOfDay? bedtime, TimeOfDay? wakeup) {
    if (bedtime == null || wakeup == null) {
      return null;
    }

    final int bedtimeMinutes = bedtime.hour * 60 + bedtime.minute;

    int wakeupMinutes = wakeup.hour * 60 + wakeup.minute;

    //wakeup normally on the following day
    if (wakeupMinutes < bedtimeMinutes) {
      wakeupMinutes += 24 * 60;
    }

    return Duration(minutes: wakeupMinutes - bedtimeMinutes);
  }

  String _formatDuration(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);

    return "$hours h ${minutes.toString().padLeft(2, '0')} min";
  }

  String _formatTime(TimeOfDay time) {
    final int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;

    final String minute = time.minute.toString().padLeft(2, '0');

    final String period = time.period == DayPeriod.am ? "AM" : "PM";

    return "$hour:$minute $period";
  }
}

class _TimeCard extends StatelessWidget {
  final String title;
  final TimeOfDay? time;
  final IconData icon;
  final VoidCallback onTap;

  const _TimeCard({
    required this.title,
    required this.time,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF3B2A20),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF6A4A37)),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFFD8A15B), size: 28),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      time == null ? "Select" : time!.format(context),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}

SleepLog _createSleepLog({
  required TimeOfDay bedtime,
  required TimeOfDay wakeTime,
}) {
  final DateTime today = DateTime.now();

  DateTime wakeDateTime = DateTime(
    today.year,
    today.month,
    today.day,
    wakeTime.hour,
    wakeTime.minute,
  );

  DateTime bedtimeDateTime = DateTime(
    today.year,
    today.month,
    today.day,
    bedtime.hour,
    bedtime.minute,
  );

  //if bedtime is later than wake-up
  //bedtime happened on the previous day
  if (!bedtimeDateTime.isBefore(wakeDateTime)) {
    bedtimeDateTime = bedtimeDateTime.subtract(const Duration(days: 1));
  }

  final Duration sleepDuration = wakeDateTime.difference(bedtimeDateTime);

  return SleepLog(
    bedtime: bedtimeDateTime,
    wakeTime: wakeDateTime,
    duration: sleepDuration,
  );
}
