import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/language/language_bloc.dart';
import '../../../blocs/language/language_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/language/languages_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';

class SelectLanguageBody extends StatelessWidget {
  final List<GetLanguagesData> getLanguagesData;
  final bool isFromProfile;

  const SelectLanguageBody(
      {super.key, required this.getLanguagesData, required this.isFromProfile});

  @override
  Widget build(BuildContext context) {
    return SearchableList(
        initialList: getLanguagesData,
        // ignore: deprecated_member_use
        builder: (List<GetLanguagesData> getLanguagesData, int index,
            GetLanguagesData languageData) {
          return Padding(
              padding: const EdgeInsets.only(bottom: xxTinierSpacing),
              child: CustomCard(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kCardRadius)),
                  child: ListTile(
                      onTap: () {
                        context.read<LanguageBloc>().add(FetchLanguageKeys(
                            languageId: languageData.id.toString(),
                            isFromProfile: isFromProfile));
                      },
                      minVerticalPadding: kLanguagesTileHeight,
                      leading: CachedNetworkImage(
                          height: kLanguageFlagHeight,
                          imageUrl:
                              '${ApiConstants.baseUrlFlag}${languageData.flagName}',
                          placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: AppColor.paleGrey,
                              highlightColor: AppColor.white,
                              child: Container(
                                  height: kLanguageFlagHeight,
                                  width: kLanguageFlagWidth,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius:
                                          BorderRadius.circular(kCardRadius)))),
                          errorWidget: (context, url, error) => const Icon(
                              Icons.error_outline_sharp,
                              size: kIconSize)),
                      title: Text(languageData.langName))));
        },
        emptyWidget: Text(DatabaseUtil.getText('no_records_found')),
        filter: (value) => getLanguagesData
            .where((element) => element.langName
                .toLowerCase()
                .contains(value.toLowerCase().trim()))
            .toList(),
        inputDecoration: InputDecoration(
            suffix: const SizedBox(),
            suffixIcon: const Icon(Icons.search_sharp, size: kIconSize),
            hintStyle: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey),
            hintText: StringConstants.kSearchLanguage,
            contentPadding: const EdgeInsets.all(xxxTinierSpacing),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            filled: true,
            fillColor: AppColor.white));
  }
}
