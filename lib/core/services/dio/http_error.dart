class HttpError {
  int statusCode;
  dynamic message;
  dynamic response;

  HttpError({this.statusCode = 400, required this.message, this.response});

  HttpError.dioError(
      {showApiErrors = true,
      this.statusCode = 400,
      this.message,
      this.response}) {
    if (statusCode == 401) {
      
      return;
    }

    if (showApiErrors == false) return;
    if (response != null) {
      if (response is Map) {
      } else if (message is String) {}
    }
  }

  @override
  String toString() {
    return 'HttpError{code:$statusCode , message:$message}';
  }
}
