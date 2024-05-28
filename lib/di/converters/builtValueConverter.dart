import 'package:chopper/chopper.dart';
import 'package:score_keeper/di/serializers/serializers.dart';
import 'package:built_collection/built_collection.dart';

class BuiltValueConverter extends JsonConverter
    implements Converter, ErrorConverter {
  T _deserializer<T>(dynamic value) => serializers.deserializeWith(
        serializers.serializerForType(T)!,
        value,
      );

  @override
  Request convertRequest(Request request) {
    return super.convertRequest(
      request.copyWith(
        body: serializers.serializeWith(
            serializers.serializerForType(request.body.runtimeType)!,
            request.body),
      ),
    );
  }

  @override
  Future<Response<ResultType>> convertResponse<ResultType, Item>(
      Response response) async {
    final jsonResponse = await super.convertResponse(response);
    final body = _decode<Item>(jsonResponse.body);

    return jsonResponse.copyWith<ResultType>(body: body);
  }

  dynamic _decode<T>(entity) {
    if (entity is T) return entity;

    try {
      if (entity is List) return _deserializeListOf<T>(entity);
      return _deserializer<T>(entity);
    } catch (e) {
      print(e);
      return null;
    }
  }

  BuiltList<T> _deserializeListOf<T>(Iterable value) => BuiltList(
        value.map((value) => _deserializer<T>(value)).toList(growable: true),
      );

  @override
  Future<Response> convertError<BodyType, InnerType>(Response response) async {
    print(response.body);
    final jsonResponse = await super.convertResponse(response);

    var body;

    try {
      // try to deserialize using wireName
      body ??= _deserializer(jsonResponse.body);
    } catch (_) {
      // or check provided error type
      // if (errorType != null) {
      //   final serializer = jsonSerializers.serializerForType(errorType);
      //   print(serializer);
      //   body = jsonSerializers.deserializeWith(serializer, jsonResponse.body);
      // }
      body ??= jsonResponse.body;
    }

    return jsonResponse.copyWith(bodyError: body);
  }
}
