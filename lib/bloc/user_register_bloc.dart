import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meeting_web_app/model/user_model.dart';
import 'package:meeting_web_app/repository/database/database_repository.dart';

part 'event/user_register_event.dart';
part 'state/user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent,UserRegisterState> {
  final FirestoreDatabaseRepository firestoreDatabase;
  UserRegisterBloc({required this.firestoreDatabase}):super(UserUnregistered()){
    on<UserRegisterStart>((event,emit) async {
      emit(RegisterLoading());
      try {
        final user = FirebaseAuth.instance.currentUser!;
        UserModel userModel = UserModel(uid: user.uid, email: user.email, displayName: user.displayName, photoURL: user.photoURL, rating: double.parse((Random().nextDouble() * 5).toStringAsFixed(1)));
        await firestoreDatabase.registerUser(userModel);
        emit(UserRegisterSuccess());
      } catch (e) {
        emit(UserRegisterError(e.toString()));
        emit(UserUnregistered());
      }
    });
  }
}