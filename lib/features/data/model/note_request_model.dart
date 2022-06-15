import 'package:json_annotation/json_annotation.dart';

part 'note_request_model.g.dart';

@JsonSerializable()
class NoteRequestModel {
  final String? uid;

  NoteRequestModel(this.uid);

  factory NoteRequestModel.fromJson(Map<String, dynamic> data) =>
      _$NoteRequestModelFromJson(data);

  Map<String, dynamic> toJson() => _$NoteRequestModelToJson(this);
}
