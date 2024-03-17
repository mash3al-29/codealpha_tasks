import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/stopwatch_model.dart';
import '../FireBase/firebase_functions.dart';
import '../Styles/text_styles.dart';

class StopwatchApp extends StatefulWidget {
  const StopwatchApp({super.key});

  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  final Stopwatch _stopwatch = Stopwatch();
  Duration _elapsedTime = const Duration();
  bool _isRunning = false;

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  void _startStopwatch() {
    setState(() {
      _stopwatch.start();
      _isRunning = true;
    });
    _updateElapsedTime();
  }

  void _stopStopwatch() {
    setState(() {
      _stopwatch.stop();
      FirebaseFunctions.addStopWatch(
          StopWatchModel(time: _elapsedTime.inMilliseconds));
      _isRunning = false;
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      FirebaseFunctions.deleteStopWatchHistory();
      _elapsedTime = const Duration();
      _isRunning = false;
    });
  }

  void _updateElapsedTime() {
    if (_isRunning) {
      setState(() {
        _elapsedTime = _stopwatch.elapsed;
      });
      Future.delayed(const Duration(milliseconds: 10), _updateElapsedTime);
    }
  }

  String _formatElapsedTime(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    String milliseconds =
        (duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$milliseconds';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _formatElapsedTime(_elapsedTime),
          style: TextStyle(fontSize: 24.sp,color: Colors.black87),
        ),
        SizedBox(width: 20.w),
        ElevatedButton(
          onPressed: _isRunning ? _stopStopwatch : _startStopwatch,
          child: Text(_isRunning ? 'Stop' : 'Start', style: smallText.copyWith(color: Colors.black87)),
        ),
        SizedBox(width: 10.w),
        ElevatedButton(
          onPressed: _resetStopwatch,
          child: Text(
            'Reset',
            style: smallText.copyWith(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
