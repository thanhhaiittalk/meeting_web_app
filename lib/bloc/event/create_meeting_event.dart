part of '../create_meeting_bloc.dart';

abstract class CreateMeetingEvent extends Equatable {
  const CreateMeetingEvent();
  @override
  List<Object> get props => [];
}

class TitleChanged extends CreateMeetingEvent {
  final String title;
  const TitleChanged(this.title);

  @override
  List<Object> get props => [title];
}

class DateChanged extends CreateMeetingEvent {
  final DateTime dateTime;
  const DateChanged(this.dateTime);

  @override 
  List<Object> get props => [dateTime];
}

class UpdateDate extends CreateMeetingEvent {
  @override 
  List<Object> get props => [];
}

class DateCheckValid extends CreateMeetingEvent {
  @override 
  List<Object> get props => [];
}


class TimeChanged extends CreateMeetingEvent {
  final TimeOfDay timeOfDay;
  const TimeChanged(this.timeOfDay);

  @override 
  List<Object> get props => [timeOfDay];
}

class UpdateTime extends CreateMeetingEvent {
  @override 
  List<Object> get props => [];
}

class DurationChanged extends CreateMeetingEvent {
  final int duration;
  const DurationChanged(this.duration);

  @override 
  List<Object> get props => [duration];
}

class DescriptionChanged extends CreateMeetingEvent {
  final String description;
  const DescriptionChanged(this.description);
  
  @override 
  List<Object> get props => [description];
}

class Submit extends CreateMeetingEvent {}

class CheckSubmitValid extends CreateMeetingEvent {}


