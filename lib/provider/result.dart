sealed class Result<S, E extends Exception> {
  const Result();

  R fold<R>(R Function(S value) onSuccess, R Function(E exception) onFailure) {
    if (this is Success<S, E>) {
      final Success<S, E> successResult = this as Success<S, E>;
      return onSuccess(successResult.value);
    } else if (this is Failure<S, E>) {
      final Failure<S, E> failureResult = this as Failure<S, E>;
      return onFailure(failureResult.exception);
    } else {
      throw Exception("Unknown result type");
    }
  }
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Success<S, E> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success(value: $value)';
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure<S, E> && other.exception == exception;
  }

  @override
  int get hashCode => exception.hashCode;

  @override
  String toString() => 'Failure(exception: $exception)';
}
