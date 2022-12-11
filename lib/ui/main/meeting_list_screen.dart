import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MeetingListScreen extends StatefulWidget {
  const MeetingListScreen({super.key});

  @override
  State<MeetingListScreen> createState() => _MeetingListScreenState();
}

class _MeetingListScreenState extends State<MeetingListScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.red,
        child: Text("Meeting list screen"),
      ),
    );
  }
}