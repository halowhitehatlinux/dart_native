import 'dart:ffi';

import 'package:dart_native/src/android/runtime/jobject.dart';

typedef Pointer<Void> InitSubclass(dynamic value);

/// Dart Wrapper for subclass of JObject. For example: JavaString, JavaList, etc.
class JavaSubclass<T> extends JObject {
  T raw;

  JavaSubclass(this.raw, [InitSubclass init]) : super("", init(raw));
  JavaSubclass.fromPointer(Pointer<Void> ptr) : super("", ptr);

  bool operator ==(other) {
    if (other == null) {
      return false;
    }
    if (other is T) return raw == other;
    return raw == other.raw;
  }

  @override
  int get hashCode => raw.hashCode;

  @override
  String toString() {
    return raw.toString();
  }
}
