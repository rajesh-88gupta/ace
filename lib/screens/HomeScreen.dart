import 'package:flutter/material.dart';
import 'homescreen/DownlodNotesScreen.dart';
import 'homescreen/JoinClassScreen.dart';
import 'homescreen/AskDoubtsScreen.dart';
import 'homescreen/courses_screen.dart';
import 'homescreen/exam_screen.dart';
import 'profile_modal.dart';
import 'homescreen/profile_screen.dart'; // Import the ProfileScreen file

void main() {
  runApp(const HomeScreen());
}

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
      routes: {
        '/download-notes': (context) => DownloadNotesScreen(),
        '/joinClass': (context) => const JoinClassScreen(),
        '/askDoubts': (context) => const AskDoubtsScreen(),
        '/profileScreen': (context) => const ProfileScreen(), // Add the route for ProfileScreen
      },
    );
  }
}

// DATA MODELS
class QuickAction {
  final String iconAsset;
  final String label;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  QuickAction({
    required this.iconAsset,
    required this.label,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });
}

class RecommendedCourse {
  final String imageAsset;
  final String title;
  final String subTitle;
  final String date;
  final String price;
  final String oldPrice;
  final String batch;
  final VoidCallback onTap;

  RecommendedCourse({
    required this.imageAsset,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.price,
    required this.oldPrice,
    required this.batch,
    required this.onTap,
  });
}

class ClassCardModel {
  final String imageAsset;
  final String title;
  final bool live;
  final int instructors;
  final String duration;
  final VoidCallback onTap;

  ClassCardModel({
    required this.imageAsset,
    required this.title,
    required this.live,
    required this.instructors,
    required this.duration,
    required this.onTap,
  });
}

class Batchmate {
  final String name;
  final String batch;
  final String imageUrl;

