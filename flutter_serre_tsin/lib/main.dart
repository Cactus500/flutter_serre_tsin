import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//format csv : Nom de la plante,Temperature de l air (C),Humidite de l air (%),Temperature du sol (C),Humidite du sol (%),Marge (+/-)

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
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'GoogleSansCode'),
          bodyLarge: TextStyle(fontFamily: 'GoogleSansCode'),
          bodySmall: TextStyle(fontFamily: 'GoogleSansCode'),
          titleMedium: TextStyle(fontFamily: 'GoogleSansCode'),
          headlineMedium: TextStyle(fontFamily: 'GoogleSansCode'),
        ),

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
          onPrimary: Colors.white,
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
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
      home: MyHomePage(title: '(⌐■_■) TSIN 2026 ', storage: Stockage()),
    );
  }
}

/// Classe utilitaire pour stocker/charger la clé API en local.
///
/// Utilisation générale :
/// - Pour lire la clé :
///   - avec `await` (dans une fonction `async`):
///     ```dart
///     final key = await storage.lireclef();
///     ```
///   - avec `then` (pas `async` disponible, p.ex. dans `initState`):
///     ```dart
///     storage.lireclef().then((key) { setState(() => _pommedapi = key); });
///     ```
/// - Pour écrire la clé :
///   - avec `await`:
///     ```dart
///     await storage.ecrireclef('ma-cle-api-123');
///     ```
///   - ou en chainant `.then` si besoin.
///
/// Gestion d'erreurs : encapsulez l'appel `await` dans un `try/catch`
/// ou utilisez `.catchError(...)` sur la `Future` retournée.
class Stockage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _placeDeRangementPommedapi async {
    final path = await _localPath;
    return File('$path/pommedapi.txt');
  }

  Future<File> get _placeDeRangementPommedereinette async {
    final path = await _localPath;
    return File('$path/pommedereinette.txt');
  }

  Future<File> get _AH async {
    final path = await _localPath;
    return File('$path/ah.txt');
  }
  Future<File> get _AT async {
    final path = await _localPath;
    return File('$path/at.txt');
  }
  Future<File> get _SH async {
    final path = await _localPath;
    return File('$path/sh.txt');
  }
  Future<File> get _ST async {
    final path = await _localPath;
    return File('$path/st.txt');
  }
  Future<File> get _RV async {
    final path = await _localPath;
    return File('$path/rv.txt');
  }
  Future<File> get _PR async {
    final path = await _localPath;
    return File('$path/pr.txt');
  }
  Future<File> get _NO async {
    final path = await _localPath;
    return File('$path/no.txt');
  }


  /// Lit la clé API depuis le fichier local et renvoie une `Future<String>`.
  ///
  /// Retourne une chaîne vide si le fichier n'existe pas ou en cas d'erreur.
  /// Exemple d'usage :
  /// ```dart
  /// final key = await storage.lireclef();
  /// ```
  Future<String> lireclef(String type) async {
    try {
      if (type == 'lecture') {
        final file = await _placeDeRangementPommedapi;

        // Read the file as a string (API key saved as text)
        final contents = await file.readAsString();

        return contents;
      } else if (type == 'ecriture') {
        final file = await _placeDeRangementPommedereinette;

        // Read the file as a string (API key saved as text)
        final contents = await file.readAsString();
        return contents;
      } else {
        return 'Erreur 🫖';
      }
    } catch (e) {
      // If encountering an error (no file / unreadable), return empty string
      return '';
    }
  }

  /// Écrit la clé API (chaîne) dans le fichier local et renvoie la `Future<File>`
  /// correspondant à l'opération d'écriture.
  ///
  /// Exemple d'usage :
  /// ```dart
  /// await storage.ecrireclef('ma-cle-api-123');
  /// // ou
  /// storage.ecrireclef('ma-cle-api-123').then((file) { /* écrit */ });
  /// ```
  Future<File> ecrireclef(String clef, String type) async {
    if (type == 'lecture') {
      final file = await _placeDeRangementPommedapi;
      return file.writeAsString(clef);
    } else if (type == 'ecriture') {
      final file = await _placeDeRangementPommedereinette;
      return file.writeAsString(clef);
    } else {
      throw ArgumentError('Type de clé API inconnu : $type');
    }
    // Write the API key string to the file
  }

  Future<String> liredata(String data, String place) async {
    if (place == 'ah') {
      final file = await _AH;
      final contents = await file.readAsString();
      return contents;
    } else if (place == 'at') {
      final file = await _AT;
      final contents = await file.readAsString();
      return contents;
    } else if (place == 'sh') {
      final file = await _SH;
      final contents = await file.readAsString();
      return contents;
    } else if (place == 'st') {
      final file = await _ST;
      final contents = await file.readAsString();
      return contents;
    } else if (place == 'rv') {
      final file = await _RV;
      final contents = await file.readAsString();
      return contents;
    } else if (place == 'pr') {
      final file = await _PR;
      final contents = await file.readAsString();
      return contents;
    } else {
      final file = await _NO;
      final contents = await file.readAsString();
      return contents;
    }
  }

  Future<File> ecriredata(String data, String place) async {
    if (place == 'ah') {
      final file = await _AH;
      return file.writeAsString(data);
    } else if (place == 'at') {
      final file = await _AT;
      return file.writeAsString(data);
    } else if (place == 'sh') {
      final file = await _SH;
      return file.writeAsString(data);
    } else if (place == 'st') {
      final file = await _ST;
      return file.writeAsString(data);
    } else if (place == 'rv') {
      final file = await _RV;
      return file.writeAsString(data);
    } else if (place == 'pr') {
      final file = await _PR;
      return file.writeAsString(data);
    } else {
      final file = await _NO;
      return file.writeAsString(data);
    }
  }

}

