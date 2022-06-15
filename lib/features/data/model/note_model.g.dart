// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      id: json['id'] as String?,
      uid: json['uid'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      priority: json['priority'] as int? ?? 0,
    );

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'title': instance.title,
      'description': instance.description,
      'isDeleted': instance.isDeleted,
      'date': instance.date?.toIso8601String(),
      'priority': instance.priority,
    };
