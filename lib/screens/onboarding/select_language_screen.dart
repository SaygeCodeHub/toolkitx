import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/root/root_screen.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/language/language_bloc.dart';
import '../../blocs/language/language_events.dart';
import '../../blocs/language/language_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import 'select_time_zone_screen.dart';
import '../../widgets/error_section.dart';
import '../../widgets/generic_loading_popup.dart';
import 'widgets/select_language_body.dart';

class SelectLanguageScreen extends StatelessWidget {
  static const routeName = 'SelectLanguageScreen';
  final bool isFromProfile;

  const SelectLanguageScreen({Key? key, this.isFromProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<LanguageBloc>()
        .add(FetchLanguages(isFromProfile: isFromProfile));
    return Scaffold(
        appBar: AppBar(
            title: Text((isFromProfile == true)
                ? DatabaseUtil.getText('LanguageTanslate')
                : StringConstants.kSelectYourLanguage),
            titleTextStyle: Theme.of(context).textTheme.mediumLarge),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocConsumer<LanguageBloc, LanguageStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is LanguagesFetching ||
                    currentState is LanguagesFetched ||
                    currentState is LanguagesError,
                listener: (context, state) {
                  if (state is LanguageKeysFetching) {
                    GenericLoadingPopUp.show(
                        context, StringConstants.kInitializingLanguage);
                  }
                  if (state is LanguageKeysFetched) {
                    GenericLoadingPopUp.dismiss(context);
                    if (state.isFromProfile == true) {
                      Navigator.pushNamed(context, RootScreen.routeName,
                          arguments: false);
                    } else {
                      Navigator.pushNamed(
                          context, SelectTimeZoneScreen.routeName,
                          arguments: false);
                    }
                  }
                  if (state is LanguageKeysError) {
                    GenericLoadingPopUp.dismiss(context);
                    showCustomSnackBar(
                        context,
                        StringConstants.kSelectLanguageAgain,
                        StringConstants.kOk);
                  }
                  if (state is CheckingNewLanguageKeys) {
                    ProgressBar.show(context);
                  }
                  if (state is NewLanguageKeysUnavailable) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, 'No new keys available', '');
                  }
                  if (state is NewKeysLanguageAvailable) {
                    ProgressBar.dismiss(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AndroidPopUp(
                              titleValue:
                                  DatabaseUtil.getText('ApproveLotoTitle'),
                              contentValue:
                                  'Language file doesnt exist or an old version. please download the language file',
                              onPrimarybtn: () {
                                context.read<LanguageBloc>().add(
                                    FetchLanguageKeys(
                                        isFromProfile: true,
                                        languageId: state.languageId,
                                        syncDate: state.syncDate));
                              });
                        });
                  }
                },
                builder: (context, state) {
                  if (state is LanguagesFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LanguagesFetched) {
                    return SelectLanguageBody(
                        getLanguagesData: state.languagesModel.data!,
                        isFromProfile: isFromProfile);
                  } else if (state is LanguagesError) {
                    return Center(
                        child: GenericReloadButton(
                            onPressed: () {
                              context.read<LanguageBloc>().add(
                                  FetchLanguages(isFromProfile: isFromProfile));
                            },
                            textValue: StringConstants.kReload));
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
