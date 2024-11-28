import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../helpers/methods.dart';

class CategorySelectorWidget extends StatelessWidget {
  const CategorySelectorWidget({
    super.key,
    required this.categoryName,
    required this.categoryImgPath,
    required this.isSelected,
    required this.onTap,
  });

  final String categoryName;
  final String categoryImgPath;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isSelected ? whiteColor : greyLightColor,
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? Border.all(
                  color: redDarkColor,
                  width: 2,
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.asset(
                categoryImgPath,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              nameFormater(categoryName),
              style: textStyle(
                fontWeight: FontWeight.w700,
                size: 14,
                color: isSelected ? redDarkColor : blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
