import 'package:chat_app/Model/Room.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference<Room> getRoomsCollectionWithConverter(){
  return FirebaseFireStore.instance.collection(Room.COLLECTION_NAME).withConverter<Room>(
    fromFirestore: (snapShot, _)=> Room.fromJson(snapShot.data()!),
    toFirestore: (Room,_)=> Room.toJson(),
  )
}