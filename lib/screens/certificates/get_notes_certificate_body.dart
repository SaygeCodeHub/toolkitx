import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/data/models/certificates/get_notes_certificate_model.dart';

class GetNotesCertificateBody extends StatelessWidget {
  const GetNotesCertificateBody(
      {super.key, required this.data, required this.pageNo});
  final GetNotesData data;
  final int pageNo;

  @override
  Widget build(BuildContext context) {
    var unescape = HtmlUnescape();
    var text = unescape.convert(data.description);
    bool visible = true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: pageNo == 3 ? visible : !visible,
          child: SizedBox(
            height: 500,
            width: 380,
            child: Html(
              shrinkWrap: true,
              data: text,
            ),
          ),
        ),
        Visibility(
          visible: pageNo != 3 ? visible : !visible,
          child: Container(
            height: 300,
            width: 380,
            color: AppColor.blueGrey,
            child: Container(
              child: Text(''),
            ),
          ),
        )
      ],
    );
  }
}
