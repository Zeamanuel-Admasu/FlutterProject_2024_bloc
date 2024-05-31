import 'package:flutter/material.dart';
import '../others/foodItems.dart';
import './main_reserve.dart';

void main() {
  runApp(const Search());
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SearchBody(),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<FoodItems> foodItems = [
      FoodItems("Pasta", "Mexico,betel,saris", "assets/pasta.png"),
      FoodItems("Kitfo", "Mexico,betel,saris", "assets/kitfo.png"),
      FoodItems("Buna", "Mexico,betel,saris", "assets/buna.jpeg"),
      FoodItems("tibs", "Mexico,betel,saris", "assets/tibs.png"),
      FoodItems("food", "Mexico,betel,saris", "assets/food.jpeg"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      backgroundColor: const Color(0xff101520),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff182032),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 202, 193, 193)),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 25, 10, 7),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Popular feasts",
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodItems.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainReserve()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 150,
                    child: Card(
                      color: const Color(0xff182032),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                            child: Center(
                              child: Image.asset(
                                foodItems[index].url!,
                                width: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                foodItems[index].name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 202, 193, 193)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
