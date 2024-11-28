import 'package:provider/provider.dart';
import 'package:todolists/providers/listprovider.dart';
import 'dart:math' as math;

bool _isFetched = true;
List<int> randomColor = [];

randomColorGenerator(context) {
  if ((Provider.of<ListProvider>(context, listen: false).getTodos).length + 2 >
      100) {
    _isFetched = true;
  }
  if (_isFetched == true) {
    for (var i = 0; i < 100; i++) {
      randomColor.add((math.Random().nextDouble() * 0xFFFFFF).toInt());
    }
    Provider.of<ListProvider>(context, listen: false)
        .setRandomColor(randomColor);
    _isFetched = false;
  }
}
