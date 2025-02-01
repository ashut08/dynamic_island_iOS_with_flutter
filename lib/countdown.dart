import 'package:flutter/material.dart';
import 'package:live_activities/live_activities.dart';
import 'package:intl/intl.dart';

class CookingTimerPage extends StatefulWidget {
  const CookingTimerPage({super.key});

  @override
  State<CookingTimerPage> createState() => _CookingTimerPageState();
}

class _CookingTimerPageState extends State<CookingTimerPage> {
  final TextEditingController _dishNameController = TextEditingController();
  int? _selectedMinutes;
  String? _activityId;
  final liveActivities = LiveActivities();

  @override
  void initState() {
    super.initState();
    _initLiveActivities();
  }

  Future<void> _initLiveActivities() async {
    try {
      await liveActivities.init(appGroupId: "group.com.example.demoisland");
    } catch (e) {
      debugPrint("Error initializing Live Activities: $e");
    }
  }

  Future<void> _startCookingTimer() async {
    if (_dishNameController.text.isEmpty || _selectedMinutes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter dish name & select cooking time')),
      );
      return;
    }

    final activityId = await liveActivities.createActivity({
      'dishName': _dishNameController.text,
      'endTime': DateTime.now()
          .add(Duration(minutes: _selectedMinutes!))
          .toIso8601String(),
    });

    setState(() {
      _activityId = activityId;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              '🍳 Cooking timer started for ${_dishNameController.text}!')),
    );
  }

  Future<void> _stopCookingTimer() async {
    if (_activityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No active cooking timer')),
      );
      return;
    }

    await liveActivities.endActivity(_activityId!);

    setState(() {
      _activityId = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cooking timer stopped! ⏹️')),
    );
  }

  Future<void> _selectCookingTime(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            children: [
              const Text("Select Cooking Time",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 60,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${index + 1} minutes"),
                      onTap: () {
                        setState(() {
                          _selectedMinutes = index + 1;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooking Timer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(),
            const SizedBox(height: 16),
            _buildCookingTimeSelector(context),
            const SizedBox(height: 16),
            _buildStartStopButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _dishNameController,
      decoration: InputDecoration(
        labelText: 'Dish Name',
        hintText: 'Enter your dish name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.restaurant),
      ),
    );
  }

  Widget _buildCookingTimeSelector(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _selectedMinutes == null
                ? 'No cooking time selected'
                : 'Selected: ${_selectedMinutes} min',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.timer, color: Colors.blue),
          onPressed: () => _selectCookingTime(context),
        ),
      ],
    );
  }

  Widget _buildStartStopButtons() {
    return Column(
      children: [
        _buildAnimatedButton(
          label: "Start Cooking Timer",
          icon: Icons.play_arrow_rounded,
          color: Colors.green,
          onPressed: _startCookingTimer,
        ),
        const SizedBox(height: 12),
        _buildAnimatedButton(
          label: "Stop Cooking Timer",
          icon: Icons.stop_circle,
          color: Colors.red,
          onPressed: _stopCookingTimer,
        ),
      ],
    );
  }

  Widget _buildAnimatedButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
