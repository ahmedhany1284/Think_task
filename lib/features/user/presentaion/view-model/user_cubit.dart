import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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


  final ImagePicker _picker = ImagePicker();
  pickImageFromGallery() async {

    final pickedFile = await  _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      imageLink = await uploadImageToFirebaseStorage(imageFile);

      final DateTime dateTime = DateTime.now();
      final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
      final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('ProfileImage');

      await databaseReference.update({formattedDateTime: imageLink});
    }
    emit(ChooseImageState(imageLink!) );
  }

  File ?imageFile;
  Future<void> pickImageFromCamera() async {

    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      imageLink = await uploadImageToFirebaseStorage(imageFile);
      final DateTime dateTime = DateTime.now();
      final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
      final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('ProfileImage');

      await databaseReference.update({formattedDateTime: imageLink});

    }
  }

  String ?imageLink;


  Future<String?> uploadImageToFirebaseStorage(File? imageFile) async {
    emit(UploadImageToFirebaseStorageLoadingState());
    if (imageFile == null) return null;
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      await uploadTask.whenComplete(() => null);
      String downloadURL = await firebaseStorageRef.getDownloadURL();
      emit(UploadImageToFirebaseStorageLoadedState());
      return downloadURL;

    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      emit(UploadImageToFirebaseStorageErrorState());
      return null;
    }
  }





}
