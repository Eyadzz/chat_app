import 'package:chat_app/model/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Message.dart';

CollectionReference <Room> getRoomsCollectionWithConverter (){
  return FirebaseFirestore.instance.collection(Room.collectionName).withConverter<Room>(
      fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
      toFirestore: (room, _) => room.toJson(),
  );
}

CollectionReference<Message> getMessageWithConverter(String roomId){
  final roomsCollection = getRoomsCollectionWithConverter();

  return roomsCollection.doc(roomId).collection(Message.collectionName).withConverter(
    fromFirestore: (snapshot,_)=>Message.fromJson(snapshot.data()!),
    toFirestore: (snapshot,_)=> {}/*Message.toJson()*/,
  );
}