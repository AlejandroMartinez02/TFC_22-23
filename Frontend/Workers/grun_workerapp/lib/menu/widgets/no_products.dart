import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/widgets/not_found_page.dart';

class NoProducts extends StatelessWidget {
  const NoProducts({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
        child: const NotFoundPage(
          message: Constants.noProducts,
        ));
  }
}
