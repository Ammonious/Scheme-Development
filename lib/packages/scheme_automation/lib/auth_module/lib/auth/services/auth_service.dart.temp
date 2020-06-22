import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import '../../common/dialog_utils/dialog_service.dart';
import '../../auth/model/user.dart';
import '../../common/locator/locator.dart';

@lazySingleton
class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DialogService _dialogService = locator<DialogService>();
  final _firestore = Firestore.instance.collection('Users');
  User _currentUser;
  User get currentUser => _currentUser;

  Future<dynamic> createUser(User user) async => await _firestore
      .document(user.uid)
      .setData(user.toJson())
      .catchError((error) => _dialogService.showDialog(title: 'Oops!', body: error.message));


  userStream(String uid) => StreamProvider.value(
      value: _firestore.document(uid).snapshots().map((event) => User.fromJson(event.data)));
}
