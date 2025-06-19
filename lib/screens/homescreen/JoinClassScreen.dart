import 'package:flutter/material.dart';

class JoinClassScreen extends StatefulWidget {
  const JoinClassScreen({super.key});

  @override
  State<JoinClassScreen> createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {
  // final ZoomOptions zoomOptions = ZoomOptions(
  //   domain: "zoom.us",
  //   appKey: "YOUR_ZOOM_SDK_KEY",       // 🔑 Replace with your SDK Key
  //   appSecret: "YOUR_ZOOM_SDK_SECRET", // 🔐 Replace with your SDK Secret
  // );
  //
  // final ZoomMeetingOptions meetingOptions = ZoomMeetingOptions(
  //   userId: "student@example.com",
  //   displayName: "Student User",
  //   meetingId: "MEETING_ID",           // Replace with your actual meeting ID
  //   meetingPassword: "PASSWORD",       // Replace with your actual meeting password
  // );
  //
  // void _joinZoomMeeting() async {
  //   await ZoomView().initZoom(zoomOptions);
  //   ZoomView().joinMeeting(meetingOptions).then((result) {
  //     debugPrint("Zoom join result: $result");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Join Class"),
        backgroundColor: const Color(0xFF683091),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: -5,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.asset(
                          'assets/images/class_banner.png',
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Live classes",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 10,
                        right: 10,
                        child: Text(
                          "10h 05m",
                          style: TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.black45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Clinical Skills Exam with ACE Courses",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.person, size: 16, color: Colors.grey),
                            SizedBox(width: 4),
                            Text("Cameron Williamson", style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF683091),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {  },
                child: const Text(
                  "Join Classes",
                  style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
