import 'dart:convert';
import 'dart:developer';

import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../Features/Auth/data/models/login_model.dart';

class SignalRService {
  late HubConnection hubConnection;
  final Logger hubProtLogger = Logger("SignalR - hub");
  final Logger transportProtLogger = Logger("SignalR - transport");
  final String serverUrl = "https://dev-be.amaantv.com/hub/tv";

  SignalRService() {
    // Configure the logging
    Logger.root.level = Level.ALL;
    // Writes the log messages to the console
    Logger.root.onRecord.listen((LogRecord rec) {
      log('${rec.level.name}: ${rec.time}: ${rec.message}', name: rec.loggerName);
    });
  }

  Future<void> init(String guid, Function(AuthModel authModel) onAuthCompleted) async {
    final httpOptions = HttpConnectionOptions(logger: transportProtLogger);

    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options: httpOptions)
        .configureLogging(hubProtLogger)
        .withAutomaticReconnect() // Highly recommended for TV apps
        .build();

    hubConnection.onclose(({error}) => print("Connection Closed: $error"));

    // --- REGISTER ALL LISTENERS FIRST ---

    hubConnection.on("Registered", (args) {
      // Access the first element of the list
      print("Successfully registered with GUID: ${args?.first}");
    });

    hubConnection.on("AuthCompleted", (args) {
      final raw = args?.first;
      print('sdvlksdnvsdv222');
      if (raw is Map) {
        print('sdvlksdnvsdv111');
        final data = Map<String, dynamic>.from(raw);
        print("AuthCompleted JSON: $data");
        print("AuthCompleted JSON: ${AuthModel.fromMap(data).authModel.toJson()}");
        onAuthCompleted(AuthModel.fromMap(data));
      }
    });

    // Example for a generic message from backend
    hubConnection.on("ReceiveMessage", (args) {
      print("New Message: ${args?[0]} from ${args?[1]}");
    });

    // --- NOW START AND INVOKE ---
    // try {
      await hubConnection.start();
      print("SignalR Connected. State: ${hubConnection.state}");

      // Only invoke after the connection is fully open
      await hubConnection.invoke("Register", args: [guid]);
      print("Register invocation sent.");
    // } catch (e) {
    //   print("SignalR Error: $e");
    // }
  }
}
