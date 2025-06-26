import 'package:flutter/material.dart';


class StartWorkOutPage extends StatefulWidget {
  const StartWorkOutPage({super.key});

  @override
  State<StartWorkOutPage> createState() => _StartWorkOutState();
}

class _StartWorkOutState extends State<StartWorkOutPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController instructionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  TimeOfDay? _selectedTime;


  final List<MedicationItem> medications = [
    MedicationItem(
      name: 'Vitamin D3',
      dosage: '1000 IU',
      instruction: 'With breakfast',
      time: '8:00 AM',
      status: MedicationStatus.taken,
      icon: Icons.sunny,
      color: Colors.pink,
    ),
    MedicationItem(
      name: 'Metformin',
      dosage: '500mg',
      instruction: 'After lunch',
      time: '1:00 PM',
      status: MedicationStatus.overdue,
      icon: Icons.medical_services,
      color: Colors.purple,
    ),
    MedicationItem(
      name: 'Insulin',
      dosage: '10 units',
      instruction: 'Before dinner',
      time: '6:30 PM',
      status: MedicationStatus.upcoming,
      icon: Icons.local_hospital,
      color: Colors.blue,
    ),
    MedicationItem(
      name: 'Omega-3',
      dosage: '',
      instruction: '',
      time: '10:00 PM',
      status: MedicationStatus.overdue,
      icon: Icons.water_drop,
      color: Colors.indigo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4DD0E1),
              Color(0xFF26A69A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildScheduleHeader(),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: medications.length,
                          itemBuilder: (context, index) {
                            return _buildMedicationCard(medications[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 28,
              ),
        ),
          const SizedBox(height: 10),
          const Text(
            'Medication Reminder',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Your Health, Our Priority',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '✨',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
// 0xFF26A69A
  Widget _buildScheduleHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Today's Schedule",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          TextButton(
            onPressed: _showAddMedicationDialog,
            child:Icon(Icons.add,
            color: Color(0xFF26A69A),
            size: 30,)
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(MedicationItem medication) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: medication.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  medication.icon,
                  color: medication.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (medication.dosage.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${medication.dosage}${medication.instruction.isNotEmpty ? ' • ${medication.instruction}' : ''}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    medication.time,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(medication.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusText(medication.status),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _getStatusColor(medication.status),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (medication.status == MedicationStatus.overdue) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        medication.status = MedicationStatus.taken;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF26A69A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '✓ Take Now',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickTime,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[600],
                      side: BorderSide(color: Colors.grey[300]!),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const
                    Text(
                      '⏰ Snooze',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _showAddMedicationDialog() {
  nameController.clear();
  dosageController.clear();
  instructionController.clear();
  timeController.clear();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Add Medication"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
              TextField(controller: dosageController, decoration: InputDecoration(labelText: 'Dosage')),
              TextField(controller: instructionController, decoration: InputDecoration(labelText: 'Instruction')),

              GestureDetector(
                onTap: _pickTime,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedTimeText,
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const Icon(Icons.access_time, color: Colors.grey),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  medications.add(MedicationItem(
                    name: nameController.text,
                    dosage: dosageController.text,
                    instruction: instructionController.text,
                    time: selectedTimeText,
                    status: MedicationStatus.upcoming,
                    icon: Icons.medication,
                    color: Colors.teal,
                  ));
                });
                Navigator.pop(context); // Close the dialog
              }
            },
            child: Text("Add"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      );
    },
  );
}
  String get selectedTimeText {
    if (_selectedTime == null) {
      return 'Select Time';
    } else {
      final hour = _selectedTime!.hourOfPeriod.toString().padLeft(2, '0');
      final minute = _selectedTime!.minute.toString().padLeft(2, '0');
      final period = _selectedTime!.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }
  }


  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }


  Color _getStatusColor(MedicationStatus status) {
    switch (status) {
      case MedicationStatus.taken:
        return Colors.green;
      case MedicationStatus.overdue:
        return Colors.orange;
      case MedicationStatus.upcoming:
        return Colors.blue;
    }
  }

  String _getStatusText(MedicationStatus status) {
    switch (status) {
      case MedicationStatus.taken:
        return 'TAKEN';
      case MedicationStatus.overdue:
        return 'OVERDUE';
      case MedicationStatus.upcoming:
        return 'UPCOMING';
    }
  }
}

enum MedicationStatus {
  taken,
  overdue,
  upcoming,
}

class MedicationItem {
  String name;
  String dosage;
  String instruction;
  String time;
  MedicationStatus status;
  IconData icon;
  Color color;

  MedicationItem({
    required this.name,
    required this.dosage,
    required this.instruction,
    required this.time,
    required this.status,
    required this.icon,
    required this.color,
  });
}