import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/data/skills.dart';
import 'package:skillshunt/providers/skills_provider.dart';

class MySearchBar extends ConsumerStatefulWidget {
  const MySearchBar({
    super.key,
  });

  @override
  ConsumerState<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends ConsumerState<MySearchBar> {
  List<String> _searchResults = [];
  final _focusNode = FocusNode();
  final _globalQuery = TextEditingController();

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

  void searchQuery(_) {
    final query = _globalQuery.text.trim().toLowerCase();

    if (query.isEmpty) {
      setState(() {
        _searchResults = skills;
      });
      return;
    }

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: TextField(
            focusNode: _focusNode,
            controller: _globalQuery,
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
        Visibility(
          visible: _searchResults.isNotEmpty,
          child: SizedBox(
            height: _searchResults.length * 50 < 300 ? _searchResults.length * 50 : 300,
            child: ListView.builder(
              itemBuilder: (context, index) => Card(
                color: Colors.transparent,
                child: ListTile(
                  title: highlightQuery(
                    _searchResults[index],
                    _globalQuery.text.trim().toLowerCase(),
                  ),
                  tileColor: Theme.of(context).colorScheme.tertiaryContainer.withAlpha(80),
                  dense: true,
                  key: ValueKey(_searchResults[index]),
                  visualDensity: VisualDensity.compact,
                  onTap: () {
                    setState(() {
                      ref.read(selectedSkillsProvider.notifier).selectSkill(_searchResults[index]);
                      _searchResults = [];
                      _focusNode.unfocus();
                      onSearchFocusChange();
                      _globalQuery.clear();
                    });
                  },
                ),
              ),
              itemCount: _searchResults.length,
            ),
          ),
        ),
      ],
    );
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
          style: Theme.of(context).textTheme.bodySmall,
        ));
      }
      // Add the query text with bold style
      spans.add(
        TextSpan(
          text: text.substring(indexOfQuery, indexOfQuery + query.length),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
        ),
      );
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
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
