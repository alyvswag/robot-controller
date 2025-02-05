import 'dart:convert';
import 'dart:io';

class WebsocketService {
  late WebSocket webSocket;

  // WebSocket serverinə qoşulma
  Future<void> connect(String robotName) async {
    try {
      // Serverə WebSocket ilə qoşul
      webSocket = await WebSocket.connect(
          'wss://websocket-js-production-f89e.up.railway.app/');

      print("Connected to WebSocket");

      // WebSocket-a mesaj göndərmək (robot adı ilə qeydiyyat)
      var registerMessage = jsonEncode({
        'type': 'register',
        'robotName': robotName,
      });

      // WebSocket serverinə register mesajını göndər
      webSocket.add(registerMessage);

      // WebSocket-dan gələn mesajları dinləyir
      webSocket.listen((message) {
        var response = jsonDecode(message);
        if (response['type'] == 'info') {
          print('Info: ${response['message']}');
        } else if (response['type'] == 'command') {
          print('Command received: ${response['command']}');
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  // Komanda göndərmək
  void sendMessage(String command) {
    var commandMessage = jsonEncode({
      'type': 'command',
      'command': command,
    });

    webSocket.add(commandMessage);
    print("Command sent: $command");
  }

  // Bağlantını bağlamaq
  void closeConnection() {
    webSocket.close();
    print('WebSocket connection closed');
  }
}
