import 'package:flutter/material.dart';
import 'package:pantrily/models/FoodItem.dart';
import 'package:pantrily/models/user.dart';
import 'package:pantrily/screens/add/components/add_item_form.dart';
import 'package:pantrily/screens/recipes/components/add_ingredient_details.dart';
import 'package:pantrily/services/database.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class FoodItemCard extends StatelessWidget {
  const FoodItemCard({Key key, this.foodItem, this.isRecipeForm})
      : super(key: key);

  final FoodItem foodItem;
  final bool isRecipeForm;
  // final Function addItem;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    void addItem() {
      DatabaseService(uid: user.uid).addPantryItem(
        foodId: foodItem.foodId,
        label: foodItem.label,
        imgSrc: foodItem.imgSrc,
        category: foodItem.category,
        area: "Fridge",
        count: 1,
      );
    }

    void _showAddItemForm() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: AddItemForm(foodItem: foodItem),
              ),
            );
          });
    }

    void _showAddIngredientDetails() {
      Navigator.of(context).pop();
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: AddIngredientDetails(
                foodItem: foodItem,
              ),
            );
          });
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          color: Colors.grey[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: 75.0,
                  height: 75.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(foodItem.imgSrc ??
                            "https://drive.google.com/uc?id=1FXtI6_dvW_YjtRjN9B7qq3yNkweqMwfH"),
                      )),
                ),
              ),
              SizedBox(
                width: SizeConfig.defaultSize * (isRecipeForm ? 20 : 25),
                height: SizeConfig.defaultSize * 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      foodItem.label,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      foodItem.category,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: isRecipeForm
                      ? _showAddIngredientDetails
                      : _showAddItemForm)
            ],
          ),
        ),
      ),
    );
  }
}
