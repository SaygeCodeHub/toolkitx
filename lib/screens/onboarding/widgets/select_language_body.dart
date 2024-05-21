import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../../blocs/language/language_bloc.dart';
import '../../../blocs/language/language_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/language/languages_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';

class SelectLanguageBody extends StatefulWidget {
  final List<GetLanguagesData> getLanguagesData;
  final bool isFromProfile;

  const SelectLanguageBody({
    super.key,
    required this.getLanguagesData,
    required this.isFromProfile,
  });

  @override
  SelectLanguageBodyState createState() => SelectLanguageBodyState();
}

class SelectLanguageBodyState extends State<SelectLanguageBody> {
  late TextEditingController _searchController;
  late List<GetLanguagesData> _filteredLanguagesData;
  bool _isSearchActive = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredLanguagesData = widget.getLanguagesData;
  }

  void _filterLanguages() {
    setState(() {
      _filteredLanguagesData = widget.getLanguagesData
          .where((element) => element.langName
              .toLowerCase()
              .contains(_searchController.text.toLowerCase().trim()))
          .toList();
      _isSearchActive = true;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _filteredLanguagesData = widget.getLanguagesData;
      _isSearchActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.63,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(color: AppColor.grey),
                  hintText: StringConstants.kSearchLanguage,
                  contentPadding: const EdgeInsets.all(xxxTinierSpacing),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.lightGrey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.lightGrey),
                  ),
                  filled: true,
                  fillColor: AppColor.white,
                ),
              ),
            ),
            const SizedBox(width: xxTinierSpacing),
            Expanded(
              child: PrimaryButton(
                onPressed: _isSearchActive ? _clearSearch : _filterLanguages,
                textValue: _isSearchActive
                    ? StringConstants.kClear
                    : StringConstants.kSearch,
              ),
            ),
          ],
        ),
        const SizedBox(height: xxTinierSpacing),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: tiniestSpacing),
            child: ListView.separated(
              itemCount: _filteredLanguagesData.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomCard(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kCardRadius)),
                  child: ListTile(
                    onTap: () {
                      context.read<LanguageBloc>().add(FetchLanguageKeys(
                          languageId:
                              _filteredLanguagesData[index].id.toString(),
                          isFromProfile: widget.isFromProfile));
                    },
                    minVerticalPadding: kLanguagesTileHeight,
                    leading: CachedNetworkImage(
                      height: kLanguageFlagHeight,
                      imageUrl:
                          '${ApiConstants.baseUrlFlag}${_filteredLanguagesData[index].flagName}',
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: AppColor.paleGrey,
                        highlightColor: AppColor.white,
                        child: Container(
                          height: kLanguageFlagHeight,
                          width: kLanguageFlagWidth,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(kCardRadius),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline_sharp,
                          size: kIconSize),
                    ),
                    title: Text(_filteredLanguagesData[index].langName),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: xxTinierSpacing);
              },
            ),
          ),
        ),
      ],
    );
  }
}
