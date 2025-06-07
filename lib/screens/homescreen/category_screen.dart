import 'package:flutter/material.dart';

/// A data model class to represent a single category.
/// This helps in organizing the data for each card.
class Category {
  final String title;
  final int noteCount;
  final Color color;
  final IconData icon;

  Category({
    required this.title,
    required this.noteCount,
    required this.color,
    this.icon = Icons.folder_rounded, // Default icon
  });
}

/// The main screen widget that builds the entire UI seen in the image.
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A list of Category objects to populate our grid.
    // This simulates fetching data from a database or API.
    final List<Category> categories = [
      Category(title: 'Design', noteCount: 15, color: const Color(0xFF4A80F0)),
      Category(title: 'Success', noteCount: 45, color: const Color(0xFFF0B44A)),
      Category(title: 'Scientific', noteCount: 29, color: const Color(0xFF4CAF50)),
      Category(title: 'Freelancer', noteCount: 19, color: const Color(0xFFC063F2)),
    ];

    return Scaffold(
      // A light grey background color to match the design.
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        // The AppBar is made transparent and flat to blend with the body.
        backgroundColor: Colors.grey[50],
        elevation: 0,
        // The main title of the screen.
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,

          ),
        ),
        actions: [
          // The circular add button on the right.
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                // A subtle border to match the image.
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.black, size: 24),
                onPressed: () {
                  // TODO: Implement functionality for adding a new category.
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        // Overall padding for the content area.
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Header row for "List Categories" and the "New" filter.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'List Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'New',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 2),
                    Icon(Icons.swap_vert, size: 20, color: Colors.grey[600]),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            // The GridView is wrapped in an Expanded widget to fill available space.
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 cards per row.
                  crossAxisSpacing: 20, // Horizontal space between cards.
                  mainAxisSpacing: 20, // Vertical space between cards.
                  childAspectRatio: 0.95, // Adjusts the height vs. width of cards.
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  // Using our custom CategoryCard widget.
                  return CategoryCard(
                    title: category.title,
                    noteCount: category.noteCount,
                    color: category.color,
                    icon: category.icon,
                  );
                },
              ),
            ),
            // The footer text at the bottom of the screen.
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                child: Text(
                  'You Have ${categories.length} Categories',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A reusable widget for displaying a single category card.
class CategoryCard extends StatelessWidget {
  final String title;
  final int noteCount;
  final Color color;
  final IconData icon;

  const CategoryCard({
    super.key,
    required this.title,
    required this.noteCount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Using the main color with low opacity gives the light background tint.
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // The colored icon container.
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            // Stacking icons to create the folder-minus effect.
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
                // The small minus icon inside the folder.
                const Positioned(
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Category title text.
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Note count text.
          Text(
            '$noteCount Notes',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