//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse(
      'https://api.thingspeak.com/channels/3260066/fields/7.json?results=2',
    ),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final album = Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    
    // Write the fetched data to text files for caching
    final storage = Stockage();
    await storage.ecriredata(album.airHum, 'ah');
    await storage.ecriredata(album.airTemp, 'at');
    await storage.ecriredata(album.solHum, 'sh');
    await storage.ecriredata(album.solTemp, 'st');
    await storage.ecriredata(album.reservoirVol, 'rv');
    
    return album;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

/// Reads sensor data from cached text files instead of fetching from ThingSpeak
Future<Album> fetchAlbumFromCache() async {
  try {
    final storage = Stockage();
    
    // Read all sensor values from text files
    final airHum = await storage.liredata('data', 'ah');
    final airTemp = await storage.liredata('data', 'at');
    final solHum = await storage.liredata('data', 'sh');
    final solTemp = await storage.liredata('data', 'st');
    final reservoirVol = await storage.liredata('data', 'rv');
    
    return Album(
      airHum: airHum.trim().isEmpty ? '0' : airHum.trim(),
      airTemp: airTemp.trim().isEmpty ? '0' : airTemp.trim(),
      solHum: solHum.trim().isEmpty ? '0' : solHum.trim(),
      solTemp: solTemp.trim().isEmpty ? '0' : solTemp.trim(),
      reservoirVol: reservoirVol.trim().isEmpty ? '0' : reservoirVol.trim(),
    );
  } catch (e) {
    throw Exception('Failed to load cached album: $e');
  }
}

Future<void> _sendToThingSpeak(
  String apiKey,
  Album data,
  String field6Value,
  String field7Value,
) async {
  await http.post(
    Uri.parse(
      'https://api.thingspeak.com/update?api_key=$apiKey'
      '&field1=${data.airHum}'
      '&field2=${data.airTemp}'
      '&field3=${data.solHum}'
      '&field4=${data.solTemp}'
      '&field5=${data.reservoirVol}'
      '&field6=$field6Value'
      '&field7=$field7Value',
    ),
  );
}

Future<void> nomPlante(String nomplante) async {
  final pom = await Stockage().lireclef('ecriture');
  if (pom.isEmpty) return;
  
  final latest = await fetchAlbum();
  final prefs = await prefplante(nomplante);
  
  await _sendToThingSpeak(
    pom,
    latest,
    prefs ?? 'non trouvé',
    nomplante,
  );
}

Future<String?> prefplante(String nomdonne) async {
  final pom = await Stockage().lireclef('ecriture');
  if (pom.isEmpty) return null;
  final latest = await fetchAlbum();

  final rawCsv = await rootBundle.loadString('lib/plantes.csv');
  final query = nomdonne.trim().toLowerCase();
  final lines = rawCsv
      .split(RegExp(r"\r?\n"))
      .where((l) => l.trim().isNotEmpty)
      .toList();

  for (var line in lines) {
    final cols = line.split(',');
    if (cols.length < 2) continue;

    final nom = cols[0].trim().toLowerCase();
    final prefs = cols[1].trim();

    if (nom == query) {
      await _sendToThingSpeak(
        pom,
        latest,
        prefs,
        nom,
      );
      return prefs;
    }
  }

  return null;
}

