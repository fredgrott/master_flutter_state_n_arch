// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


import 'package:meta/meta.dart';

/// [UsecaseException] is sometimes threw by Usecases operations.
///
/// ```dart
/// throw const UsecaseException('Emergency failure!');
/// ```
@immutable
class UsecaseException implements Exception {
  /// usecase exception
  const UsecaseException([this.message]);

  /// The message of the exception.
  final String? message;

  @mustBeOverridden
  String get prefix => 'UsecaseException';

  @override
  String toString() => '$prefix${message != null ? ': $message' : ''}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsecaseException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}


/// [InvalidPreconditionsException] is threw when the preconditions of a
/// Usecase are not met.
class InvalidPreconditionsException extends UsecaseException {
  /// {@macro invalid_preconditions_exception}
  const InvalidPreconditionsException([super.message]);

  @override
  String get prefix => 'InvalidPreconditionsException';
}


/// [InvalidPostconditionsException] is threw when the postconditions of a
/// Usecase are not met.
class InvalidPostconditionsException extends UsecaseException {
  /// 
  const InvalidPostconditionsException([super.message]);

  @override
  String get prefix => 'InvalidPostconditionsException';
}

/// [StreamUsecaseException] is sometimes threw by Stream Usecases operations.
class StreamUsecaseException extends UsecaseException {
  /// 
  const StreamUsecaseException([super.message]);

  @override
  String get prefix => 'StreamUsecaseException';
}
