import 'package:chat_app/model/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utility/User.dart';

 CollectionReference<User> getUsersCollection() {
   return FirebaseFirestore.instance.collection(User.COLLECTION_NAME)
       .withConverter<User>(
     fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
     toFirestore: (user, _) => user.toJson(),
   );
 }

  CollectionReference<Room> getRoomsCollectionWithConverter(){
    return FirebaseFirestore.instance.collection(Room.COLLECTION_NAME).withConverter<Room>(
    fromFirestore: (snapShot, _)=> Room.fromJson(snapShot.data()!),
    toFirestore: (Room,_)=> Room.toJson(),
    );
}