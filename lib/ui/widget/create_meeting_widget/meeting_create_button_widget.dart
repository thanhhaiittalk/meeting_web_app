import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/create_meeting_bloc.dart';
import 'package:meeting_web_app/ui/main/create_meeting_screen.dart';

class CreateMeetingButtonWidget extends StatelessWidget {
  const CreateMeetingButtonWidget({super.key});

  void _checkSubmitValid(context){
    BlocProvider.of<CreateMeetingBloc>(context).add(
     CheckSubmitValid()
    );
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text('Create new meeting'),
        onPressed: () {
          _checkSubmitValid(context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const CreateMeetingScreen()),
              (route) => false);
        });
  }
}
