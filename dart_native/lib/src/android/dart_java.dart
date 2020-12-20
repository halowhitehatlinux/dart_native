export 'runtime/jobject.dart';

import 'common/library.dart';

class DartJava {

  /// set so path
  static void loadLibrary(String soPath) {
    if (soPath != null && soPath.isNotEmpty) {
      Library.setLibPath(soPath);
    }
  }
}
