//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/services.dart';
//import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme( bodyMedium: TextStyle(fontFamily: 'GoogleSansCode'), bodyLarge: TextStyle(fontFamily: 'GoogleSansCode'), bodySmall: TextStyle(fontFamily: 'GoogleSansCode'), titleMedium: TextStyle(fontFamily: 'GoogleSansCode'), headlineMedium: TextStyle(fontFamily: 'GoogleSansCode'), ),

        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          surface: Colors.grey[200]!,
          onSurface: Colors.black,
          //secondaryContainer: Colors.white,
          primaryContainer: Colors.white,
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          onPrimary: Colors.white
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          elevation: 0, 
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      //darkTheme: ThemeData.dark().copyWith(
      //  colorScheme: ColorScheme.fromSeed(
      //    seedColor: Colors.black,
      //    surface: Colors.grey[800]!,
      //    onSurface: Colors.white,
      //    //secondaryContainer: Colors.black,
      //    //primaryContainer: Colors.black,
      //    brightness: Brightness.dark,
      //    surfaceContainer: Colors.black,
      //    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
      //  ),
      //),
      
      home: const MyHomePage(title: 'TSIN 2026'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
const double radiSquare = 20.0;
const double radiRound = 800.0;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        //backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        titleTextStyle: TextStyle(
          fontFamily: 'GoogleSansCode',
          fontSize: 20,
          fontWeight: FontWeight.w100,
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset( 'lib/assets/image.png', height: 200, width: 600, ),
              
              //Image.network(
              //  'https://raw.githubusercontent.com/Cactus500/flutter_serre_tsin/refs/heads/main/flutter_serre_tsin/lib/assets/image.png',
              //  height: 200,
              //  width: 600,
              //),
              Text(
                'SERRE',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  fontFamily: 'GoogleSansCode',
                ),
              ),
              const Text('Haytam Thérence Tite Projet Serre'),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(radiRound),
                    ),
                    child: const Center(child: Icon(Icons.surfing, size: 48,)), // Icon representing "Item 1"
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(radiSquare),
                    ),
                    child: const Center(child: Icon(Icons.water_outlined, size: 48)), // Icon representing "Item 2"
                  ),
                   Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(radiSquare),
                    ),
                    child: Center(child: Icon(Icons.icecream_outlined, size:48, color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                   Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(radiSquare),
                    ),
                    child: Center(child: Text('HUMIDITÉ DE \nL\'AIR', textAlign: TextAlign.center,)),
                  ),
                   Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(radiSquare),
                    ),
                    child: const Center(child: Text('TROP COOL', textAlign: TextAlign.center)),
                  ),
                   Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(radiSquare),
                      
                    ),
                    child: Padding(
                      padding : const EdgeInsets.all(16.0),
                      child:
                        Column(
                          
                          children: [
                            Expanded(child:
                              const TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nom Plante',

                                ),
                                maxLines: 5,

                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 8),
                            FilledButton.icon(
                              onPressed: DoNothingAction.new, 
                              icon: const Icon(Icons.arrow_circle_up),
                              label: const Text('Envoyer'),
                              style: 
                                FilledButton.styleFrom(
                                  minimumSize: const Size.fromHeight(60),
                                )
                              
                            ),
                          ]
                        ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