int levenshtein(String s, String t) {
  int m = s.length;
  int n = t.length;

  List<List<int>> dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));

  for (int i = 0; i <= m; i++) {
    dp[i][0] = i;
  }
  for (int j = 0; j <= n; j++) {
    dp[0][j] = j;
  }

  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      int cost = (s[i - 1] == t[j - 1]) ? 0 : 1;

      dp[i][j] = [
        dp[i - 1][j] + 1, // suppression
        dp[i][j - 1] + 1, // insertion
        dp[i - 1][j - 1] + cost, // remplacement
      ].reduce((a, b) => a < b ? a : b);
    }
  }

  return dp[m][n];
}

Future<String?> autocorrect(String fkro) async {
  int threshold = 2;

  final rawCsv = await rootBundle.loadString('lib/plantes.csv');
  final query = fkro.trim().toLowerCase();

  final lines = rawCsv
      .split(RegExp(r"\r?\n"))
      .where((l) => l.trim().isNotEmpty)
      .toList();

  for (var line in lines) {
    final cols = line.split(',');
    if (cols.isEmpty) continue;
    final name = cols[0].trim();

    if (levenshtein(name.toLowerCase(), query) <= threshold) {
      return name;
    }
  }

  return null;
}

class Album {
  final String airHum;
  final String airTemp;
  final String solHum;
  final String solTemp;
  final String reservoirVol;

  const Album({
    required this.airHum,
    required this.airTemp,
    required this.solHum,
    required this.solTemp,
    required this.reservoirVol,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    try {
      final feeds = json['feeds'] as List<dynamic>;
      if (feeds.isEmpty) {
        throw const FormatException('Feeds array is empty');
      }
      
      final lastFeed = feeds[1] as Map<String, dynamic>;
      
      return Album(
        airHum: lastFeed['field1']?.toString() ?? '0',
        airTemp: lastFeed['field2']?.toString() ?? '0',
        solHum: lastFeed['field3']?.toString() ?? '0',
        solTemp: lastFeed['field4']?.toString() ?? '0',
        reservoirVol: lastFeed['field5']?.toString() ?? '0',
      );
    } catch (e) {
      throw FormatException('Pas reussi a piquer les infos de la serre 😒: $e');
    }
  }
}

//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.storage});
  final Stockage storage;
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
//var _formKey = GlobalKey<FormState>();

class _MyHomePageState extends State<MyHomePage> {
  String _pommedapi = '';
  String _pommedereinette = '';
  String _selectedPlantName = '';
  String _selectedPlantPref = '';

  /// Exemple : charger la clé dans `initState` (pattern recommandé)
  ///
  /// Remarques :
  /// - `initState()` ne peut pas être `async`. Si vous voulez utiliser `await`,
  ///   créez une méthode `async` séparée et appelez-la depuis `initState()` :
  ///
  /// ```dart
  /// @override
  /// void initState() {
  ///   super.initState();
  ///   _loadKey(); // méthode async séparée
  /// }
  ///
  /// Future<void> _loadKey() async {
  ///   try {
  ///     final key = await widget.storage.lireclef();
  ///     setState(() => _pommedapi = key);
  ///   } catch (e) {
  ///     // gérer l'erreur (afficher un message, garder une valeur par défaut, ...)
  ///   }
  /// }
  ///
  /// Alternativement, utilisez `.then(...)` directement si vous préférez ne pas
  /// créer une méthode `async` :
  /// ```dart
  /// widget.storage.lireclef().then((value) { setState(() => _pommedapi = value); });
  /// ```

  @override
  void initState() {
    super.initState();
    widget.storage.lireclef('lecture').then((value) {
      setState(() {
        _pommedapi = value;
      });
    });
    widget.storage.lireclef('ecriture').then((value) {
      setState(() {
        _pommedereinette = value;
      });
    });
  }

  Future<File> ecrireclef(String clef, String type) {
    if (type == 'lecture') {
      setState(() {
        _pommedapi = clef;
      });
      // Write the variable as a string to the file.
      return widget.storage.ecrireclef(_pommedapi, 'lecture');
    } else if (type == 'ecriture') {
      setState(() {
        _pommedereinette = clef;
      });
      // Write the variable as a string to the file.
      return widget.storage.ecrireclef(_pommedereinette, 'ecriture');
    } else {
      throw 'arrete de faire nimportequoi';
    }
  }

