abstract class BaseModel {
  late int id;
  Map<String, dynamic> toMap();
  BaseModel.fromMap(Map<String, dynamic> json);
  BaseModel.fromJson(String str);
}