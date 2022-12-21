import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/create_meeting_bloc.dart';

class MeetingDurationWidget extends StatefulWidget {
  const MeetingDurationWidget({super.key});

  @override
  State<MeetingDurationWidget> createState() => _MeetingDurationWidgetState();
}

class _MeetingDurationWidgetState extends State<MeetingDurationWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (newValue) {
        _tempSaveMeetingDuration(context, int.parse(newValue));
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: "Meeting Duration",
        labelText: "Duration",
        contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
      ),
    );
  }

  void _tempSaveMeetingDuration(context,value) {
    BlocProvider.of<CreateMeetingBloc>(context).add(
      DurationChanged(value)
    );
  }
}