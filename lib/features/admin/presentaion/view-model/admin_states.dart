part of 'admin_cubit.dart';

abstract class AdminStates extends Equatable {
  const AdminStates();
  @override
  List<Object> get props => [];
}

class AdminInitialState extends AdminStates {}
class AdminAddControllerState extends AdminStates {
  final String fieldName;
  const AdminAddControllerState(this.fieldName);

  @override
  List<Object> get props => [fieldName];
}

class SendDataSuccessState extends AdminStates {
  final String message;
  const SendDataSuccessState(this.message);

  @override
  List<Object> get props => [message];
}
class SendDataFailedState extends AdminStates {}
class GetDataSuccessState extends AdminStates {
  final List<String> fieldNames;

  const GetDataSuccessState(this.fieldNames);

  @override
  List<Object> get props => [fieldNames];
}
class GetDataFailedState extends AdminStates {}
