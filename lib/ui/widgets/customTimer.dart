import 'dart:async';
import 'package:flutter/material.dart';

class CustomTimer extends StatefulWidget {

  final double timeInMinutes;
  final VoidCallback onEnd;
  final TextStyle textStyle;

  const CustomTimer({Key key, this.timeInMinutes, this.onEnd, this.textStyle}) : super(key: key);

  @override
  _CustomTimerState createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {

  Timer _timer;
  int _start;
  Duration time;

  void startTimer() {
    _start = (widget.timeInMinutes*60).toInt();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            widget.onEnd();
          });
        } else {
          setState(() {
            _start--;
            time = Duration(seconds: _start);
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: time == null ? Text("") : Text("${time?.inMinutes?.remainder(60).toString().padLeft(2,'0')}:${(time?.inSeconds?.remainder(60).toString().padLeft(2,'0'))}",style: widget.textStyle,));
  }
}
