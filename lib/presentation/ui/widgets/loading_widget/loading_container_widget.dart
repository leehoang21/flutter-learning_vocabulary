import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/loading_bloc/loading_bloc.dart';
import 'loader_widget.dart';

class LoadingContainerWidget extends StatelessWidget {
  final Widget child;

  const LoadingContainerWidget({Key? key, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        BlocBuilder<LoadingBloc, LoadingState>(
          builder: (context, state) {
            return Visibility(
              visible: state.status == LoadingStatus.loading,
              child: const Center(
                child: LoaderWidget(),
              ),
            );
          },
        )
      ],
    );
  }
}
