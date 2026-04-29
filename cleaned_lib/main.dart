import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/deals/bloc/deal_bloc.dart';
import 'features/interests/bloc/interest_bloc.dart';
import 'data/repositories/deal_repository.dart';
void main() {
  runApp(const MyAppRoot());
}
class MyAppRoot extends StatelessWidget {
  const MyAppRoot({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dealRepository = DealRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        BlocProvider<DealBloc>(
          create: (_) => DealBloc(DealRepository()),
        ),
        BlocProvider<InterestBloc>(
          create: (context) => InterestBloc(context.read<DealBloc>()),
        ),
      ],
      child: const MyApp(),
    );
  }
}