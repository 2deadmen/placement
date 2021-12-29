import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';



class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // final String uid = "Registration";
  //final String _name;
  // final String _phonenumber;
  //final String _email;
  final String _usn;

  // final String _branch;
  final String _password;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get Data {
    return _auth.onAuthStateChanged;
  }

  Database(this._usn,
      this._password);

  // Future register() async {
  //   try {
  //     //   var authResult = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
  //     // User user = authResult.user;
  //     return await firestore.collection("registeration").add({
  //      // "name": _name,
  //       "password": _password,
  //   //    "phone": _phonenumber,
  //       "usn": _usn,
  //       //"event_1": "",
  //       //"event_2": "",
  //       //"event_3": "",
  //       //"event_4": "",
  //       //"event_5": "",
  //     }
  //     );
  //     // return user;
  //   }
  //   catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Future<DocumentSnapshot> getUserData(String uid) async {
    try {
      QuerySnapshot temp = await firestore.collection("Data")
          .getDocuments();
      // print(temp.size.toString());
      for (var i = 0; i < temp.size; i++) {
        // print(temp.docs.elementAt(i).data()['email'].toString());
        if (temp.docs.elementAt(i).data()['usn'].toString().compareTo(
            _password) ==
            0) {
          // print(temp.docs.elementAt(i));
          return temp.docs.elementAt(i);
        }
      }
      print('couldn\'t found');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String usn, String password) async {

      try {

          // var signInRes = await _auth.signInWithEmailAndPassword(
        }
        //     email: usn, password: password);
        //
        // return signInRes.user;
      }
      catch (e) {
        print(e.toString());
        return null;
      }
    }

    // Future changePassword(String new_pass) async {
    //   try {
    //     User user = await FirebaseAuth.instance.currentUser;
    //     print(user.toString());
    //     user.updatePassword(new_pass);
    //   } catch (e) {
    //     print(e.toString());
    //     return 0;
    //   }
    // }

    Future signOut() {
      try {
        return _auth.signOut();
      } catch (e) {
        return null;
      }
    }
  }
//}

//   Future registerCodigo() async {
//     try{
//       //   var authResult = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
//       // User user = authResult.user;
//       return await firestore.collection("codigo").add({
//         "name": _name,
//         "email" : _email,
//         "phone" : _phone,
//         "institution_name" : _usn,
//         "city": _city,
//         "paid": false,
//         "informed" : false
//       }
//       );
//       // return user;
//     }
//     catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//   Future registerCyberSec() async {
//     try{
//       //   var authResult = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
//       // User user = authResult.user;
//       return await firestore.collection("cybersec").add({
//         "name": _name,
//         "email" : _email,
//         "phone" : _phone,
//         "institution_name" : _usn,
//         // "city": _city,
//         // "paid": false,
//         // "informed" : false
//       }
//       );
//       // return user;
//     }
//     catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }