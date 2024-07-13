import 'package:expense_care/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../categories_list.dart';
import '../color_extension.dart';
import '../database/database.dart';
import '../providers/expense_provider.dart';
import 'package:drift/drift.dart' as drift;

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}


class _AddExpenseState extends State<AddExpense> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String choosedCategoryImage='assets/images/food.png';
  String choosedCategoryName='Food';


  void chooseCategoryBottomSheet(){
    showModalBottomSheet(
        context: context,
        backgroundColor: TColor.black3,
        builder: (context){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Select Category',
                  style: TextStyle(
                    fontSize: 25,
                    color: TColor.white3,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: categoriesType.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3) ,
                    itemBuilder: (context,index){
                      final categories= categoriesType[index];
                      final image= categories['imageUrl'];
                      return Column(
                        children: [
                          // Text('data')
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                choosedCategoryName= categories['title'].toString();
                                choosedCategoryImage= image;
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: TColor.black5
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  image: AssetImage(image as String),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            categories['title'].toString(),
                            style: TextStyle(
                              color: TColor.white1
                            ),
                          )
                        ],
                      );
                    }
                ),
              )
            ],
          );
        }
    );
  }

  void addExpense() {
    final description = descriptionController.text;
    final amount = double.tryParse(amountController.text);
    final dateTime = DateTime.now();

    if (description.isNotEmpty && amount!=null && amount > 0.0) {

      final expense = ExpensesCompanion(
        category :  drift.Value(choosedCategoryName),
        categoryImageUrl : drift.Value(choosedCategoryImage),
        description : drift.Value(description),
        amount : drift.Value(amount),
        date : drift.Value(dateTime),
        time : drift.Value(dateTime)
      );

      Provider.of<ExpenseProvider>(context, listen: false).addExpense( expense ).then(
              (_){
                descriptionController.clear();
                amountController.clear();
                setState(() {
                  choosedCategoryName = 'Food';
                  choosedCategoryImage = 'assets/images/food.png';
                });
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     duration: const Duration(seconds: 10),
                //     margin: const EdgeInsets.all(20),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30)
                //     ),
                //     behavior: SnackBarBehavior.floating,
                //     content: Text(
                //       'Expense added successfully!',
                //       style: TextStyle(
                //         color: TColor.black1
                //       ),
                //     ),
                //     backgroundColor: TColor.blue1,
                //   ),
                // );
              }
            );
    }
  }

  @override
  Widget build(BuildContext context) {

      final borderDesign= OutlineInputBorder(
        borderSide: BorderSide(
          color: TColor.cyan3,
          width: 1.5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10))
    );

    return Container(
      padding: const EdgeInsets.all(30),
      decoration:  BoxDecoration(
        color: TColor.black4,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Text('Click to choose category',
                style: TextStyle(
                    fontSize: 16,
                    color: TColor.white5
                ),
              ),
            ),
            GestureDetector(
              onTap: chooseCategoryBottomSheet ,
              child: Card(
                  color: TColor.black2,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  shadowColor: TColor.cyan3,
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image(
                            image: AssetImage(choosedCategoryImage),
                          ),
                        )
                      ),
                      const SizedBox(height: 15,),
                      Text(
                        choosedCategoryName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: TColor.white3
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  )
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: descriptionController,
              cursorColor: TColor.white2,
              minLines: 1,
              maxLines: 2,
              style: TextStyle(
                  color: TColor.white3
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: TColor.black2,
                label:  Text('Description',style: TextStyle(color: TColor.white7),),
                floatingLabelStyle: TextStyle(
                    color: TColor.white7
                ),
                focusedBorder:borderDesign,
                enabledBorder: borderDesign,
              ),
            ),
            const SizedBox(height: 30.0),
            TextField(
              controller: amountController,
              cursorColor: TColor.white4,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: TColor.white3
              ),
              decoration:  InputDecoration(
                label:  Text('Amount', style: TextStyle(color: TColor.white7),),
                floatingLabelStyle: TextStyle(
                    color: TColor.white7
                ),
                filled: true,
                fillColor:TColor.black2,
                prefixIcon: const Icon(Icons.currency_rupee),
                prefixIconColor: Colors.green,
                focusedBorder:borderDesign,
                enabledBorder: borderDesign,
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: addExpense,
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shadowColor: TColor.cyan3,
                backgroundColor: TColor.black1,
                foregroundColor: TColor.white2,
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
              label: const Text('Add')
            )
          ],
        ),
      ),
    );
  }
}
