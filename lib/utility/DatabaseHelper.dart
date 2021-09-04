
import 'package:chat_app/utility/Room.dart';
import 'package:chat_app/utility/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'User.dart';
 CollectionReference<User> getUsersCollection() {
   return FirebaseFirestore.instance.collection(User.COLLECTION_NAME)
       .withConverter<User>(
     fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
     toFirestore: (user, _) => user.toJson(),
   );
 }
CollectionReference<Room> getUserCollectionWithConverter(String userId){
  final userCollection =getUsersCollection();

  return userCollection.doc(userId).collection(Room.COLLECTION_NAME)
      .withConverter(fromFirestore: (snapshot,_)=>Room.fromJson(snapshot.data()!),
      toFirestore: (room,_)=>room.toJson());
}

  CollectionReference<Room> getRoomsCollectionWithConverter(){
    return FirebaseFirestore.instance.collection(Room.COLLECTION_NAME).withConverter<Room>(
    fromFirestore: (snapShot, _)=> Room.fromJson(snapShot.data()!),
    toFirestore: (Room,_)=> Room.toJson(),
    );
}

CollectionReference<Message> getMessageWithConverter(String roomId){
  final roomsCollection = getRoomsCollectionWithConverter();

  return roomsCollection.doc(roomId).collection(Message.collectionName).withConverter(
    fromFirestore: (snapshot,_)=>Message.fromJson(snapshot.data()!),
    toFirestore: (Message,_)=> Message.toJson(),
  );
}

CollectionReference<User> getRoomCollectionWithConverter(String roomID){
  final userCollection =getRoomsCollectionWithConverter();

  return userCollection.doc(roomID).collection(User.COLLECTION_NAME)
      .withConverter(fromFirestore: (snapshot,_)=>User.fromJson(snapshot.data()!),
      toFirestore: (user,_)=>user.toJson());
}
