import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(InitialSearchStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search ({
    required String? token,
    required String text,
  }){
    emit(LoadingSearchStates());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      query: {'text':text}
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchStates());
    }).catchError((error){
      debugPrint(error.toString());
      emit(ErrorSearchStates());
    });
  }
}