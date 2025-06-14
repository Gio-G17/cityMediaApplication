import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voiceofgospel/features/domain/contacts_model.dart';
import 'package:voiceofgospel/features/domain/server_model.dart';
import 'package:voiceofgospel/features/domain/share_model.dart';
import 'package:voiceofgospel/features/domain/social_model.dart';
import 'package:voiceofgospel/features/domain/station_model.dart';

class DataRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<SocialModel>> getSocial() async {
    try {
      // List<SocialModel> list=[];
      // QuerySnapshot querySnapshot = await firestore.collection("v2-Social").orderBy("iconOrder", descending: false).get();
      QuerySnapshot querySnapshot = await firestore
          .collection("v2-Social")
          .orderBy("iconOrder",
              descending: false) // Order by iconOrder in ascending order
          .get();

      // Map the documents to a list of SocialModel
      List<SocialModel> list = querySnapshot.docs.map((doc) {
        return SocialModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return list;
    } catch (e) {
      print('XXXXXXXXXXXXXXSError fetching social data: $e');
      return [];
    }

  // List<SocialModel> lisst = querySnapshot.docs
  //     .map((e) => SocialModel.fromMap(e.data() as Map<String, dynamic>))
  //     .toList();

  //       lisst.sort((a, b) => a.iconOrder.compareTo(b.iconOrder));
  //   // for(var doc in querySnapshot.docs){
  //   //   print(doc.data());
  //   //   // print("link is ${doc['link']}");
  //   //  SocialModel socialModel= SocialModel.fromMap(doc.data() as Map<String,dynamic>);
  //   //  list.add(socialModel);
  //   // }
  //   // List<SocialModel> lisst = List.from((querySnapshot.docs)
  //   //     .map((e) => SocialModel.fromMap(e.data() as Map<String, dynamic>)));
  //   print("LISSSSSTTT QQQUAAANNNTIITTYY"+lisst.length.toString());

  // return lisst;
  }



  getShare() async {
    QuerySnapshot querySnapshot = await firestore.collection("v1-Share").get();
    List<ShareModel> lisst = List.from((querySnapshot.docs)
        .map((e) => ShareModel.fromMap(e.data() as Map<String, dynamic>)));

    return lisst;
  }

  Future<StationModel> getStation() async {
    QuerySnapshot querySnapshot = await firestore.collection("v2-Mobile").get();
    StationModel station = StationModel.fromMap(
        querySnapshot.docs[0].data() as Map<String, dynamic>);
    return station;
  }

  Future<ContactsModel> getContacts() async {
    QuerySnapshot querySnapshot =
        await firestore.collection("v2-Contacts").get();
    ContactsModel contacts = ContactsModel.fromMap(
        querySnapshot.docs[0].data() as Map<String, dynamic>);
    return contacts;
  }

Future<ServerModel> getServer() async {
    QuerySnapshot querySnapshot = await firestore.collection("v2-server").get();
    ServerModel v2Server = ServerModel.fromMap(
        querySnapshot.docs[0].data() as Map<String, dynamic>);
    return v2Server;
  }

}

  

final dataRepositoryProv = Provider((ref) => DataRepository());

final getSocialProv = FutureProvider((ref) {
  final prov = ref.watch(dataRepositoryProv);
  return prov.getSocial();
});

final getShareProv = FutureProvider((ref) {
  final prov = ref.watch(dataRepositoryProv);
  return prov.getShare();
});

final getStationProv = FutureProvider((ref) {
  final prov = ref.watch(dataRepositoryProv);
  return prov.getStation();
});

final getContactsProv = FutureProvider((ref) {
  final prov = ref.watch(dataRepositoryProv);
  return prov.getContacts();
});

final getServerProv = FutureProvider((ref) {
  final prov = ref.watch(dataRepositoryProv);
  return prov.getServer();
});
