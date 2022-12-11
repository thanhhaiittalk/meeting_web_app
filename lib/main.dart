
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/auth_bloc.dart';
import 'package:meeting_web_app/repository/auth/auth_repository.dart';
import 'package:meeting_web_app/ui/main/meeting_list_screen.dart';
import 'package:meeting_web_app/ui/onboard/sign_in_screen.dart';
import 'package:meeting_web_app/utils/firebase/firebase_initializer.dart';

Future<void> main () async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FirebaseInitializer(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context),),
        child: MaterialApp(
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData){
                return const MeetingListScreen();
              }
              return const SignInScreen();
            },
            ),
        ),
        ),
      );
  }
}