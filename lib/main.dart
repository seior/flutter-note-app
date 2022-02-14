import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/modules/home/provider/home_model.dart';
import 'package:note_app/modules/note/provider/note_model.dart';
import 'package:note_app/utils/splash_screen.dart';
import 'package:note_app/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'data/models/note.dart';
import 'modules/home/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var appPath = await path.getApplicationDocumentsDirectory();
  Hive.init(appPath.path);

  // register adapter
  Hive.registerAdapter(NoteAdapter());

  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NoteModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeUtils.theme,
        home: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snapshot) => snapshot.connectionState == ConnectionState.done
              ? const HomeScreen()
              : const SplashScreen(),
        ),
      ),
    );
  }
}
