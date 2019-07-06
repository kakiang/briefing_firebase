import 'package:briefing/bloc/bloc_provider.dart';
import 'package:briefing/model/channel.dart';
import 'package:briefing/provider/repository.dart';

class ChannelBloc implements BlocBase {
  final _repository = Repository();

  ChannelBloc();

  Stream<List<Channel>> get channelStream => _repository.getChannels();

  @override
  void dispose() {}
}
