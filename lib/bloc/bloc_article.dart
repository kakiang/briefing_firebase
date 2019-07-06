import 'dart:async';

import 'package:briefing/bloc/bloc_provider.dart';
import 'package:briefing/model/article.dart';
import 'package:briefing/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

class ArticleBloc extends BlocBase {
  final _repository = Repository();
  final durationSubject = BehaviorSubject<int>.seeded(24);

  ArticleBloc() {
//    durationStream.listen((duration) {
//      old = duration;
//    });
  }

  Sink<int> get durationSink => durationSubject.sink;

  Stream<int> get durationStream => durationSubject.stream;

  Stream<List<Article>> get articlesStream =>
      _repository.lastArticles(hours: durationSubject.stream.value);

  @override
  void dispose() {
    durationSubject.close();
  }
}
