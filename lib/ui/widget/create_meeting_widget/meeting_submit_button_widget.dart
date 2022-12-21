import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_web_app/bloc/create_meeting_bloc.dart';
import 'package:meeting_web_app/ui/main/meeting_list_screen.dart';

class MeetingSubmitButtonWidget extends StatelessWidget {
  const MeetingSubmitButtonWidget({super.key});
  void _submitMeeting(context){
    BlocProvider.of<CreateMeetingBloc>(context).add(
      Submit()
    );
  }

  bool _checkSubmitValid(state){
    if(state.isTitleValid == ValidState.valid &&
      state.isDatePickValid == ValidState.valid &&
      state.isTimePickValid == ValidState.valid &&
      state.isDescriptionValid == ValidState.valid &&
      state.isDurationValid == ValidState.valid && 
      state.isMeetingBeginTimeValid == ValidState.valid &&
      state.isMeetingGuestValid == ValidState.valid 
      ){
        return true;
      }else{
        print("title : ${state.isTitleValid}");
        
        return false;
      }
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateMeetingBloc, CreateMeetingValidate>(
      listener: (context, state) {
        if(state.submitState == SubmitState.complete){
          Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MeetingListScreen()));
        }

        if(state.submitState == SubmitState.error){
         print("submit error");
        }
      },
      child: BlocBuilder<CreateMeetingBloc, CreateMeetingValidate>(
        builder: ((context, state) {
          if(state.submitState == SubmitState.initial){
            return const Center(
              child: ElevatedButton(
            onPressed: null,
            child: Text('Submit'),
          ));
          }

          if(state.submitState == SubmitState.valid){
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  _submitMeeting(context);
                }, 
                child: const Text("Submit"),
              ),
            );
          }
          
          if(state.submitState == SubmitState.invalid){
            return const Center(
              child: ElevatedButton(
                onPressed: null, 
                child: const Text("Submit invalid"),
              ),
            );
          }
          if (state.submitState == SubmitState.loading){
            return const CircularProgressIndicator();
          }
          return Container();
        }),
      ),
    );
  }
}
