import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantrily/shared/size_config.dart';

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: () {
        print("Adding new category");
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFe6a44e),
                borderRadius: BorderRadius.circular(defaultSize * 1.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/add.svg",
                    width: 18,
                    color: Colors.white,
                  ),
                  SizedBox(width: defaultSize * 1.5),
                  Text(
                    "Create New Category",
                    style: TextStyle(
                        color: Colors.white, fontSize: defaultSize * 2),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: defaultSize * 10,
          ),
        ],
      ),
    );
  }
}
