import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return BlocBuilder<CreateMeetingBloc, CreateMeetingValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (newValue) {
            if(newValue.isEmpty){
              _tempSaveMeetingDuration(context, -1); // force state invalid
              return;
            }
            _tempSaveMeetingDuration(context, int.parse(newValue));
          },
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorText:
                state.isDurationValid == ValidState.invalid 
                    ? "Please ensure enter valid number"
                    : null,
            hintText: "Please enter duration in minutes - only accept integer number",
            labelText: "Duration",
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          ),
        );
      },
    );
  }

  void _tempSaveMeetingDuration(context, value) {
    BlocProvider.of<CreateMeetingBloc>(context).add(DurationChanged(value));
  }
}
