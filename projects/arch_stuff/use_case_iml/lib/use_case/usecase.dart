// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:use_case_iml/use_case/conditions_observer.dart';
import 'package:use_case_iml/use_case/conditions_result.dart';
import 'package:use_case_iml/use_case/exception_observer.dart';
import 'package:use_case_iml/use_case/usecase_executor.dart';

/// Base class for all usecases.
///
/// This carries the mixins that are used by all usecases.
abstract class _Usecase<Input, Output> with ConditionsObserver<Input, Output>, ExceptionObserver<Output> {
  const _Usecase._();
}

/// {@template usecase}
/// A usecase that requires params of type [Input] and returns a result of type
/// [Output].
/// {@endtemplate}
abstract class Usecase<Input, Output> extends _Usecase<Input, Output> with UsecaseExecutor<Input, Output> {
  /// {@macro usecase}
  const Usecase() : super._();

  /// This method is called before the execution of the usecase.
  ///
  /// By default, it returns true if the input is not null.
  @override
  FutureOr<ConditionsResult> checkPreconditions(Input? params) {
    if (params == null) {
      return ConditionsResult(isValid: false, message: 'Params is null');
    }
    return super.checkPreconditions(params);
  }

  /// Execute the usecase with the given params
  ///
  /// Must be implemented by subclasses but should not be called directly.
  @visibleForOverriding
  FutureOr<Output> execute(Input params);

  /// Call the usecase with the given params
  FutureOr<Output> call(Input? params) async => executeWithConditions(
        params,
        executor: () async => execute(params as Input),
        onException: onException,
      );
}


/// A usecase that does not require any params, but returns a result of type
/// [Output].
abstract class NoParamsUsecase<Output> extends _Usecase<void, Output> with UsecaseExecutor<void, Output> {
  /// {@macro no_params_usecase}
  const NoParamsUsecase() : super._();

  /// Execute the usecase with the given params
  ///
  /// Must be implemented by subclasses but should not be called directly.
  @visibleForOverriding
  FutureOr<Output> execute();

  /// Call the usecase
  FutureOr<Output> call() async => executeWithConditions(
        null,
        executor: execute,
        onException: onException,
      );
}


/// A stream usecase that requires params of type [Input] and returns a
/// stream of [Output].
abstract class StreamUsecase<Input, Output> extends _Usecase<Input, Output> with UsecaseStreamExecutor<Input, Output> {
  /// 
  const StreamUsecase() : super._();

  /// This method is called before the execution of the usecase.
  ///
  /// By default, it returns if the input is not null.
  @override
  FutureOr<ConditionsResult> checkPreconditions(Input? params) {
    if (params == null) {
      return ConditionsResult(isValid: false, message: 'Params is null');
    }
    return super.checkPreconditions(params);
  }

  /// Execute the usecase with the given params
  ///
  /// Must be implemented by subclasses but should not be called directly.
  @visibleForOverriding
  Stream<Output> execute(Input params);

  /// Call the usecase with the given params
  Stream<Output> call(Input? params) async* {
    yield* executeWithConditions(
      params,
      executor: () => execute(params as Input),
      onException: onException,
    );
  }
}


/// A stream usecase that does not require any params, but returns a
/// stream of [Output].
abstract class NoParamsStreamUsecase<Output> extends _Usecase<void, Output> with UsecaseStreamExecutor<void, Output> {
  /// {@macro no_params_stream_usecase}
  const NoParamsStreamUsecase() : super._();

  /// Execute the usecase with the given params
  ///
  /// Must be implemented by subclasses but should not be called directly.
  @visibleForOverriding
  Stream<Output> execute();

  /// Call the usecase
  Stream<Output> call() async* {
    yield* executeWithConditions(
      null,
      executor: execute,
      onException: onException,
    );
  }
}