  Batchmate({
    required this.name,
    required this.batch,
    required this.imageUrl,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late List<QuickAction> quickActions;
  late List<RecommendedCourse> recommendedCourses;
  late List<ClassCardModel> classes;
  List<Batchmate> batchmates = [];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _loadData();

    _pages = [
      _buildHomeContent(), // Index 0
      const CoursesScreen(),    // Index 1
      const ExamScreen(),     // Index 2
    ];
  }


  void _loadData() {
    quickActions = [
      QuickAction(
        iconAsset: 'assets/images/icon1.png',
        label: 'Join Class',
        bgColor: const Color(0xFFFFF1F1),
        iconColor: const Color(0xFFFF5B5B),
        onTap: () {
          Navigator.pushNamed(context, '/joinClass');
        },
      ),
      QuickAction(
        iconAsset: 'assets/images/icon2.png',
        label: 'Ask Doubts',
        bgColor: const Color(0xFFFFF6E6),
        iconColor: const Color(0xFFFFA500),
        onTap: () {
          Navigator.pushNamed(context, '/askDoubts');
        },
      ),
      QuickAction(
        iconAsset: 'assets/images/icon3.png',
        label: 'Download Note',
        bgColor: const Color(0xFFECECFF),
        iconColor: const Color(0xFF7B2FF2),
        onTap: () {
          Navigator.pushNamed(context, '/download-notes');
        },
      ),
    ];

    recommendedCourses = [
      RecommendedCourse(
        imageAsset: 'assets/images/recom1.png',
        title: "Study high school online",
        subTitle: "E-learning",
        date: "07 Apr 2025",
        price: "\$499",
        oldPrice: "\$550",
        batch: "For Full batch",
        onTap: () {},
      ),
      RecommendedCourse(
        imageAsset: 'assets/images/recom2.png',
        title: "Continuing Education (CE) Course",
        subTitle: "E-learning",
        date: "15 Apr 2025",
        price: "\$199",
        oldPrice: "\$250",
        batch: "For Full batch",
        onTap: () {},
      ),
      RecommendedCourse(
        imageAsset: 'assets/courses/course3.jpg',
        title: "Advanced Dental Techniques",
        subTitle: "Workshop",
        date: "22 May 2025",
        price: "\$349",
        oldPrice: "\$400",
        batch: "For Full batch",
        onTap: () {},
      ),
    ];

    classes = [
      ClassCardModel(
        imageAsset: 'assets/images/classes1.png',
        title: "Advanced Dental Admission Test (ADAT)",
        live: true,
        instructors: 16,
        duration: "4h 45m",
        onTap: () {},
      ),
      ClassCardModel(
        imageAsset: 'assets/images/classes1.png',
        title: "Clinical Skills Exam with Courses",
        live: false,
        instructors: 8,
        duration: "6h 15m",
        onTap: () {},
      ),
      ClassCardModel(
        imageAsset: 'assets/classes/class3.jpg',
        title: "Dental Anatomy Fundamentals",
        live: true,
        instructors: 12,
        duration: "3h 30m",
        onTap: () {},
      ),
    ];

    batchmates = [
      Batchmate(
        name: "Adela Parkson",
        batch: "The Smile Squad",
        imageUrl: "https://randomuser.me/api/portraits/women/65.jpg",
      ),
      Batchmate(
        name: "Christian Mad",
        batch: "Pearly Whites 2025",
        imageUrl: "https://randomuser.me/api/portraits/men/65.jpg",
      ),
      Batchmate(
        name: "Sarah Johnson",
        batch: "The Dental Dynasty",
        imageUrl: "https://randomuser.me/api/portraits/women/66.jpg",
      ),
      Batchmate(
        name: "Michael Brown",
        batch: "Tooth Masters",
        imageUrl: "https://randomuser.me/api/portraits/men/67.jpg",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHomeContent() {
    return SafeArea(
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
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          // MODIFICATION IS HERE
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const ProfileModal(),
              );
            },
            child: CircleAvatar(
              radius: 23,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: const NetworkImage(
                "https://randomuser.me/api/portraits/men/32.jpg",
              ),
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
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFF7B2FF2),
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('assets/images/banner_bg.png'),
            fit: BoxFit.cover,
          ),
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
    );
  }

  Widget _buildTopOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: quickActions.length,
          itemBuilder: (context, index) {
            final action = quickActions[index];
            return Container(
              width: MediaQuery.of(context).size.width / 3.5,
              margin: EdgeInsets.only(right: index == quickActions.length - 1 ? 0 : 10),
              child: _buildTopOptionCard(
                iconAsset: action.iconAsset,
                label: action.label,
                bgColor: action.bgColor,
                iconColor: action.iconColor,
                onTap: action.onTap,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopOptionCard({
    required String iconAsset,
    required String label,
    required Color bgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
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
            const SizedBox(height: 7),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  iconAsset,
                  color: iconColor,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 9),
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.black)),
          ],
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

  Widget _buildRecommendedSection() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: recommendedCourses.length,
        itemBuilder: (context, index) {
          final course = recommendedCourses[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.76,
            margin: EdgeInsets.only(right: index == recommendedCourses.length - 1 ? 0 : 18),
            child: _buildRecommendedCard(
              imageAsset: course.imageAsset,
              title: course.title,
              subTitle: course.subTitle,
              date: course.date,
              price: course.price,
              oldPrice: course.oldPrice,
              batch: course.batch,
              onTap: course.onTap,
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecommendedCard({
    required String imageAsset,
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
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                color: Colors.grey.shade200,
                image: DecorationImage(
                  image: AssetImage(imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
              child: imageAsset.isEmpty
                  ? const Center(child: Icon(Icons.image, size: 40, color: Colors.grey))
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Row(
                children: [
                  if (subTitle != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E7FF),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(subTitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7B2FF2),
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 13, color: Color(0xFF7B2FF2)),
                      const SizedBox(width: 2),
                      Text("Start On $date",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
              child: Row(
                children: [
                  Text(price,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7B2FF2),
                          fontSize: 15)),
                  const SizedBox(width: 7),
                  Text(
                    oldPrice,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Text("($batch)",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassesSection() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classItem = classes[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.76,
            margin: EdgeInsets.only(right: index == classes.length - 1 ? 0 : 18),
            child: _buildClassCard(
              imageAsset: classItem.imageAsset,
              title: classItem.title,
              live: classItem.live,
              instructors: classItem.instructors,
              duration: classItem.duration,
              onTap: classItem.onTap,
            ),
          );
        },
      ),
    );
  }

  Widget _buildClassCard({
    required String imageAsset,
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
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                    color: Colors.grey.shade200,
                    image: DecorationImage(
                      image: AssetImage(imageAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: imageAsset.isEmpty
                      ? const Center(child: Icon(Icons.image, size: 40, color: Colors.grey))
                      : null,
                ),
                if (live)
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'Live classes',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 38,
                    height: 24,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 11,
                              backgroundImage: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/43.jpg"),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 11,
                              backgroundImage: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/44.jpg"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "$instructors+ Instructor",
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.schedule, color: Color(0xFF7B2FF2), size: 16),
                  const SizedBox(width: 4),
                  Text(duration,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13)),
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
            Text(count,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: textColor)),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.w600),
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
            desc: "The Assessment of Fundamental Knowledge (AFK) is the first step for internationally trained dentists...",
          ),
          const SizedBox(height: 18),
          _buildUpcomingTaskCard(
            title: "Mock Exams (Onsite) & Discussions",
            date: "10 Apr 2025",
            lessons: 6,
            completedStep: null,
            totalSteps: null,
            desc: "",
          ),
          const SizedBox(height: 18),
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
      margin: const EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ),
              if (highPriority)
                Container(
                  margin: const EdgeInsets.only(left: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5B5B),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Text("High Priority",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12)),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 15, color: Color(0xFF7B2FF2)),
              const SizedBox(width: 6),
              Text("Start On $date",
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey)),
              const SizedBox(width: 20),
              const Icon(Icons.menu_book, size: 15, color: Color(0xFF7B2FF2)),
              const SizedBox(width: 6),
              Text("$lessons Lesson",
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey)),
            ],
          ),
          if (desc.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(desc,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.4,
                )),
          ],
          if (completedStep != null && totalSteps != null) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Text("$completedStep of $totalSteps steps completed",
                    style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7B2FF2))),
                const SizedBox(width: 10),
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
        children: batchmates
            .map((batchmate) => Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: _buildBatchmateItem(
            name: batchmate.name,
            batch: batchmate.batch,
            imageUrl: batchmate.imageUrl,
          ),
        ))
            .toList(),
      ),
    );
  }

  Widget _buildBatchmateItem({
    required String name,
    required String batch,
    required String imageUrl,
  }) {
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
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                Text(batch,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey)),
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
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        if (index == 3) {
          // Navigate to ProfileScreen using the defined route
          Navigator.pushNamed(context, '/profileScreen');
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF7B2FF2),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school_outlined),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Exam',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}