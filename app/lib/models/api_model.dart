import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/size_config.dart';

class ApiModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: FoodSearchScreen(),
      bottomNavigationBar: MyBottomNavBar(),
      backgroundColor: Colors.teal[50],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      backgroundColor: Colors.teal.shade600,
      // On Android by default its false
      centerTitle: true,
      title: Image.asset("assets/images/Logo Preview 1.png"),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        SizedBox(
          // It means 5 because by out defaultSize = 10
          width: SizeConfig.defaultSize * 0.5,
        ),
      ],
    );
  }
}

class FoodSearchScreen extends StatefulWidget {
  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  TextEditingController _inputController = TextEditingController();
  List<dynamic> _responseText = [];
  List<Widget> _filteredRecipes = [];

  Future<List<dynamic>?> _makeAPIRequest(String prompt) async {
    // Replace 'YOUR_BEARER_TOKEN' with your actual bearer token
    var bearerToken = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI1N1R4M2FWRzR0N0Q5YW00TDlod1VHR2tPVVlvOUpwVFd1VTNmTWxrY1lBIn0.eyJleHAiOjE3MDAyNzY4MDAsImlhdCI6MTcwMDI3NjUwMCwianRpIjoiYmU3YjVjYzctNzg4Zi00ZjM5LWI5NjEtNTZiNDUwMTNjMDNkIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2F1dGgvcmVhbG1zL2Jvb3RhZG1pbiIsImF1ZCI6WyJhcHAtYWRtaW4iLCJhcHAtdG9kbyIsImFjY291bnQiXSwic3ViIjoiMmEzNzU0NzAtMjU4Ni00MDM4LWEzODUtMTY1OGMxOGVjMTJhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiYXBwLWltcyIsInNlc3Npb25fc3RhdGUiOiJiMmI5ZGRjMS00Y2JmLTQxMzMtYWUxZC1lY2ZhNTQ0OTA2ODciLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhcHAtYWRtaW4iOnsicm9sZXMiOlsiYWRtaW4iXX0sImFwcC10b2RvIjp7InJvbGVzIjpbImFkbWluIiwidXNlciJdfSwiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJvcGVuaWQgZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicHJlZmVycmVkX3VzZXJuYW1lIjoiZm9ya2l0LWhhY2thdGhvbiJ9.bcFJVqkOvJs3LvAuxQtmsHQWW_MqV5_cyY6TdRKziKlWbNfhh5qGrHHo8gzcOT2QCF30fI1arJ-ylrRn6k3QoBnldquFZZnPIHDBxbddwnIvj0EgdPck2RxOEv_iRkPhIT7vqbQLg0WciOkpqsfQU4MqswXAC6Wd1SN0Egx2cT8yWrbWco0mxGt0XS-EPBFgcREVJrX9wsyXy193OxIp-UsftPZSznhXgMjhoyJKi3elOH_HRWmklaN_1ORNUwO-daYKxtBBs8BazQ7FY37cJ5oowxSDlMjm7RgPl_Y3sDA_3-7aeE6DAqokg4FmT7YzQzEnFkgt-GQdVumUmuXo5w";
    var headers = {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    };
    var url = Uri.parse('https://cosylab.iiitd.edu.in/api/recipeDB/search_subregion/$prompt');

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      return responseData;
    } else {
      print("Error: Unable to fetch data.");
      return null;
    }
  }

  List<Widget> _generateRecipeWidgets(List<dynamic> responseText, int caloriesPrompt, int proteinsPrompt) {
    List<Widget> recipeWidgets = [];

    for (var element in responseText) {
      var calories = element["calories"];
      var proteins = element["protein"];

      if (caloriesPrompt == 0 || (calories < caloriesPrompt + 10 && calories > caloriesPrompt - 10)) {
        if (proteinsPrompt == 0 || (proteins < proteinsPrompt + 5 && proteins > proteinsPrompt - 5)) {
          var recipeWidget = _buildRecipeWidget(element);
          recipeWidgets.add(recipeWidget);
        }
      }
    }

    return recipeWidgets;
  }

  void _extractRecipeTitles(List<dynamic> responseText, int caloriesPrompt, int proteinsPrompt) {
    for (var element in responseText) {
      var calories = element["calories"];
      var proteins = element["protein"];
      if (caloriesPrompt == 0 || (calories < caloriesPrompt + 10 && calories > caloriesPrompt - 10)) {
        if ((proteins < proteinsPrompt + 5 && proteins > proteinsPrompt - 5) || proteinsPrompt == 0) {
          var recipe = '''
            ${element['recipe_title']}:\n
            Calories: ${element['calories']}...\n
            Ingredients: ${element["ingredients"]}\n
            Protein: ${element['protein']}\n
            Fats: ${element['fat']}\n
            Energy kcal: ${element['energykcal']}\n
            Carbohydrates by difference: ${element['carbohydratebydifference']}
          ''';
          print(recipe);
          print("-------------------------------------------------------------------------------------------------------------------");
        }
      }
    }
  }

  Widget _buildRecipeWidget(dynamic element) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${element['recipe_title']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Calories: ${element['calories']}',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          'Ingredients: ${element["ingredients"]}',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          'Protein: ${element['protein']}',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          'Fats: ${element['fat']}',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          'Energy kcal: ${element['energykcal']}',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          'Carbohydrates by difference: ${element['carbohydratebydifference']}',
          style: TextStyle(color: Colors.white),
        ),
        // Displaying image fetched from URL
        element.containsKey('img_url')
            ? Image.network(
                element['img_url'],
                width: 200, // Set the width as needed
                height: 200, // Set the height as needed
              )
            : Container(), // Empty container if there is no image URL
        // Text("-------------------------------------------------------------------------------------------------------------------")
        Divider(color: Colors.white, thickness: 3),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    int caloriesPrompt = 0;
    int proteinsPrompt = 0;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Enter specifications",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: "Helvetica, sans-serif",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: "Type here!",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String prompt = _inputController.text.trim();
                
                if (prompt.contains("-")) {
                  var keys = prompt.split("-");
                  if (keys.length == 3) {
                    caloriesPrompt = int.tryParse(keys[1].trim()) ?? 0;
                    proteinsPrompt = int.tryParse(keys[2].trim()) ?? 0;
                    var responseText = await _makeAPIRequest(keys[0]);
                    if (responseText != null) {
                      setState(() {
                        _responseText = responseText;
                        _filteredRecipes = _generateRecipeWidgets(responseText, caloriesPrompt, proteinsPrompt);
                      });
                      _extractRecipeTitles(responseText, caloriesPrompt, proteinsPrompt);
                    } else {
                      setState(() {
                        _responseText = [];
                        _filteredRecipes = [];
                      });
                    }
                  }
                  else if (keys.length == 2)
                  {
                    caloriesPrompt = int.tryParse(keys[1].trim()) ?? 0;
                    var responseText = await _makeAPIRequest(keys[0]);
                    if (responseText != null) {
                      setState(() {
                        _responseText = responseText;
                        _filteredRecipes = _generateRecipeWidgets(responseText, caloriesPrompt, proteinsPrompt);
                      });
                      _extractRecipeTitles(responseText, caloriesPrompt, proteinsPrompt);
                    } else {
                      setState(() {
                        _responseText = [];
                        _filteredRecipes = [];
                      });
                    }
                  }
                } else {
                  var responseText = await _makeAPIRequest(prompt);
                  if (responseText != null) {
                    setState(() {
                      _responseText = responseText;
                      _filteredRecipes = _generateRecipeWidgets(responseText, caloriesPrompt, proteinsPrompt);
                    });
                    _extractRecipeTitles(responseText, caloriesPrompt, proteinsPrompt);
                  } else {
                    setState(() {
                      _responseText = [];
                      _filteredRecipes = [];
                    });
                  }
                }
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 0, 0, 0),
                onPrimary: Color.fromARGB(255, 238, 238, 238),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _filteredRecipes.isNotEmpty
                  ? ListView(
                      children: _filteredRecipes,
                    )
                  : Center(
                      child: Text('No recipes to display', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
