import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMeetingRepository {
  String? title;
  Timestamp? meetingStartTime;
  Timestamp? meetingEndTime;
  DateTime? tempDate;
  TimeOfDay? tempTime;
  User? guest;
  User? host;
  int duration = 0; //in minute
  String? description ;
  String? meetingID;

  void setTitle(String title){
    this.title = title;
  }

  void setTempDate(DateTime date){
    tempDate = date;
  }

  void setTempTime(TimeOfDay time){
    tempTime = time;
  }

  void setMeetingBeginTime(){
    if (tempDate == null && tempTime == null) {
      //Do nothing
    } else if (tempDate != null &&  tempTime == null){
      meetingStartTime = Timestamp.fromDate(tempDate!);
    } else if (tempDate != null && tempTime != null){
      DateTime newDateTime = 
          DateTime(tempDate!.year,tempDate!.month, tempDate!.day, tempTime!.hour, tempTime!.minute);
      meetingStartTime = Timestamp.fromDate(newDateTime);
    }
  }

  void setMeetingEndTime() {
    if(meetingStartTime == null || duration == 0){
      //do nothing
    } else {
      meetingEndTime = Timestamp(meetingStartTime!.seconds + duration*60, meetingStartTime!.nanoseconds);
    }
  }

  void setDuration(int duration) {
    this.duration = duration;
    if(meetingStartTime != null){
      meetingEndTime = Timestamp(meetingStartTime!.seconds+duration*60,0); 
    }
  }

  void setHost(User user) {
    host = user;
  }

  void setGuest(User user) {
    guest = user;
  }

  void setDescription(String description){
    this.description = description;
  }

  void setMeetingID(String meetingID){
    this.meetingID = meetingID;
  }
  void dispose(){
    title = null;
    meetingStartTime = null;
    tempDate = null;
    meetingEndTime = null;
    guest = null;
    host = null;
    duration = 0;
    description = null;
    meetingID = null;
  }
}