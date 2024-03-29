import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:webrtc_tutorial/routes/app_route_config.dart';
import 'package:webrtc_tutorial/signaling.dart';
import 'package:webrtc_tutorial/test.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: GoRouterConfig.router.routeInformationParser,
      routerDelegate: GoRouterConfig.router.routerDelegate,
      routeInformationProvider: GoRouterConfig.router.routeInformationProvider,
      
      debugShowCheckedModeBanner: false
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.id}) : super(key: key);
  String id;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
    
    super.initState();
    textEditingController.text=widget.id;
    roomId=widget.id;
    Future.delayed(Duration.zero).then((value) {
       signaling.joinRoom(
                      textEditingController.text.trim(),
                      _remoteRenderer,
                    );
    }).then((value) => setState(() {
                      print("heklo");
                    },));
    
  }

  

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("room Id is");
    print(widget.id);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Welcome to Flutter Explained - WebRTC"),
      // ),
      body: Column(
        children: [
          // SizedBox(height: 8),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       // ElevatedButton(
          //       //   onPressed: () {
          //       //     signaling.openUserMedia(_localRenderer, _remoteRenderer);
          //       //   },
          //       //   child: Text("Open camera & microphone"),
          //       // ),
          //       // SizedBox(
          //       //   width: 8,
          //       // ),
          //       // ElevatedButton(
          //       //   onPressed: () async {
          //       //     roomId = await signaling.createRoom(_remoteRenderer);
          //       //     textEditingController.text = roomId!;
          //       //     setState(() {});
          //       //   },
          //       //   child: Text("Create room"),
          //       // ),
          //       // SizedBox(
          //       //   width: 8,
          //       // ),
          //       ElevatedButton(
          //         onPressed: () {
          //           // Add roomId
          //           signaling.joinRoom(
          //             textEditingController.text.trim(),
          //             _remoteRenderer,
          //           );
          //         },
          //         child: Text("Join room"),
          //       ),
          //       SizedBox(
          //         width: 8,
          //       ),
          //       ElevatedButton(
          //         onPressed: () {
          //           signaling.hangUp(_localRenderer);
          //         },
          //         child: Text("Hangup"),
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
                  Expanded(child: RTCVideoView(_remoteRenderer)),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("Join the following Room: "),
          //       Flexible(
          //         child: TextFormField(
          //           controller: textEditingController,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(height: 8)
        ],
      ),
    );
  }
}
