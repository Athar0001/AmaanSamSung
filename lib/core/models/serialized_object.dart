abstract class SerializedObject {
  Map<String, dynamic> toJson();
}

mixin SerializedObjectMixin implements SerializedObject {
  Map<String, dynamic> toJson();
}
