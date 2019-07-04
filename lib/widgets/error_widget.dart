import 'package:flutter/material.dart';

class StreamErrorWidget extends StatelessWidget {
  final List<String> message;

  const StreamErrorWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/images/no_internet.png'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Woops, something went wrong...',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Libre_Franklin'),
            ),
          ),
          Text(
            message.join('\n'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17.0, fontFamily: 'Libre_Franklin'),
          ),
        ],
      ),
    );
  }
}
