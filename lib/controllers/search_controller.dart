import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tik_tok_flutter/constants.dart';
import 'package:tik_tok_flutter/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUser = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUser.value;

  searchUser(String typedUser) async {
    _searchedUser.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];
      for (var elem in query.docs) {
        retVal.add(User.fromSnap(elem));
      }
      return retVal;
    }));
  }
}
