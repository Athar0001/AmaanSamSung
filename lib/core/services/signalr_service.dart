import 'dart:developer';

import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  late HubConnection hubConnection;
  final Logger hubProtLogger = Logger("SignalR - hub");
  final Logger transportProtLogger = Logger("SignalR - transport");
  final String serverUrl = "https://amaan-be.runasp.net/hub/tv";

  SignalRService() {
    // Configure the logging
    Logger.root.level = Level.ALL;
    // Writes the log messages to the console
    Logger.root.onRecord.listen((LogRecord rec) {
      log('${rec.level.name}: ${rec.time}: ${rec.message}', name: rec.loggerName);
    });
  }

  Future<void> init(String guid) async {
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
      print("AuthComplete received: ${args?.first}");
    });

    // Example for a generic message from backend
    hubConnection.on("ReceiveMessage", (args) {
      print("New Message: ${args?[0]} from ${args?[1]}");
    });

    // --- NOW START AND INVOKE ---
    try {
      await hubConnection.start();
      print("SignalR Connected. State: ${hubConnection.state}");

      // Only invoke after the connection is fully open
      await hubConnection.invoke("Register", args: [guid]);
      print("Register invocation sent.");
    } catch (e) {
      print("SignalR Error: $e");
    }
  }
}
