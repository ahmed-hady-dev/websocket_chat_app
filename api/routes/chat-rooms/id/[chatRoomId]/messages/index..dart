import 'dart:async';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String chatRoomId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, chatRoomId);
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.delete:
    case HttpMethod.patch:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _get(RequestContext context, String chatRoomId) async {
  return Response(body: 'Welcome to dart frog!');
}
