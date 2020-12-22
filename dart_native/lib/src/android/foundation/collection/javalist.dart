import 'package:dart_native/src/android/foundation/javasubclass.dart';

/// Stands for `List` in Android.
class JavaList extends JavaSubclass {

  JavaList(List value) : super(value) {
    value = List.of(value, growable: false);
  }




}
