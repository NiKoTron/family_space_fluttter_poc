import 'package:family_space_flutter/text_styles.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final String title;
  final String description;

  const BannerWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF2F4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/images/star.png',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyles.h3,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          description,
                          style: TextStyles.body,
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(Icons.close),
              ],
            ),
          ),
        ),
      );
}
