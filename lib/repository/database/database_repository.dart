import 'package:meeting_web_app/model/meeting_model.dart';
import 'package:meeting_web_app/model/user_model.dart';
import 'package:meeting_web_app/repository/database/api_path.dart';
import 'package:meeting_web_app/repository/database/firestore_service.dart';

abstract class Database {
  Future<void> registerUser(UserModel user);

}

class FirestoreDatabaseRepository implements Database {
  final _firestoreService = FirestoreService.instance;
  
  @override
  Future<void> registerUser(UserModel user)async {
    await _firestoreService.setData(
      path: APIPath.userInfo(user.uid), 
      data: user.toMap());
  }
  
  Future<void> createMeeting(MeetingModel meeting) async {
    await _firestoreService.setData(
      path: APIPath.meetingInfo(meeting.meetingID), 
      data: meeting.toMap());
  }
}