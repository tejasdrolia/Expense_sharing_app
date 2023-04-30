
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Sharing',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ExpenseScreen(),
    );
  }
}

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tejasExpenseController = TextEditingController();
  final TextEditingController _vihaanExpenseController = TextEditingController();

  double _tejasExpense = 0;
  double _vihaanExpense = 0;

  void _showExpenseDialog() async {
    List<dynamic>? expenseDetails = await showDialog<List<dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              TextField(
                controller: _tejasExpenseController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tejas Expense',
                ),
              ),
              TextField(
                controller: _vihaanExpenseController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Vihaan Expense',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                double tejasExpense = double.tryParse(_tejasExpenseController.text) ?? 0;
                double vihaanExpense = double.tryParse(_vihaanExpenseController.text) ?? 0;
                String description = _descriptionController.text;
                addExpense(tejasExpense, vihaanExpense, description);
                _tejasExpenseController.clear();
                _descriptionController.clear();
                _vihaanExpenseController.clear();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );

    if (expenseDetails != null) {
      setState(() {
        _tejasExpense += expenseDetails[0];
        _vihaanExpense += expenseDetails[1];
      });
    }
  }

  void addExpense(double tejasExpense, double vihaanExpense, String description) {
    if (tejasExpense >= 0 && vihaanExpense >= 0) {
      Navigator.pop(context, [tejasExpense, vihaanExpense, description]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Expense Sharing'),
    centerTitle: true,
    ),
    body: Padding(
    padding: EdgeInsets.all(10),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    Expanded(
    child: Card(
    color: Colors.purple[100],
    child: Column(
    children: [
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    'Tejas',
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    SizedBox(height: 20),
    Text(
    '\$${_tejasExpense.toStringAsFixed(2)}',
    style: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.purple[700],
    ),),
    ],
    ),
    ),
    ),
      Expanded(
        child: Card(
          color: Colors.purple[100],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Vihaan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '\$${_vihaanExpense.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[700],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
    ),
      SizedBox(height: 50),
      ElevatedButton(
        onPressed: _showExpenseDialog,
        child: Text('Add Expense'),
      ),
    ],
    ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _tejasExpense = 0;
            _vihaanExpense = 0;
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

