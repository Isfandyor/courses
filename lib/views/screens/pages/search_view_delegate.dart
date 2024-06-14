import 'package:flutter/material.dart';
import 'package:practice_home/models/course.dart';
import 'package:practice_home/views/screens/pages/home/list_view.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchViewDelegate extends SearchDelegate<Course> {
  List<Course> courses;
  late BuildContext context;
  SearchViewDelegate(this.courses, context)
      : super(searchFieldLabel: AppLocalizations.of(context)!.search);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, courses.first);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results UI here
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? courses
        : courses
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListViewCourses(
            course: suggestionList[index],
          ),
        );
      },
    );
  }
}
