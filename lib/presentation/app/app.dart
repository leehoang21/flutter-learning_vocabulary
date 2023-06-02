import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/constants/language_constants.dart';
import '../../common/constants/layout_constants.dart';
import '../../common/constants/strings/string_constants.dart';
import '../../common/di/di.dart';
import '../../themes/themes.dart';
import '../bloc/language_bloc/language_bloc.dart';
import '../bloc/loading_bloc/loading_bloc.dart';
import '../bloc/snackbar_bloc/snackbar_bloc.dart';
import '../routers/app_router.dart';
import '../ui/widgets/loading_widget/loading_container_widget.dart';
import '../ui/widgets/snackbar_widget/snackbar_widget.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;
    return ScreenUtilInit(
      designSize: const Size(
        LayoutConstants.widthDefault,
        LayoutConstants.heightDefault,
      ),
      builder: (context, child) => GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => getIt.get<LanguageBloc>(),
            ),
            BlocProvider(
              create: (_) => getIt.get<LoadingBloc>(),
            ),
            BlocProvider(
              create: (_) => getIt.get<SnackbarBloc>(),
            )
          ],
          child: MaterialApp.router(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              localizationDelegate,
            ],
            title: StringConstants.appTitle,
            locale: localizationDelegate.currentLocale,
            supportedLocales: const [
              Locale(LanguageConstants.en),
              Locale(LanguageConstants.vi)
            ],
            routerConfig: _appRouter.config(),
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            theme: appTheme(),
            builder: (context, widget) {
              return LoadingContainerWidget(
                child: _buildBlocListener(widget ?? const SizedBox(), context),
              );
            },
          ),
        ),
      ),
    );
  }

  BlocListener<SnackbarBloc, SnackbarState> _buildBlocListener(
      Widget widget, BuildContext context) {
    return BlocListener<SnackbarBloc, SnackbarState>(
      listener: (context, state) {
        if (state is ShowSnackBarState) {
          TopSnackBar(
            title: translate(state.translationKey ?? ''),
            type: state.type ?? SnackBarType.success,
            key: state.key,
          ).showWithNavigator(
              _appRouter.navigatorKey.currentState ?? NavigatorState(),
              context);
        }
      },
      child: widget,
    );
  }
}
