import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WebSocketService {
  WebSocketChannel? _channel;
  final String baseWsUrl = 'ws://your-api-domain.com/ws'; // 실제 웹소켓 서버 주소로 변경 필요
  final String authToken;

  WebSocketService({required this.authToken});

  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse('$baseWsUrl?token=$authToken'),
    );
  }

  void listenToBattleUpdates(Function(Map<String, dynamic>) onUpdate) {
    _channel?.stream.listen(
      (message) {
        final data = jsonDecode(message);
        onUpdate(data);
      },
      onError: (error) {
        print('WebSocket Error: $error');
        // 재연결 로직 구현
        reconnect();
      },
    );
  }

  void sendBattleAction(Map<String, dynamic> action) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode(action));
    }
  }

  void reconnect() {
    disconnect();
    connect();
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
}
