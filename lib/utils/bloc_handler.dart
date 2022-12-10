import 'package:connectivity_plus/connectivity_plus.dart';

import '../cubits/cubits.dart';

class BlocHandler {
  final List<BlocProvider> blocProviders = [
    BlocProvider<InternetCubit>(
      create: (ctx) => InternetCubit(
        connectivity: Connectivity(),
      ),
    ),
    BlocProvider<CounterCubit>(
      create: (ctx) => CounterCubit(
        internetCubit: ctx.read<InternetCubit>(),
      ),
    ),
  ];
}
