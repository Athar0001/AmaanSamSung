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

    // Creates the connection by using the HubConnectionBuilder.
    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options: httpOptions)
        .configureLogging(hubProtLogger)
        .build();

    // When the connection is closed, print out a message to the console.
    hubConnection.onclose(({error}) => hubProtLogger.info("Connection Closed"));

    // Calling following method starts handshaking and connects the client to SignalR server
    await hubConnection.start();

    hubConnection.on("Registered", (guid) {
      hubProtLogger.info("Successfully registered with GUID: $guid");
    });

    // Invoke "Register"
    await hubConnection.invoke("Register", args: [guid]);

    // Add AuthCompleted listener
    hubConnection.on("AuthCompleted", (authData) {
      hubProtLogger.info("AuthComplete received: $authData");
    });
  }
}
