import 'package:flutter/material.dart';

import './counter_app.dart';
import './utils/utils.dart';

void main() {
  runApp(CounterApp(
    blocHandler: BlocHandler(),
  ));
}
