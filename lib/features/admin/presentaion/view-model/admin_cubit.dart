import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_states.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());
  List<String> fieldNames = [];
  Future<void> updateFileNames(String value) async {
    try {
      String index=(fieldNames.length+1).toString();
      await FirebaseFirestore.instance
          .collection('fields').doc('D99d0CV6gcIBMZkMSpnS')
          .update({index: value});
      emit(SendDataSuccessState(value));
    } catch (e) {
      print(e.toString());
      emit(SendDataFailedState());
    }
  }

  Future<void> getFileNames() async {
    try {
      FirebaseFirestore.instance
          .collection('fields').doc('D99d0CV6gcIBMZkMSpnS')
          .snapshots()
          .listen((event) {
        List<String> updatedFilenames = [];
        var data = event.data();
        if (data != null) {
          var values = data.values.toList();
          updatedFilenames.addAll(values.map((e) => e.toString()));
        }
        fieldNames = updatedFilenames;
        emit(GetDataSuccessState(fieldNames));
      });
    } catch (e) {
      print(e.toString());
      emit(GetDataFailedState());
    }
  }



}
