// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

/// A mixin that allows to handle exceptions
mixin ExceptionObserver<Output> {
  
  /// Handle an exception.
  ///
  /// By default, it throws the exception.
  FutureOr<Output> onException(Object e) {
    if (e case Exception _) {
      throw e;
    }
    if (e case Error _) {
      throw e;
    }
    throw Exception(e);
  }
}
