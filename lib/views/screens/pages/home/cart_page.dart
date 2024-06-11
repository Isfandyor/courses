import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_home/controllers/courses_controller.dart';
import 'package:practice_home/theme/theme_provider.dart';
import 'package:practice_home/views/screens/pages/home/list_view.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          height: 140,
          color: Provider.of<ThemeProvider>(context)
              .themeData
              .secondaryHeaderColor,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "\$${Provider.of<CoursesController>(context, listen: false).totalPriceCart()}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(60),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          icon: const Icon(
                            CupertinoIcons.checkmark_alt_circle_fill,
                            color: Colors.green,
                            size: 70,
                          ),
                          title: const Text("Operatisiya bajarildi!"),
                          actions: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size.fromHeight(40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // Border radius
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Ok",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Icon(
                        Icons.navigate_next_rounded,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ))
            ],
          )),
      body: FutureBuilder(
          future: Provider.of<CoursesController>(context)
              .fetchCoursesFavoriteAndInCart(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Snapshot error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              return const Center(
                child: Text("Snapshot hasData error: Malumot topilmadi"),
              );
            }
            final courses =
                Provider.of<CoursesController>(context, listen: false)
                    .coursesInCart;
            if (courses.isEmpty) {
              return const Center(
                child: Text("Malumot yo'q"),
              );
            }
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return ListViewCourses(
                      course: courses[index],
                    );
                  },
                ))
              ],
            );
          }),
    );
  }
}
