import 'package:sqflite_example/core/base/base_response.dart';
import 'package:sqflite_example/core/base/response_wrapper.dart';
import 'package:sqflite_example/core/base/server_error.dart';
import 'package:sqflite_example/core/firebase/firebase_helper.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';
import 'package:sqflite_example/features/data/model/note_request_model.dart';

abstract class NoteDataSource {
  Future<ResponseWrapper<BaseResponse>> getNotes();

  Future<ResponseWrapper<BaseResponse>> addNote(NoteModel noteModel);

  Future<ResponseWrapper<BaseResponse>> deleteNote(
      NoteRequestModel noteRequestModel);

  Future<ResponseWrapper<BaseResponse>> updateNote(
      NoteRequestModel noteRequestModel);
}

class NoteDatasourceImpl implements NoteDataSource {
  FirebaseHelper firebaseHelper;

  NoteDatasourceImpl(this.firebaseHelper);

  @override
  Future<ResponseWrapper<BaseResponse>> addNote(NoteModel noteModel) async {
    try {
      var responseWrapper = ResponseWrapper<BaseResponse>();
      BaseResponse baseResponse = await firebaseHelper.addNote(noteModel);
      responseWrapper.setData(baseResponse);
      return responseWrapper;
    } catch (e) {
      return ServerError.firebaseExceptionHandle(e);
    }
  }

  @override
  Future<ResponseWrapper<BaseResponse>> deleteNote(
      NoteRequestModel noteRequestModel) async {
    try {
      var responseWrapper = ResponseWrapper<BaseResponse>();
      BaseResponse baseResponse =
          await firebaseHelper.deleteNote(noteRequestModel.uid!);
      responseWrapper.setData(baseResponse);
      return responseWrapper;
    } catch (e) {
      return ServerError.firebaseExceptionHandle(e);
    }
  }

  @override
  Future<ResponseWrapper<BaseResponse>> getNotes() async {
    try {
      var responseWrapper = ResponseWrapper<BaseResponse>();
      BaseResponse baseResponse = await firebaseHelper.getNotes();
      responseWrapper.setData(baseResponse);
      return responseWrapper;
    } catch (e) {
      return ServerError.firebaseExceptionHandle(e);
    }
  }

  @override
  Future<ResponseWrapper<BaseResponse>> updateNote(
      NoteRequestModel noteRequestModel) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
