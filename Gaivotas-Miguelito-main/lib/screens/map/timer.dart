import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimePage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => TimePage(),
      ),
    );
  }

  @override
  _State createState() => _State();
}

class _State extends State<TimePage> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: MaterialButton(
              color: Colors.white70,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
              onPressed: () async {
                _stopWatchTimer.onExecute.add(StopWatchExecute.start);
              },
              child:Icon(
                Icons.play_arrow,
                color: Colors.green,
                size: 30,
              ),
            ),
          ),

          Icon(
            Icons.access_alarm,
            color: Colors.black,
            size: 25,
          ),
          SizedBox(width: 5,),
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
            builder: (context, snap) {
              final value = snap.data;
              final displayTime =
              StopWatchTimer.getDisplayTime(value, hours: _isHours);
              return Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: Text(displayTime,
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Roboto Mono',
                      fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: MaterialButton(
              color: Colors.white70,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
              onPressed: () async {
                _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
              },
              child:Icon(
                Icons.stop,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}