  /// Refresh function that fetches fresh data from ThingSpeak and caches it
  Future<void> _onRefresh() async {
    try {
      await fetchAlbum();
      // Force rebuild of the widget to display updated cached data
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la mise à jour: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        child: RefreshIndicator(
          onRefresh: _onRefresh,
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
              SizedBox(height: 64),
              Image.asset('lib/assets/image.png', height: 200, width: 600),

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
              Padding(
                padding: EdgeInsets.all(radiSquare),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: _pommedapi.isEmpty
                              ? 'clé API lecture'
                              : _pommedapi,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radiSquare),
                          ),
                        ),
                        // Ne pas effectuer d'opérations d'écriture dans le validateur.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer une clé API valide';
                          }
                          return null;
                        },
                        // Enregistrer la clé lorsque l'utilisateur soumet le champ (Enter)
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            ecrireclef(value, 'lecture');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Clé READ enregistrée'),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16), // Espacement entre les champs
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: _pommedereinette.isEmpty
                              ? 'clé API écriture'
                              : _pommedereinette,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radiSquare),
                          ),
                        ),
                        // Ne pas effectuer d'opérations d'écriture dans le validateur.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer une clé API valide';
                          }
                          return null;
                        },
                        // Enregistrer la clé lorsque l'utilisateur soumet le champ (Enter)
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            ecrireclef(value, 'ecriture');

                            //envoie les infos a la fonction qui va appeler
                            //la classe stockage pour pommedereinette
                            //(clef ecriture)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Clé WRITE enregistrée'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
                    child: FutureBuilder<Album>(
                      future: fetchAlbumFromCache(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'AirHum',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'GoogleSansCode',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                //Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.grass_rounded, size: 48,), Icon(Icons.water_rounded, size: 48,)],),
                                Text(
                                  '${snapshot.data!.airHum}%',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'GoogleSansCode',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(radiSquare),
                    ),
                    child: FutureBuilder<Album>(
                      future: fetchAlbumFromCache(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.water, size: 48),
                                //Text('Il reste', style: TextStyle(fontSize: 16, fontFamily: 'GoogleSansCode',),),
                                Text(
                                  '${snapshot.data!.reservoirVol}L',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'GoogleSansCode',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Text('dans le réservoir.', style: TextStyle(fontSize: 16, fontFamily: 'GoogleSansCode',),),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color:
                          Colors.white, //Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(radiSquare),
                    ),
                    child: FutureBuilder<Album>(
                      future: fetchAlbumFromCache(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SolHum',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'GoogleSansCode',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                //Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.grass_rounded, size: 48,), Icon(Icons.water_rounded, size: 48,)],),
                                Text(
                                  '${snapshot.data!.solHum}%',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'GoogleSansCode',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(radiSquare),
                    ),
                    child: FutureBuilder<Album>(
                      future: fetchAlbumFromCache(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.cloud_circle, size: 48,), Icon(Icons.device_thermostat_rounded, size: 48,)],),
                                Text(
                                  'AirTemp',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'GoogleSansCode',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${snapshot.data!.airTemp}°C',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'GoogleSansCode',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(radiSquare),
                    ),
                    child: FutureBuilder<Album>(
                      future: fetchAlbumFromCache(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SolTemp',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'GoogleSansCode',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                //Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.grass_rounded, size: 48,), Icon(Icons.water_rounded, size: 48,)],),
                                Text(
                                  '${snapshot.data!.solTemp}°C',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'GoogleSansCode',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(radiSquare),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nom Plante',
                              ),
                              onFieldSubmitted: (value) async {
                                final messenger = ScaffoldMessenger.of(context);
                                final correctedName =
                                    await autocorrect(value) ?? value;

                                await nomPlante(correctedName);

                                final prefs =
                                    await prefplante(correctedName) ??
                                    'non trouvé';

                                if (!mounted) return;

                                setState(() {
                                  _selectedPlantName = correctedName;
                                  _selectedPlantPref = prefs;
                                });

                                messenger.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Nom de la plante enregistré : $correctedName, PrEfS : $prefs',
                                    ),
                                  ),
                                );
                              },
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 8),
                          Text(
                            _selectedPlantName.isEmpty
                                ? 'Aucune plante sélectionnée'
                                : 'Plante: $_selectedPlantName - Préf: $_selectedPlantPref',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'GoogleSansCode',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
