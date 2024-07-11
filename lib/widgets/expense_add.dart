import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        builder: (context){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Select Category',
                  style: TextStyle(
                    fontSize: 25,
                    color: TColor.grey1,
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
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(211, 243, 184, 1),
                                borderRadius: BorderRadius.circular(15),
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

    if (description.isNotEmpty && amount != null) {

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
                Navigator.pop(context);
              }
            );
    }
  }

  @override
  Widget build(BuildContext context) {

      final borderDesign= OutlineInputBorder(
        borderSide: BorderSide(
          color: TColor.blue2
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10))
    );

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Text('Click to choose category',
                style: TextStyle(
                    fontSize: 16,
                    color: TColor.secondaryText
                ),
              ),
            ),
            GestureDetector(
              onTap: chooseCategoryBottomSheet ,
              child: Card(
                  color: TColor.blue,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  shadowColor: Colors.blue,
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
                          color: TColor.text
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
              cursorColor: TColor.grey1,
              minLines: 1,
              maxLines: 2,
              decoration: InputDecoration(
                filled: true,
                fillColor: TColor.blue,
                label: const Text('Description'),
                floatingLabelStyle: TextStyle(
                    color: TColor.grey1
                ),
                focusedBorder:borderDesign,
                enabledBorder: borderDesign,
              ),
            ),
            const SizedBox(height: 30.0),
            TextField(
              controller: amountController,
              cursorColor: TColor.grey1,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                label: const Text('Amount'),
                floatingLabelStyle: TextStyle(
                    color: TColor.grey1
                ),
                filled: true,
                fillColor:TColor.blue,
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
                backgroundColor: TColor.blue,
                foregroundColor: Colors.black,
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
