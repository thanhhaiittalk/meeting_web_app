import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/create_meeting_bloc.dart';

class MeetingDescriptionWidget extends StatefulWidget {
  const MeetingDescriptionWidget({super.key});

  @override
  State<MeetingDescriptionWidget> createState() => _MeetingDescriptionWidgetState();
}

class _MeetingDescriptionWidgetState extends State<MeetingDescriptionWidget> {

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
      onChanged: (newValue) {
        _tempSaveMeetingDescription(context, newValue);
      },
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: "Meeting Description",
        labelText: "Description",
        contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
      ),
    );
  }

  void _tempSaveMeetingDescription(context,value) {
    BlocProvider.of<CreateMeetingBloc>(context).add(
      DescriptionChanged(value)
    );
  }
}