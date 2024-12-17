import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SkeletonCategory extends StatelessWidget {
  const SkeletonCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const Gap(20),
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const Gap(8),
            Container(
              width: 55,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
