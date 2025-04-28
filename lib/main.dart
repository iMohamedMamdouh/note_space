import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_space/constants.dart';
import 'package:note_space/cubits/read_notes_cubit/read_notes_cubit.dart';
import 'package:note_space/models/note_model.dart';
import 'package:note_space/simple_bloc_observer.dart';
import 'package:note_space/theme.dart';
import 'package:note_space/views/notes_view.dart';
import 'package:note_space/views/signUp_Screen.dart';
import 'package:note_space/views/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);

  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReadNotesCubit(),
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, currentTheme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: currentTheme,
            routes: {
              '/signIn': (context) => const SignIn(),
              '/signUp': (context) => const SignUp(),
              '/home': (context) => const NotesView(),
            },
            initialRoute: '/signIn',
          );
        },
      ),
    );
  }
}
