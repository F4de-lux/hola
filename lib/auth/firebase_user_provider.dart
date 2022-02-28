import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HolaFirebaseUser {
  HolaFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

HolaFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HolaFirebaseUser> holaFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<HolaFirebaseUser>((user) => currentUser = HolaFirebaseUser(user));
