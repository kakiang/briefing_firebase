import 'dart:async';

import 'package:briefing/bloc/bloc_provider.dart';
import 'package:briefing/model/article.dart';
import 'package:briefing/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

class ArticleBloc extends BlocBase {
  final _repository = Repository();
  final durationSubject = BehaviorSubject<int>.seeded(24);
  final descendingSubject = BehaviorSubject<bool>.seeded(false);

  ArticleBloc();

  ValueObservable<bool> get descendingStream => descendingSubject.stream;

  ValueObservable<int> get durationStream => durationSubject.stream;

  Sink<bool> get descendingSink => descendingSubject.sink;

  Sink<int> get durationSink => durationSubject.sink;

  Stream<List<Article>> get articlesStream => _repository.lastArticles(
      hours: durationStream.value, descending: descendingStream.value);

  @override
  void dispose() {
    durationSubject.close();
    descendingSubject.close();
  }
}
