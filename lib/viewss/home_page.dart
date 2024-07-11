import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftips_bloc_fetch_api/bloc/bottom_bloc.dart';
import 'package:ftips_bloc_fetch_api/bloc/top_bloc.dart';
import 'package:ftips_bloc_fetch_api/models/constants.dart';
import 'package:ftips_bloc_fetch_api/viewss/app_bloc_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => TopBloc(
                  waitBeforeLoading: const Duration(seconds: 3), urls: images),
            ),
            BlocProvider<BottomBloc>(
              create: (_) => BottomBloc(
                  waitBeforeLoading: const Duration(seconds: 3), urls: images),
            ),
          ],
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AppBlocView<TopBloc>(),
              AppBlocView<BottomBloc>(),
            ],
          ),
        ),
      ),
    );
  }
}
