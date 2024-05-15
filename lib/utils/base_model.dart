abstract class BaseModel<T> {
  String? id;

  String? get mainAttribute;

  Map<String, dynamic> toMap();

  BaseModel({required this.id});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is T &&
              runtimeType == other.runtimeType &&
              id == (other as BaseModel).id;

  @override
  int get hashCode => id.hashCode;
}
