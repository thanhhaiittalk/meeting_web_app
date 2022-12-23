import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/auth_bloc.dart';
import 'package:meeting_web_app/ui/main/create_meeting_screen.dart';
import 'package:meeting_web_app/ui/onboard/sign_in_screen.dart';
import 'package:meeting_web_app/ui/widget/create_meeting_widget/meeting_create_button_widget.dart';

class MeetingListScreen extends StatefulWidget {
  const MeetingListScreen({super.key});

  @override
  State<MeetingListScreen> createState() => _MeetingListScreenState();
}

class _MeetingListScreenState extends State<MeetingListScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(listener: ((context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false);
        }
      }
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Email: \n ${user.email}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              user.photoURL != null
                  ? Image.network("${user.photoURL}")
                  : Container(),
              user.displayName != null
                  ? Text("${user.displayName}")
                  : Container(),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Sign Out'),
                onPressed: () {
                  // Signing out the user
                  context.read<AuthBloc>().add(SignOutRequested());
                },
              ),
              const SizedBox(height: 16),
              const CreateMeetingButtonWidget(),
          ],
        ),
      ),
      ),
    );
  }
}
