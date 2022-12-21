
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/create_meeting_bloc.dart';

class MeetingDatePickWidget extends StatefulWidget {
  const MeetingDatePickWidget({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<MeetingDatePickWidget> createState() => _MeetingDatePickWidgetState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _MeetingDatePickWidgetState extends State<MeetingDatePickWidget>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete:(result) {
        _tempSaveDate(context, result);
    },
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime.now(),
          lastDate: DateTime(2050),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _tempSaveDate(context,value) {
    BlocProvider.of<CreateMeetingBloc>(context).add(
      DateChanged(value)
    );
  }

  void _updateDate(context){
    BlocProvider.of<CreateMeetingBloc>(context).add(
      UpdateDate()
    );
  }

  String _datePicked(context) {
    Timestamp? timestamp = BlocProvider.of<CreateMeetingBloc>(context).newMeetingRepository.meetingStartTime;
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp!.millisecondsSinceEpoch);
    return date.toString()  ;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingBloc,CreateMeetingValidate >(
      builder: ((context,state) {
        return Center(
            child: OutlinedButton(
              onPressed: () {
                _updateDate(context);
                _restorableDatePickerRouteFuture.present();
              },
          child: (state.isDatePickValid == ValidState.initial)
              ? const Text('Open Date Picker'): 
              (state.isDatePickValid == ValidState.valid)? Text(_datePicked(context)) : 
              const Text("Date invalid"),
            ),
          );
      }
    ));
  }
}