import 'package:flutter/material.dart';
import 'package:wato_plug/wato_plug.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wato Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("For Towards WhatsApp"),
              IconButton(
                onPressed: () {
                  toWhatsApp();
                },
                icon: const Icon(Icons.send),
              ),
              const Text("For Checking WhatsApp Business is Installed"),
              IconButton(
                onPressed: () {
                  isInstalled();
                },
                icon: const Icon(Icons.question_mark_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toWhatsApp() async {
    await WatoPlug.messageToWhatsApp(
      number: "911234567890", //-> Whatsapp Number With Country Code
      package: 0, //-> 0 for WhatsApp & 1 for WhatsApp Business
      message: "Your Message Here",
      link: "https://imalpha.co.in/",
    );
  }

  void isInstalled() async {
    await WatoPlug.isWhatsAppBusinessInstalled();
  }
}
