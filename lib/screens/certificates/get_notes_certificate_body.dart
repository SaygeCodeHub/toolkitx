import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:pod_player/pod_player.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/certificates/get_notes_certificate_model.dart';
import 'package:toolkit/utils/certificate_notes_type_util.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import '../../utils/constants/api_constants.dart';

class GetNotesCertificateBody extends StatefulWidget {
  const GetNotesCertificateBody(
      {super.key,
      required this.data,
      required this.pageNo,
      required this.clientId});

  final GetNotesData data;
  final int pageNo;
  final String clientId;

  @override
  State<GetNotesCertificateBody> createState() =>
      _GetNotesCertificateBodyState();
}

class _GetNotesCertificateBodyState extends State<GetNotesCertificateBody> {
  late final PodPlayerController podPlayerController;
  final videoTextFieldCtr = TextEditingController();

  @override
  void initState() {
    podPlayerController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(
        "${ApiConstants.baseDocUrl}${widget.data.link}&code=${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}",
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    podPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var link =
        '${ApiConstants.viewDocBaseUrl}${widget.data.link}&code=${RandomValueGeneratorUtil.generateRandomValue(CacheKeys.clientId)}';
    var unescape = HtmlUnescape();
    var htmlText = unescape.convert(widget.data.description);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CertificateNotesTypeUtil().fetchSwitchCaseWidget(widget.data.type,
              widget.data, htmlText, link, podPlayerController, widget.clientId)
        ],
      ),
    );
  }
}
