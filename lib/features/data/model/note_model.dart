import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class NoteModel {
  final String? id;
  final String? uid;
  final String? title;
  final String? description;
  final bool? isDeleted;
  final DateTime? date;
  final int? priority;

  NoteModel(
      {this.id,
      this.uid,
      this.title,
      this.description,
      this.isDeleted = false,
      this.date,
      this.priority = 0});

  factory NoteModel.fromJson(Map<String, dynamic> data) =>
      _$NoteModelFromJson(data);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
