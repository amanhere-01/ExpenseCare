import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';
import '../data/categories_list.dart';
import '../data/color_list.dart';
import '../database/database.dart';
import '../providers/expense_provider.dart';

class EditExpense extends StatefulWidget {
  final Expense expense;
  const EditExpense({super.key, required this.expense});

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  late TextEditingController descriptionController;
  late TextEditingController amountController ;
  late String choosedCategoryImage;
  late String choosedCategoryName;

  @override
  void initState(){
    super.initState();
    descriptionController = TextEditingController(text: widget.expense.description);
    amountController =  TextEditingController(text: widget.expense.amount.toString());
    choosedCategoryImage= widget.expense.categoryImageUrl;
    choosedCategoryName = widget.expense.category;
  }

  void chooseCategoryBottomSheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      backgroundColor: TColor.black5,
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
                              color: TColor.black1
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

  void saveChanges(BuildContext context){
    final description = descriptionController.text;
    final amount = double.tryParse(amountController.text);
    final dateTime = DateTime.now();

    if (description.isNotEmpty && amount != null) {

      final expense = ExpensesCompanion(
        id: drift.Value(widget.expense.id),
        category :  drift.Value(choosedCategoryName),
        categoryImageUrl : drift.Value(choosedCategoryImage),
        description : drift.Value(description),
        amount : drift.Value(amount),
        date : drift.Value(dateTime),
        time : drift.Value(dateTime)
      );

      Provider.of<ExpenseProvider>(context, listen: false).updateExpense( expense ).then(
              (_){
                FocusScope.of(context).unfocus();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 1),
                    margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    behavior: SnackBarBehavior.floating,
                    content: Center(
                      child: Text(
                        'Edited Successfully!',
                        style: TextStyle(
                          color: TColor.black1,
                        ),
                      ),
                    ),
                    backgroundColor: TColor.black8,
                  ),
                );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    const borderDesign= OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.greenAccent
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
    );

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
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
              onTap: (){chooseCategoryBottomSheet(context);} ,
              child: Card(
                color: TColor.black2,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  shadowColor: Colors.greenAccent,
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
                icon: const Icon(Icons.data_saver_on_rounded),
                onPressed: (){saveChanges(context);},
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shadowColor: Colors.greenAccent,
                  backgroundColor: TColor.black1,
                  foregroundColor: TColor.white2,
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                label: const Text('Save Changes')
            )
          ],
        ),
      ),
    );
  }
}
