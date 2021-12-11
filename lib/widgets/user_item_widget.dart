import 'package:family_space_flutter/text_styles.dart';
import 'package:flutter/material.dart';

class UserItemWidget extends StatelessWidget {
  final String avatar;
  final String name;
  final VoidCallback? onTap;
  final bool lowBattery;
  final DateTime fromTime;

  const UserItemWidget({
    Key? key,
    required this.avatar,
    required this.name,
    this.onTap,
    this.lowBattery = false,
    required this.fromTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF2F4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 48,
                width: 48,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: SizedBox(
                        child: Image.network(avatar),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          color: Color(lowBattery ? 0xFFE86303 : 0xFF65FABC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyles.h3,
                      ),
                      if (lowBattery)
                        Text(
                          'Низкий заряд батареи',
                          style: TextStyles.subText.copyWith(
                            color: const Color(0xFFE86303),
                          ),
                        ),
                      Text(
                        'Тут с ${fromTime.hour}:${fromTime.minute}',
                        style: TextStyles.subText,
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
