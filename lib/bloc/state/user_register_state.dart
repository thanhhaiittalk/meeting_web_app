part of '../user_register_bloc.dart';

abstract class UserRegisterState extends Equatable {}

class RegisterLoading extends UserRegisterState {
  @override 
  List<Object?> get props => [];
}

//When complete write user info to database
class UserRegisterSuccess extends UserRegisterState {
  @override 
  List<Object?> get props => [];
}

//When user is new 
class UserUnregistered extends UserRegisterState {
  @override 
  List<Object?> get props => [];
}

//If any error occurs 
class UserRegisterError extends UserRegisterState {
  final String error;
  UserRegisterError(this.error);
  @override 
  List<Object?> get props => [error];
}
