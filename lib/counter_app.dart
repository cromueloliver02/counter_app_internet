import 'package:flutter/material.dart';

import './cubits/cubits.dart';
import './utils/utils.dart';
import './constants/constants.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({
    super.key,
    required this.blocHandler,
  });

  final BlocHandler blocHandler;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocHandler.blocProviders,
      child: MaterialApp(
        title: 'Internet Counter App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<InternetCubit, InternetState>(
                  builder: (ctx, state) => RichText(
                    text: TextSpan(
                      text: state is InternetConnected
                          ? 'Connected: '
                          : 'Disconnected',
                      style: TextStyle(
                        color: state is InternetConnected
                            ? Colors.green
                            : Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        if (state is InternetConnected)
                          TextSpan(
                            text: state.connectionType == ConnectionType.wifi
                                ? 'Wi-Fi'
                                : 'Mobile Data',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                BlocBuilder<CounterCubit, CounterState>(
                  builder: (ctx, state) => Text(
                    '${state.count}',
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
