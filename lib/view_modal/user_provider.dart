import 'package:flutter/cupertino.dart';
import 'package:instagram_clone_firebase/auth/user_details.dart';
import 'package:instagram_clone_firebase/modals/user_modal.dart';

class UserProvider with ChangeNotifier {
  UserModal? _user;

  UserModal get getUser => _user!;

  void updateUser() async {
    UserModal user = await UserDetails.getUserDetails();

    _user = user;
    notifyListeners();
  }
}
