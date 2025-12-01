import 'package:flutter/material.dart';

class NewsHeaderBar extends StatefulWidget {
  final Function(String) onCategorySelected;

  const NewsHeaderBar({Key? key, required this.onCategorySelected})
    : super(key: key);

  @override
  State<NewsHeaderBar> createState() => _NewsHeaderBarState();
}

class _NewsHeaderBarState extends State<NewsHeaderBar> {
  final List<String> categories = [
    "My Feed",
    "The Hindu",
    "CNBC",
    "BBC News",
    "TechCrunch",
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onCategorySelected(categories[index]);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue[300] : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
