import 'package:flutter/material.dart';
import 'package:skillshunt/data/skills.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  List<String> _searchResults = [];
  List<String> _selectedSkills = [];
  final _focusNode = FocusNode();
  String _globalQuery = '';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(onSearchFocusChange);
  }

  void onSearchFocusChange() {
    setState(() {
      _searchResults = _searchResults.isEmpty ? skills : [];
    });
  }

  void searchQuery(String value) {
    final query = value.trim().toLowerCase();

    if (query.isEmpty) {
      setState(() {
        _searchResults = skills;
      });
      return;
    }

    setState(() {
      _globalQuery = query;
    });

    List<String> startsWithQuery = [];
    List<String> containsQuery = [];

    for (String skill in skills) {
      String lowerCaseSkill = skill.toLowerCase();
      if (lowerCaseSkill.startsWith(query)) {
        startsWithQuery.add(skill);
      } else if (lowerCaseSkill.contains(query)) {
        containsQuery.add(skill);
      }
    }

    setState(() {
      // Combine the lists, starting with those that start with the query
      _searchResults = startsWithQuery + containsQuery;
    });
  }

  RichText highlightQuery(String text, String query) {
    if (query.isEmpty) {
      return RichText(
        text: TextSpan(
          text: text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfQuery;
    query = query.toLowerCase();

    while ((indexOfQuery = text.toLowerCase().indexOf(query, start)) != -1) {
      // Add text before the query
      if (indexOfQuery > start) {
        spans.add(TextSpan(
          text: text.substring(start, indexOfQuery),
        ));
      }
      // Add the query text with bold style
      spans.add(TextSpan(
        text: text.substring(indexOfQuery, indexOfQuery + query.length),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ));
      start = indexOfQuery + query.length;
    }

    // Add remaining text after the last query occurrence
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: TextField(
            focusNode: _focusNode,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_rounded),
              // suffixIcon: const Icon(Icons.close_rounded),
              prefixIconColor: Theme.of(context).colorScheme.tertiary,
              filled: true,
              fillColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.5),
              focusColor: Theme.of(context).colorScheme.tertiaryContainer,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.5),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            onChanged: searchQuery,
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: highlightQuery(
                _searchResults[index],
                _globalQuery,
              ),
              dense: true,
              key: ValueKey(_searchResults[index]),
              visualDensity: VisualDensity.compact,
              onTap: () {
                setState(() {
                  _selectedSkills.add(_searchResults[index]);
                });
              },
            ),
            itemCount: _searchResults.length,
          ),
        ),
        _selectedSkills.isEmpty
            ? const Center(
                child: Text('Add some skills'),
              )
            : Placeholder(),
      ],
    );
  }
}
