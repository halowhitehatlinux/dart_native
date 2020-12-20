import 'dart:ffi';

DynamicLibrary _nativeDylib;
DynamicLibrary get nativeDylib {
  if (_nativeDylib == null) {
    print("dylib is null, open dyLibrary path + $_libPath");
    _nativeDylib = DynamicLibrary.open(_libPath);
  }
  return _nativeDylib;
}

String _libPath = "libdart_native.so";

class Library {
  static void setLibPath(String soPath) {
    _libPath = soPath;
  }
}
