part of '../create_meeting_bloc.dart';

enum ValidState{
  initial,
  valid,
  invalid,
}

enum SubmitState{
  initial,
  loading,
  valid,
  invalid,
  error,
  complete,
}

abstract class CreateMeetingState extends Equatable {
  const CreateMeetingState();
}

class CreateMeetingInitial extends CreateMeetingState {
   @override
  List<Object?> get props => [];
}

class CreateMeetingLoading extends CreateMeetingState {
   @override
  List<Object?> get props => [];
}

class CreateMeetingValidate extends CreateMeetingState {
  const CreateMeetingValidate({
    required this.isTitleValid,
    required this.isDatePickValid,
    required this.isTimePickValid,
    required this.isDescriptionValid,
    required this.isDurationValid,
    required this.isMeetingBeginTimeValid,
    required this.isMeetingGuestValid,
    required this.submitState,
  });
  final ValidState isTitleValid;
  final ValidState isDatePickValid;
  final ValidState isTimePickValid;
  final ValidState isMeetingBeginTimeValid;
  final ValidState isDurationValid;
  final ValidState isDescriptionValid;
  final ValidState isMeetingGuestValid;
  final SubmitState submitState;
  CreateMeetingValidate copyWith({
    ValidState? isTitleValid,
    ValidState? isDatePickValid,
    ValidState? isTimePickValid,
    ValidState? isMeetingBeginTimeValid,
    ValidState? isDescriptionValid,
    ValidState? isDurationValid,
    ValidState? isMeetingGuestValid,
    SubmitState? submitState,
  }) {
    return CreateMeetingValidate(
        isTitleValid: isTitleValid ?? this.isTitleValid,
        isDatePickValid: isDatePickValid ?? this.isDatePickValid,
        isTimePickValid: isTimePickValid ?? this.isTimePickValid,
        isDescriptionValid: isDescriptionValid ?? this.isDescriptionValid,
        isDurationValid: isDurationValid ?? this.isDurationValid,
        isMeetingBeginTimeValid:
            isMeetingBeginTimeValid ?? this.isMeetingBeginTimeValid,
        isMeetingGuestValid: 
            isMeetingGuestValid ?? this.isMeetingGuestValid,
        submitState: submitState ?? this.submitState);
        
  }
   @override
  List<Object?> get props => [
    isTitleValid,
    isDatePickValid,
    isTimePickValid,
    isMeetingBeginTimeValid,
    isDurationValid,
    isDescriptionValid,
    isMeetingGuestValid,
    submitState,
  ];
}
