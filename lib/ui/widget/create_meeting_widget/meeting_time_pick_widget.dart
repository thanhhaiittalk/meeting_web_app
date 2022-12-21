import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/create_meeting_bloc.dart';

class MeetingTimePickWidget extends StatefulWidget {
  const MeetingTimePickWidget({super.key});

  @override
  _MeetingDateState createState() => _MeetingDateState();
}

class _MeetingDateState extends State<MeetingTimePickWidget> {
  TimeOfDay _time = TimeOfDay.now();

  Future<void> _selectTime(context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      
    );
    if (newTime != null) {
      _time = newTime;
      BlocProvider.of<CreateMeetingBloc>(context).add(
        TimeChanged(newTime)
      );
    }
    print("Complete select time");
  }

  void _updateTime(context) {
    print("Update time");
    BlocProvider.of<CreateMeetingBloc>(context).add(
      UpdateTime()
    );
  }

  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingBloc,CreateMeetingValidate>(
      builder: ((context,state) {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (() async{
                      _updateTime(context);
                      _selectTime(context);
                    }),
                    child: (state.isTimePickValid == ValidState.initial)?
                    const Text('Time Picker'): 
                    (state.isTimePickValid == ValidState.valid)? Text(_time.toString()): 
                    const Text("Time invalid"),
                  ),
                  SizedBox(height: 8),
                 
                ],
              ),
        );
      }
    ));
  }
}
