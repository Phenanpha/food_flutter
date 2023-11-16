import 'package:flutter/material.dart';
import 'package:food_flutter/models/food.dart';
import 'package:food_flutter/repositories/food_repository.dart';
import 'package:food_flutter/screens/test/food_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<food>? _toilets;
  var _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    getfood();
  }

  getfood() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var food = await foodRepository().getfood();
      debugPrint('Number of food: ${food.length}');

      setState(() {
        _food= food;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()));

    buildError() => Center(
        child: Padding(
            padding: const EdgeInsets.all(40.0),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(_errorMessage ?? '', textAlign: TextAlign.center),
              SizedBox(height: 32.0),
              ElevatedButton(onPressed: getfood, child: Text('Retry'))
            ])));



    return Scaffold(
        appBar: AppBar(
          title: Text('สูตรอาหาร'),
        ),
        body: Stack(
          children: [
            if (_errorMessage != null) buildError(),
            if (_isLoading) buildLoadingOverlay()
          ],
        ));
  }
}
