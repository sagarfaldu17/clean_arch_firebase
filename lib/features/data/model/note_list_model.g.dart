// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteListModel _$NoteListModelFromJson(Map<String, dynamic> json) =>
    NoteListModel(
      noteList: (json['noteList'] as List<dynamic>?)
          ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NoteListModelToJson(NoteListModel instance) =>
    <String, dynamic>{
      'noteList': instance.noteList,
    };
