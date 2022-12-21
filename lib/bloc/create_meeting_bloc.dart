import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meeting_web_app/model/meeting_model.dart';
import 'package:meeting_web_app/repository/database/database_repository.dart';
import 'package:meeting_web_app/repository/meeting/new_meeting_repository.dart';
import 'package:uuid/uuid.dart';

part 'event/create_meeting_event.dart';
part 'state/create_meeting_state.dart';

class CreateMeetingBloc extends Bloc<CreateMeetingEvent, CreateMeetingValidate> {
  final NewMeetingRepository newMeetingRepository;
  final FirestoreDatabaseRepository databaseRepository;
  CreateMeetingBloc({required this.databaseRepository,required this.newMeetingRepository})
      : super(const CreateMeetingValidate(
        isTitleValid: ValidState.initial, 
        isDatePickValid: ValidState.initial,
        isTimePickValid: ValidState.initial, 
        isDescriptionValid: ValidState.initial, 
        isDurationValid: ValidState.initial, 
        isMeetingBeginTimeValid: ValidState.valid,
        isMeetingGuestValid: ValidState.valid, /*TODO: must fix it*/
        submitState: SubmitState.initial)) {
    on<TitleChanged>(_onTitleChanged);
    on<DateChanged>(_onDateChanged);
    on<UpdateDate>(_onUpdateDate);
    on<TimeChanged>(_onTimeChanged);
    on<UpdateTime>(_onUpdateTime);
    on<DurationChanged>(_onDurationChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<Submit>(_onSubmit);
  }

  void _checkSubmitValid(emit){
    if(state.isTitleValid == ValidState.valid &&
      state.isDatePickValid == ValidState.valid &&
      state.isTimePickValid == ValidState.valid &&
      state.isDescriptionValid == ValidState.valid &&
      state.isDurationValid == ValidState.valid && 
      state.isMeetingBeginTimeValid == ValidState.valid &&
      state.isMeetingGuestValid == ValidState.valid 
      ){
        emit(state.copyWith(
          submitState:SubmitState.valid
        ));
      }else{
        emit(state.copyWith(
          submitState:SubmitState.invalid
        ));
        print("Check submit valid - title: ${state.isTitleValid}");
        print("Check submit valid - date: ${state.isDatePickValid}");
        print("Check submit valid - time: ${state.isTimePickValid}");
        print("Check submit valid - Des: ${state.isDescriptionValid}");
        print("Check submit valid - duration: ${state.isDurationValid}");
        print("Check submit valid - begin time: ${state.isMeetingBeginTimeValid}");
        print("Check submit valid - Guest: ${state.isMeetingGuestValid}");

      }
      print("Submit state: ${state.submitState}");
  }

  _onTitleChanged(TitleChanged event, Emitter<CreateMeetingValidate> emit){
    newMeetingRepository.setTitle(event.title);
    emit(state.copyWith(
      isTitleValid: ValidState.valid
    ));
    _checkSubmitValid(emit);
  }

  _onUpdateDate(UpdateDate event, Emitter<CreateMeetingValidate> emit){
    emit(state.copyWith(
      isDatePickValid: ValidState.initial
    ));
  }

  _onDateChanged(DateChanged event, Emitter<CreateMeetingValidate> emit){
    newMeetingRepository.setTempDate(event.dateTime);
    newMeetingRepository.setMeetingBeginTime();
    emit(state.copyWith(
      isDatePickValid: ValidState.valid
    ));
    _checkSubmitValid(emit);
  }

  _onUpdateTime(UpdateTime event, Emitter<CreateMeetingValidate> emit){
    emit(state.copyWith(
      isTimePickValid: ValidState.initial
    ));
  }

  _onTimeChanged(TimeChanged event, Emitter<CreateMeetingValidate> emit){
    newMeetingRepository.setTempTime(event.timeOfDay);
    newMeetingRepository.setMeetingBeginTime();
    newMeetingRepository.setMeetingEndTime();
    emit(state.copyWith(
      isTimePickValid: ValidState.valid
    ));
    _checkSubmitValid(emit);
  }

  _onDurationChanged(DurationChanged event, Emitter<CreateMeetingValidate> emit){
    if(event.duration > 0){
      newMeetingRepository.setDuration(event.duration);
      newMeetingRepository.setMeetingEndTime();
      emit(state.copyWith(
        isDurationValid: ValidState.valid,
      ));
      _checkSubmitValid(emit);
    }else {
      emit(state.copyWith(
        isDurationValid: ValidState.invalid,
      ));
    }

  }

  _onDescriptionChanged(DescriptionChanged event, Emitter<CreateMeetingValidate> emit){
    newMeetingRepository.setDescription(event.description);
    emit(state.copyWith(
      isDescriptionValid: ValidState.valid,
    ));
    _checkSubmitValid(emit);
  }

  _onSubmit(Submit event, Emitter<CreateMeetingValidate> emit) async {
    emit(state.copyWith(
      submitState: SubmitState.loading,
    ));
    var uuid = const Uuid();
    final user = FirebaseAuth.instance.currentUser!;
    newMeetingRepository.setMeetingID(uuid.v4());
    newMeetingRepository.setHost(user);
    /*TODO: need to implement search guest, this is just temporary*/
    newMeetingRepository.setGuest(user);
    
    try {
      MeetingModel meeting = MeetingModel(         
        meetingID: newMeetingRepository.meetingID, 
        title: newMeetingRepository.title, 
        meetingStartTime: newMeetingRepository.meetingStartTime, 
        meetingEndTime: newMeetingRepository.meetingEndTime, 
        duration: newMeetingRepository.duration, 
        hostID: newMeetingRepository.host?.uid, 
        hostDisplayName: newMeetingRepository.host?.displayName, 
        hostEmail: newMeetingRepository.guest?.email, 
        guestID: newMeetingRepository.guest?.uid, 
        guestDisplayName: newMeetingRepository.guest?.displayName, 
        guestEmail: newMeetingRepository.guest?.email, 
        description: newMeetingRepository.description);
      await databaseRepository.createMeeting(meeting);
      emit(state.copyWith(
        isTitleValid: ValidState.initial, 
        isDatePickValid: ValidState.initial,
        isTimePickValid: ValidState.initial, 
        isDescriptionValid: ValidState.initial, 
        isDurationValid: ValidState.initial, 
        isMeetingBeginTimeValid: ValidState.initial,
        submitState: SubmitState.complete
      ));
    } catch(e){
      print(e);
      emit(state.copyWith(
        submitState: SubmitState.error
      ));
    }
  }
}
