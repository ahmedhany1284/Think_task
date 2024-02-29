part of 'user_cubit.dart';



abstract class UserStates extends Equatable {
  const UserStates();
  @override
  List<Object> get props => [];
}

class UserInitialState extends UserStates {}
class UserAddDataState  extends UserStates {
  final Map<String, dynamic> data;

  const UserAddDataState(this.data);

  @override
  List<Object> get props => [data];
}


class AdminAddControllerState extends UserStates {
  final Map<String,dynamic> controllers;

  const AdminAddControllerState(this.controllers);

  @override
  List<Object> get props => [controllers];
}


class GetDataSuccessState extends UserStates {
  final List<String> fieldNames;

  const GetDataSuccessState(this.fieldNames);

  @override
  List<Object> get props => [fieldNames];
}
class GetDataFailedState extends UserStates {}
class GetDataLoadingState extends UserStates {}


class SendDataSuccessState extends UserStates {
  final Map<String,dynamic> data;
  const SendDataSuccessState(this.data);

  @override
  List<Object> get props => [data];
}
class SendDataFailedState extends UserStates {}
class SendDataLoadingState extends UserStates {}