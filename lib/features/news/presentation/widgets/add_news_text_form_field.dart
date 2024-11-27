import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class AddNewsTextFormField extends StatelessWidget {
  const AddNewsTextFormField({
    super.key,
    required this.identifiedAs,
    required this.controller,
  });

  final String identifiedAs;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType(),
      validator: validator(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText(),
        hintStyle: StyleText().openSansNormalBlack,
      ),
      minLines: 1,
      maxLines: maxLines(),
    );
  }

  validator() {
    return (value) {
      if(value == ""){
        return "Harap diisi, tidak boleh kosong";
      }
    };
  }

  hintText() {
    if (identifiedAs == "title") {
      return "Tulis judul di sini....";
    }
    if (identifiedAs == "content") {
      return "Tulis konten berita di sini....";
    }
  }

  textInputAction() {
    if (identifiedAs == "title") {
      return TextInputAction.next;
    }
    if (identifiedAs == "content") {
      return TextInputAction.none;
    }
  }

  keyboardType() {
    if (identifiedAs == "title") {
      return TextInputType.text;
    }
    if (identifiedAs == "content") {
      return TextInputType.multiline;
    }
  }

  maxLines() {
    if (identifiedAs == "title") {
      return 2;
    }
    if (identifiedAs == "content") {
      return 10;
    }
  }
}
