import 'dart:ffi';

class Class extends Comparable<dynamic>{
  String _className;
  Pointer _pointer;

  Class(String className, Pointer pointer) {
    _className = className;
    _pointer = pointer;
  }

  String get className {
    return _className;
  }

  Pointer get pointer {
    return _pointer;
  }

  @override
  int compareTo(other) {
    if (other is Class && other._className == _className && other.pointer == _pointer) {
      return 0;
    }
    return 1;
  }
}
