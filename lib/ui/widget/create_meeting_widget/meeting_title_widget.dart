import 'package:flutter/foundation.dart';
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

  var titleTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingBloc, CreateMeetingValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) {
            _tempSaveMeetingTitle(context, value);
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Meeting title",
            labelText: "Title",
            errorText: state.isTitleValid == ValidState.invalid
                ? "Please enter title"
                : null,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          ),
        );
      },
    );
  }

  void _tempSaveMeetingTitle(context, value) {
    BlocProvider.of<CreateMeetingBloc>(context).add(TitleChanged(value));
  }
}
