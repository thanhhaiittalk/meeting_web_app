part of '../user_register_bloc.dart';


abstract class UserRegisterEvent extends Equatable {
  @override 
  List<Object> get props => [];
}

class UserRegisterStart extends UserRegisterEvent {}