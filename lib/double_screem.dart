import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutterapp2/bloc/Double.dart';

class DoubleScreen extends StatefulWidget {
  @override
  _DoubleScreenState createState() => _DoubleScreenState();
}

class _DoubleScreenState extends State<DoubleScreen> {
  DoubleBloc _block = DoubleBloc();

  @override
  void initState() {
    super.initState();
    _block.sendEvent.add(FetchEvent());
  }

  @override
  void dispose() {
    _block.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Double Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
                stream: _block.couterStream,
                // initialData: 0,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'Button 1',
            onPressed: () {
              _block.sendEvent.add(DoubleEvent());
            },
            tooltip: 'multiplier',
            child: Icon(Icons.trending_up),
          ),
          SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            heroTag: 'Button 2',
            onPressed: () {
             _block.sendEvent.add(ClearEvent());
            },
            tooltip: 'clear',
            child: Icon(Icons.clear),
          )
        ],
      ),
    );
  }
}
