import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel {
  MeetingModel({
    required this.meetingID,
    required this.title,
    required this.meetingStartTime,
    required this.meetingEndTime,
    required this.duration,
    required this.hostID,
    required this.hostDisplayName,
    required this.hostEmail,
    required this.guestID,
    required this.guestDisplayName,
    required this.guestEmail,
    required this.description
  });

  final String? meetingID;
  final String? title;
  final Timestamp? meetingStartTime;
  final Timestamp? meetingEndTime;
  final int? duration; //in minutes
  final String? hostID;
  final String? hostEmail;
  final String? hostDisplayName;
  final String? guestID;
  final String? guestDisplayName;
  final String? guestEmail;
  final String? description;

  factory MeetingModel.fromMap(Map<String, dynamic> data, String meetingID) {
    return MeetingModel(
        meetingID: meetingID,
        title: data['title'],
        meetingStartTime: data['meetingStartTime'],
        meetingEndTime: data['meetingEndTime'],
        duration: data['duration'],
        hostID: data['hostID'],
        hostDisplayName: data['hostDisplayName'],
        hostEmail: data['hostEmail'],
        guestID: data['guestID'],
        guestDisplayName: data['guestDisplayName'],
        guestEmail: data['guestEmail'],
        description: data['description']);
  }

  Map<String,dynamic> toMap() {
    return {
      'meetingID': meetingID,
      'title': title,
      'meetingStartTime': meetingStartTime,
      'meetingEndTime': meetingEndTime,
      'duration': duration,
      'hostID': hostID,
      'hostDisplayName': hostDisplayName,
      'hostEmail': hostEmail,
      'guestID': guestID,
      'guestDisplayName': guestDisplayName,
      'guestEmail': guestEmail,
      'description': description,
    };
  }
}