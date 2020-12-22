import 'dart:ffi';
import 'package:dart_native/src/android/runtime/functions.dart';
import 'package:dart_native/src/android/common/pointer_encoding.dart';
import 'package:dart_native/src/android/common/library.dart';
import 'package:ffi/ffi.dart';

import 'class.dart';

void passJObjectToNative(JObject obj) {
  if (initDartAPISuccess && obj != null) {
    passJObjectToC(obj, obj.pointer);
  } else {
    print('pass object to native failed! address=${obj?.pointer}');
  }
}

class JObject extends Class {

  //init target class
  JObject(String className, Pointer ptr)
      : super(className, ptr == null ? nativeCreateClass(classUtf8(className)) : ptr) {
    passJObjectToNative(this);
  }

  dynamic invoke(String methodName, List args, String returnType) {
    Pointer<Utf8> methodNamePtr = Utf8.toUtf8(methodName);
    Pointer<Utf8> returnTypePtr = Utf8.toUtf8(returnType);

    Pointer<Pointer<Void>> pointers;
    Pointer<Pointer<Utf8>> typePointers;
    if (args != null) {
      pointers = allocate<Pointer<Void>>(count: args.length + 1);
      typePointers = allocate<Pointer<Utf8>>(count: args.length + 1);
      for (var i = 0; i < args.length; i++) {
        var arg = args[i];
        if (arg == null) {
          throw 'One of args list is null';
        }
        storeValueToPointer(
            arg, pointers.elementAt(i), typePointers.elementAt(i));
      }
      pointers.elementAt(args.length).value = nullptr;
      typePointers.elementAt(args.length).value = nullptr;
    }
    Pointer<Void> invokeMethodRet = nativeInvokeNeo(
        pointer, methodNamePtr, pointers, typePointers, returnTypePtr);
    dynamic result = loadValueFromPointer(invokeMethodRet, returnType);
    if (pointers != null) {
      free(pointers);
    }
    if (typePointers != null) {
      free(typePointers);
    }
    return result;
  }

  static Pointer<Utf8> classUtf8(String className) {
    return Utf8.toUtf8(className);
  }
}
