import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/searchTextField/search_text_field_event.dart';
import 'package:toolkit/blocs/searchTextField/search_text_field_state.dart';

class SearchTextFieldBloc
    extends Bloc<SearchTextFieldEvents, SearchTextFieldStates> {
  SearchTextFieldBloc() : super(SearchTextFieldInitial()) {
    on<InitiateSearch>(_initiateSearch);
    on<Search>(_search);
  }

  FutureOr<void> _search(Search event, Emitter<SearchTextFieldStates> emit) {
    emit(Searched());
  }

  FutureOr<void> _initiateSearch(
      InitiateSearch event, Emitter<SearchTextFieldStates> emit) {
    emit(SearchTextFieldInitial());
  }
}
