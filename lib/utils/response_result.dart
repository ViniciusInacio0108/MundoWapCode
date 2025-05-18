/// This class is used to return the responses and erros from external data sources.
sealed class ResponseResult<T> {
  const ResponseResult();

  factory ResponseResult.ok(T value) => Ok(value);

  factory ResponseResult.error(Exception error) => Error(error);
}

// This class is used to when we have success in the external data source fetching and we want to return it.
final class Ok<T> extends ResponseResult<T> {
  const Ok(this.value);

  final T value;
}

// This class represents the error and should only return it.
final class Error<T> extends ResponseResult<T> {
  const Error(this.error);

  final Exception error;
}
