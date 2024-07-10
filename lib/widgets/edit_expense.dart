import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';
import '../categories_list.dart';
import '../color_extension.dart';
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
            Navigator.pop(context);
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
      decoration:  const BoxDecoration(
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
              onTap: (){chooseCategoryBottomSheet(context);} ,
              child: Card(
                  // color: TColor.white2,
                color: TColor.lightGreen,
                  elevation: 5,
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
                fillColor: TColor.lightGreen,
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
                fillColor: TColor.lightGreen,
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
                  backgroundColor: TColor.lightGreen,
                  foregroundColor: Colors.black,
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
