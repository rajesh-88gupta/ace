import 'package:ace/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dental Courses',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF7B2FF2),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 18),
              _buildHeroBanner(),
              const SizedBox(height: 18),
              _buildTopOptions(),
              const SizedBox(height: 14),
              _buildSectionTitle('Recommended For You', showViewMore: true),
              _buildRecommendedSection(),
              const SizedBox(height: 18),
              _buildSectionTitle('Classes', showViewMore: true),
              _buildClassesSection(),
              const SizedBox(height: 18),
              _buildSectionTitle('Attendance For', showViewMore: true),
              _buildAttendanceSection(),
              const SizedBox(height: 18),
              _buildSectionTitle('Upcoming Task'),
              _buildUpcomingTasksSection(),
              const SizedBox(height: 18),
              _buildSectionTitle('Batchmates / Batch Name', showViewMore: true),
              _buildBatchmatesSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: const NetworkImage(
              "https://randomuser.me/api/portraits/men/32.jpg",
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text.rich(
                  TextSpan(
                    text: 'Hello ',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Jane!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'janey758@gmail.com',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.grey, size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.grey, size: 26),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Stack(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF7B2FF2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'The Right Choice Of',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Dental Course',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF7B2FF2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      minimumSize: const Size(88, 40),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text('Enroll Now'),
                  ),
                ),
              ],
            ),
          ),
          // Carousel dots (centered)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDot(isActive: true),
                  const SizedBox(width: 5),
                  _buildDot(),
                  const SizedBox(width: 5),
                  _buildDot(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDot({bool isActive = false}) {
    return Container(
      width: isActive ? 20 : 7,
      height: 7,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }

  Widget _buildTopOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          _buildTopOptionCard(
            icon: Icons.video_call,
            label: 'Join Class',
            bgColor: const Color(0xFFFFF1F1),
            iconColor: const Color(0xFFFF5B5B),
            onTap: () {},
          ),
          const SizedBox(width: 10),
          _buildTopOptionCard(
            icon: Icons.settings,
            label: 'Ask Doubts',
            bgColor: const Color(0xFFFFF6E6),
            iconColor: const Color(0xFFFFA500),
            onTap: () {},
          ),
          const SizedBox(width: 10),
          _buildTopOptionCard(
            icon: Icons.download_for_offline_rounded,
            label: 'Download Note',
            bgColor: const Color(0xFFECECFF),
            iconColor: const Color(0xFF7B2FF2),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTopOptionCard({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: bgColor.withOpacity(0.09),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(height: 7),
              Text(label, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showViewMore = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          if (showViewMore)
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF7B2FF2),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
              ),
              child: const Text('View More'),
            ),
        ],
      ),
    );
  }

  // Helper for image or placeholder
  Widget buildImageOrPlaceholder({String? imageUrl, double height = 90, double borderRadius = 18}) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      child: imageUrl == null || imageUrl.isEmpty
          ? Container(
        height: height,
        color: Colors.grey.shade200,
        child: Center(
          child: Icon(Icons.image, size: 32, color: Colors.grey.shade400),
        ),
      )
          : Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: height,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => Container(
          height: height,
          color: Colors.grey.shade200,
          child: Center(
            child: Icon(Icons.broken_image, size: 32, color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Expanded(child: _buildRecommendedCard(
            imageUrl: "", // Empty for now, placeholder will show
            title: "Study high school online",
            subTitle: "E-learning",
            date: "07 Apr 2025",
            price: "\$499",
            oldPrice: "\$550",
            batch: "For Full batch",
            onTap: () {},
          )),
          const SizedBox(width: 12),
          Expanded(child: _buildRecommendedCard(
            imageUrl: "", // Empty for now, placeholder will show
            title: "Continuing Education (CE) Course",
            subTitle: "E-learning",
            date: "15 Apr 2025",
            price: "\$199",
            oldPrice: "\$250",
            batch: "For Full batch",
            onTap: () {},
          )),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard({
    required String? imageUrl,
    required String title,
    String? subTitle,
    required String date,
    required String price,
    required String oldPrice,
    required String batch,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 205,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImageOrPlaceholder(imageUrl: imageUrl, height: 90, borderRadius: 18),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
              child: Row(
                children: [
                  if (subTitle != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E7FF),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(subTitle, style: const TextStyle(fontSize: 11, color: Color(0xFF7B2FF2))),
                    ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 12, color: Color(0xFF7B2FF2)),
                      const SizedBox(width: 2),
                      Text("Start On $date", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
              child: Row(
                children: [
                  Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7B2FF2), fontSize: 14)),
                  const SizedBox(width: 7),
                  Text(
                    oldPrice,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Text("($batch)", style: const TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Expanded(child: _buildClassCard(
            imageUrl: "", // Empty for now, placeholder will show
            title: "Advanced Dental Admission Test (ADAT)",
            live: true,
            instructors: 16,
            duration: "4h 45m",
            onTap: () {},
          )),
          const SizedBox(width: 12),
          Expanded(child: _buildClassCard(
            imageUrl: "", // Empty for now, placeholder will show
            title: "Clinical Skills Exam with Courses",
            live: false,
            instructors: 8,
            duration: "6h 15m",
            onTap: () {},
          )),
        ],
      ),
    );
  }

  // THIS IS THE CORRECTED WIDGET
  Widget _buildClassCard({
    required String? imageUrl,
    required String title,
    required bool live,
    required int instructors,
    required String duration,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 137,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                buildImageOrPlaceholder(imageUrl: imageUrl, height: 64, borderRadius: 18),
                if (live)
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Live classes',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
              child: Row(
                children: [
                  // Corrected overlapping avatars using Stack
                  SizedBox(
                    // Calculate width needed for overlapping avatars:
                    // (avatarDiameter) + (numberOfAvatars - 1) * (avatarDiameter - overlapAmount)
                    // For 2 avatars with radius 11 (diameter 22) and 8px overlap:
                    // 22 + (2-1) * (22 - 8) = 22 + 1 * 14 = 36
                    width: (11 * 2) + ((2 > 1 ? 2 - 1 : 0) * ((11 * 2) - 8.0)),
                    height: 11 * 2, // Height of one avatar (diameter)
                    child: Stack(
                      children: List.generate(2, (i) { // Assuming 2 avatars as per original code structure
                        return Positioned(
                          left: i * ((11 * 2) - 8.0), // Position subsequent avatars with overlap
                          // For i=0 (first avatar): left = 0 * (22-8) = 0
                          // For i=1 (second avatar): left = 1 * (22-8) = 14
                          child: const CircleAvatar(
                            radius: 11,
                            backgroundColor: Colors.white, // Outer circle for border effect
                            child: CircleAvatar(
                              radius: 10, // Inner circle for image (slightly smaller for border effect)
                              backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/43.jpg"),
                            ),
                          ),
                        );
                      }).reversed.toList(), // .reversed ensures the first avatar (i=0) is visually on top
                    ),
                  ),
                  const SizedBox(width: 7), // Spacing after avatar group
                  Text("$instructors+ Instructor", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const Spacer(),
                  const Icon(Icons.schedule, color: Color(0xFF7B2FF2), size: 14),
                  const SizedBox(width: 3),
                  Text(duration, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildAttendanceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          _buildAttendanceBox("Present", "23", Colors.blue[100]!, Colors.blue),
          const SizedBox(width: 12),
          _buildAttendanceBox("Absent", "07", Colors.purple[100]!, Colors.purple),
          const SizedBox(width: 12),
          _buildAttendanceBox("Late", "04", Colors.orange[100]!, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildAttendanceBox(String label, String count, Color bg, Color textColor) {
    return Expanded(
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(count, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: textColor)),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            const Text(
              'This Month',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingTasksSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          _buildUpcomingTaskCard(
            title: "Assessment of Fundamental Knowledge (AFK)",
            highPriority: true,
            date: "24 Apr 2025",
            lessons: 8,
            completedStep: 1,
            totalSteps: 7,
            desc: "The Assessment of Fundamental Knowledge (AFK) is the first step for internationally trained dentists aspiring to become licensed in Canada...",
          ),
          const SizedBox(height: 9),
          _buildUpcomingTaskCard(
            title: "Mock Exams (Onsite) & Discussions",
            date: "10 Apr 2025",
            lessons: 6,
            completedStep: null,
            totalSteps: null,
            desc: "",
          ),
          const SizedBox(height: 9),
          _buildUpcomingTaskCard(
            title: "Subject Wise Test",
            date: "14 Apr 2025",
            lessons: 6,
            completedStep: null,
            totalSteps: null,
            desc: "",
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTaskCard({
    required String title,
    required String date,
    required int lessons,
    String desc = "",
    bool highPriority = false,
    int? completedStep,
    int? totalSteps,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.fromLTRB(13, 13, 13, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              if (highPriority)
                Container(
                  margin: const EdgeInsets.only(left: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5B5B),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Text("High Priority", style: TextStyle(color: Colors.white, fontSize: 11)),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 13, color: Color(0xFF7B2FF2)),
              const SizedBox(width: 4),
              Text("Start On $date", style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(width: 19),
              const Icon(Icons.menu_book, size: 13, color: Color(0xFF7B2FF2)),
              const SizedBox(width: 4),
              Text("$lessons Lesson", style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          if (desc.isNotEmpty) ...[
            const SizedBox(height: 7),
            Text(desc, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
          if (completedStep != null && totalSteps != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Text("$completedStep of $totalSteps steps completed", style: const TextStyle(fontSize: 12, color: Color(0xFF7B2FF2))),
                const SizedBox(width: 7),
                Expanded(
                  child: LinearProgressIndicator(
                    value: completedStep / totalSteps,
                    minHeight: 5,
                    backgroundColor: Colors.grey.shade200,
                    color: const Color(0xFF7B2FF2),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBatchmatesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          _buildBatchmateItem("Adela Parkson", "The Smile Squad", "https://randomuser.me/api/portraits/women/65.jpg"),
          const SizedBox(height: 7),
          _buildBatchmateItem("Christian Mad", "Pearly Whites 2025", "https://randomuser.me/api/portraits/men/65.jpg"),
          const SizedBox(height: 7),
          _buildBatchmateItem("Christian Mad", "The Dental Dynasty", "https://randomuser.me/api/portraits/men/66.jpg"),
        ],
      ),
    );
  }

  Widget _buildBatchmateItem(String name, String batch, String imageUrl) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(batch, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    // DO NOT TOUCH BOTTOM NAVBAR - as per instruction
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            break;
          case 1:
            // Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesScreen()));
            break;
          case 2:
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleScreen()));
            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileApp()));
            break;
          case 4:
            // Navigator.push(context, MaterialPageRoute(builder: (context) => MoreScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
    );
  }

}