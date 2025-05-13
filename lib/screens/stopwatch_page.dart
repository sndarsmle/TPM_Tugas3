import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Timer _timer;
  int _milliseconds = 0;
  bool _isRunning = false;
  List<String> _laps = [];

  void _startStopwatch() {
    if (!_isRunning) {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          _milliseconds += 100;
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _pauseStopwatch() {
    if (_isRunning) {
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void _resetStopwatch() {
    if (_isRunning) _timer.cancel();
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
      _laps.clear();
    });
  }

  void _addLap() {
    final lapTime = _formatTime(_milliseconds);
    setState(() {
      _laps.add(lapTime);
    });
  }

  String _formatTime(int milliseconds) {
    final totalSeconds = milliseconds ~/ 1000;
    final totalMinutes = totalSeconds ~/ 60;
    final totalHours = totalMinutes ~/ 60;
    final days = totalHours ~/ 24;
    final hours = (totalHours % 24).toString().padLeft(2, '0');
    final minutes = (totalMinutes % 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    final milli = ((milliseconds % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$days:$hours:$minutes:$seconds.$milli';
  }

  @override
  void dispose() {
    if (_isRunning) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'MENU STOPWATCH',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Waktu Berjalan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _formatTime(_milliseconds),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D1C4C),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed:
                              _isRunning ? _pauseStopwatch : _startStopwatch,
                          icon: Icon(
                            _isRunning ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          label: Text(_isRunning ? 'Pause' : 'Start',
                              style: const TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _isRunning ? Colors.orange : Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          onPressed: _resetStopwatch,
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          label: const Text('Reset',
                              style: const TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _addLap,
                      icon: const Icon(Icons.flag, color: Colors.white),
                      label: const Text('Lap',
                          style: const TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (_laps.isNotEmpty) ...[
                  const Text(
                    'Laps:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Wrap ListView.builder inside SingleChildScrollView
                  SizedBox(
                    height: 200, // Limit the height of the lap list
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(_laps.length, (index) {
                          return ListTile(
                            title: Text(_laps[index]),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
