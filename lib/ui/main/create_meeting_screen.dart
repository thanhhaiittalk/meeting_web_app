import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/create_meeting_bloc.dart';
import 'package:meeting_web_app/ui/widget/create_meeting_widget/meeting_date_pick_widget.dart';
import 'package:meeting_web_app/ui/widget/create_meeting_widget/meeting_description_widget.dart';
import 'package:meeting_web_app/ui/widget/create_meeting_widget/meeting_duration_widget.dart';
import 'package:meeting_web_app/ui/widget/create_meeting_widget/meeting_submit_button_widget.dart';
import 'package:meeting_web_app/ui/widget/create_meeting_widget/meeting_time_pick_widget.dart';
import 'package:meeting_web_app/ui/widget/create_meeting_widget/meeting_title_widget.dart';

class CreateMeetingScreen extends StatefulWidget {
  const CreateMeetingScreen({super.key});

  @override
  State<CreateMeetingScreen> createState() => _CreateMeetingScreenState();
}

class _CreateMeetingScreenState extends State<CreateMeetingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CreateMeetingBloc,CreateMeetingValidate>(
        builder: ((context,state) {
          return ListView(
            padding: const EdgeInsets.all(8),
            children: const [
              MeetingTileWidget(),
              MeetingDatePickWidget(),
              MeetingTimePickWidget(),
              MeetingDurationWidget(),
              MeetingDescriptionWidget(),
              MeetingSubmitButtonWidget()
            ],
          );
        }
      ),
    ));
  }
}