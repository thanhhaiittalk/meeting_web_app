import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/auth_bloc.dart';
import 'package:meeting_web_app/bloc/user_register_bloc.dart';

import '../main/meeting_list_screen.dart';

class RegisterNewUserScreen extends StatefulWidget {
  const RegisterNewUserScreen({super.key});

  @override
  State<RegisterNewUserScreen> createState() => _RegisterNewUserScreenState();
}

class _RegisterNewUserScreenState extends State<RegisterNewUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserRegisterBloc, UserRegisterState>(listener: ((context, state) {
        if (state is UserRegisterSuccess) {
           // Navigating to the dashboard screen if the user is authenticated
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MeetingListScreen()));
        }
      }
      ),
      child: BlocBuilder<UserRegisterBloc,UserRegisterState>(
        builder: (context,state) {
          if(state is RegisterLoading){
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserUnregistered){
            return Center(
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () {
                  // Register new user
                  context.read<UserRegisterBloc>().add(UserRegisterStart());
                },
              ),);
          }
          return Container();
        }
      ),
      ));
    // );
  }
}
