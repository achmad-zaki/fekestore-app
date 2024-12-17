import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget _getIconForCategory(String category) {
  switch (category.toLowerCase()) {
    case "electronics":
    return Icon(Icons.electrical_services_outlined, color: Colors.amber.shade800,);
    case "jewelery":
    return Icon(Icons.diamond_outlined, color: Colors.blue.shade200,);
    case "men's clothing":
    return Icon(Icons.male_rounded, color: Colors.blue.shade800,);
    case "women's clothing":
    return Icon(Icons.female_rounded, color: Colors.pink.shade500,);
    default:
    return Icon(Icons.dashboard, color: Colors.pink.shade500,);
  }
}

class ItemCategory extends StatelessWidget {
  final String categoryName;
  
  const ItemCategory({required this.categoryName, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFFF7F8FC),
            borderRadius: BorderRadius.circular(50),
          ),
          child: _getIconForCategory(categoryName),
        ),
        const Gap(4),
        Text(
          categoryName.toUpperCase(),
          style: TextStyle(
              color: Color(0xFF81838E),
              fontSize: 10,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
