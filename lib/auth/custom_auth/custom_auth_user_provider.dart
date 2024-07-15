import 'package:rxdart/rxdart.dart';

import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

class RudrakshaCartAuthUser {
  RudrakshaCartAuthUser({
    required this.loggedIn,
    this.uid,
    this.userData,
  });

  bool loggedIn;
  String? uid;
  UserStruct? userData;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<RudrakshaCartAuthUser> rudrakshaCartAuthUserSubject =
    BehaviorSubject.seeded(RudrakshaCartAuthUser(loggedIn: false));
Stream<RudrakshaCartAuthUser> rudrakshaCartAuthUserStream() =>
    rudrakshaCartAuthUserSubject
        .asBroadcastStream()
        .map((user) => currentUser = user);
