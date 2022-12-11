import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/auth_bloc.dart';
import 'package:meeting_web_app/ui/main/meeting_list_screen.dart';
import 'package:meeting_web_app/ui/onboard/register_new_user_screen.dart';
import 'package:meeting_web_app/ui/widget/google_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc,AuthState>(
        listener:((context, state) {
          if (state is Authenticated){
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MeetingListScreen()));
          }
          if (state is AuthNewUser) {
            Navigator.pushReplacement(context, 
            MaterialPageRoute(builder: (context)=> const RegisterNewUserScreen()));
          } 
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        }),
        child: BlocBuilder<AuthBloc,AuthState>(
          builder: ((context, state) {
            if (state is Loading){
              return Center(child: CircularProgressIndicator());
            }
            if (state is UnAuthenticated){
              return Center(
                child: GoogleSignInButton(),
              );
            }
            return Container();
          }),
        ), 
        ),
    );
  }
}