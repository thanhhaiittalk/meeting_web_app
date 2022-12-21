import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/create_meeting_bloc.dart';

class MeetingTileWidget extends StatefulWidget {
  const MeetingTileWidget({super.key});

  @override
  State<MeetingTileWidget> createState() => _MeetingTileWidgetState();
}

class _MeetingTileWidgetState extends State<MeetingTileWidget> {

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
        _tempSaveMeetingTitle(context, newValue);
      },
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: "Meeting title",
        labelText: "Title",
        contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
      ),
    );
  }

  void _tempSaveMeetingTitle(context,value) {
    BlocProvider.of<CreateMeetingBloc>(context).add(
      TitleChanged(value)
    );
  }
}