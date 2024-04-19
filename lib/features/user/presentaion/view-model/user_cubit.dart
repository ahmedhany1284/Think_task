import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_states.dart';


class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState()) {
    fieldKeys = data.keys.toList();
    values = data.values.toList();
  }
   Map<String, dynamic> data={};
  late List<String> fieldKeys;
  late List<dynamic> values;



  List<TextEditingController> controllers = [];

  void initControllers() async{
    controllers = List.generate(
      fieldKeys.length,
          (index) => TextEditingController(),
    );
  }

  void updateControllerValue(int index, String value) {
    controllers[index].text = value;
  }

  void putInValues(){
    values= controllers.map((e) => e.text).toList();
  }
  void addFieldKey(String value)  {
     values.add(value);
    emit(UserAddDataState(data));
  }
  void addFieldValue(String value)  {
     values.add(value);
    emit(UserAddDataState(data));
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
        fieldKeys = updatedFilenames;
        print('test ${updatedFilenames.toString()}');
        emit(GetDataSuccessState(fieldKeys));
      });
    } catch (e) {
      print(e.toString());
      emit(GetDataFailedState());
    }
  }


  void combineToMap(){
    for(int i=0;i<fieldKeys.length;i++){
      data[fieldKeys[i]]=values[i];
    }
  }

  Future<void>submitData()async{
    try{
      print(data);
      print(fieldKeys);
      print(values);
      await FirebaseFirestore.instance
          .collection('info')
          .doc('hJ4AghTYHXrBOwHb4WKr')
          .update(data);
      emit(SendDataSuccessState(data));
    }catch(e){
      emit(SendDataFailedState());
    }

  }




}
