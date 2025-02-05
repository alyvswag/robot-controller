import 'package:flutter/material.dart';
import 'package:robot_controller/services/shared_preferences_service.dart';
import 'package:robot_controller/services/websocket_service.dart';

class ControlScreen extends StatefulWidget {
  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  String? robotName;
  late WebsocketService socketService;

  @override
  void initState() {
    super.initState();
    setRobotName(); // Robot adını əldə et
  }

  Future<void> setRobotName() async {
    robotName = await SharedPreferencesService.getString('robotName');
    print("Robot name: $robotName");

    // robotName null olub-olmaması yoxlanılır
    if (robotName != null) {
      socketService = WebsocketService();
      await socketService.connect(robotName!); // WebSocketə qoşulma
      print("Connected to chat group: $robotName");
    } else {
      print("Robot name is null, cannot connect");
    }
  }

  void sendMessage(String direction) async {
    if (robotName == null) {
      print("Robot name is null, cannot send message");
      return;
    }

    socketService.sendMessage(direction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Robot Controller')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // UP Button
            GestureDetector(
              onLongPress: () {
                sendMessage('UP');
              },
              onLongPressUp: () {
                sendMessage('STOP');
              },
              child: ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.arrow_upward),
              ),
            ),
            SizedBox(height: 20),
            // LEFT, STOP, RIGHT Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LEFT Button
                GestureDetector(
                  onLongPress: () {
                    sendMessage('LEFT');
                  },
                  onLongPressUp: () {
                    sendMessage('STOP');
                  },
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                SizedBox(width: 20),
                // STOP Button
                GestureDetector(
                  onLongPress: () {
                    sendMessage('STOP');
                  },
                  onLongPressUp: () {
                    sendMessage('STOP');
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      sendMessage('STOP');
                    },
                    child: Icon(Icons.stop),
                  ),
                ),
                SizedBox(width: 20),
                // RIGHT Button
                GestureDetector(
                  onLongPress: () {
                    sendMessage('RIGHT');
                  },
                  onLongPressUp: () {
                    sendMessage('STOP');
                  },
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // DOWN Button
            GestureDetector(
              onLongPress: () {
                sendMessage('DOWN');
              },
              onLongPressUp: () {
                sendMessage('STOP');
              },
              child: ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.arrow_downward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
