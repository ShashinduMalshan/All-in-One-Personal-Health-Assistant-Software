import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MedicalHistoryStorage extends StatefulWidget {
  const MedicalHistoryStorage({super.key});

  @override
  State<MedicalHistoryStorage> createState() => _MedicalHistoryStorageState();
}

class _MedicalHistoryStorageState extends State<MedicalHistoryStorage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<MedicalRecord> medicalRecords = [];
  List<Consultation> consultations = [];
  List<Medication> medications = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadSampleData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadSampleData() {
    // Sample data - in real app, this would come from secure storage/database
    medicalRecords = [
      MedicalRecord(
        id: '1',
        title: 'Irregular Periods',
        date: DateTime.now().subtract(const Duration(days: 30)),
        doctor: 'Dr. Sarah Wilson',
        diagnosis: 'PCOS suspected',
        symptoms: ['Irregular cycle', 'Heavy bleeding', 'Cramping'],
        notes: 'Recommended lifestyle changes and follow-up in 3 months',
        severity: Severity.medium,
      ),
      MedicalRecord(
        id: '2',
        title: 'Annual Gynecological Checkup',
        date: DateTime.now().subtract(const Duration(days: 90)),
        doctor: 'Dr. Maria Rodriguez',
        diagnosis: 'Normal examination',
        symptoms: ['Routine checkup'],
        notes: 'All tests normal. Continue regular menstrual tracking.',
        severity: Severity.low,
      ),
    ];

    consultations = [
      Consultation(
        id: '1',
        date: DateTime.now().subtract(const Duration(days: 7)),
        doctor: 'Dr. Sarah Wilson',
        type: ConsultationType.followUp,
        duration: 30,
        notes: 'Discussed period tracking results. Symptoms improving.',
        prescription: 'Continue current supplements',
      ),
    ];

    medications = [
      Medication(
        id: '1',
        name: 'Iron Supplement',
        dosage: '18mg daily',
        startDate: DateTime.now().subtract(const Duration(days: 60)),
        endDate: DateTime.now().add(const Duration(days: 30)),
        prescribedBy: 'Dr. Sarah Wilson',
        purpose: 'Address iron deficiency',
        isActive: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Medical History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddRecordDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.pink,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.pink,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(text: 'Records'),
            Tab(text: 'Visits'),
            Tab(text: 'Medications'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMedicalRecordsTab(),
          _buildConsultationsTab(),
          _buildMedicationsTab(),
          _buildSummaryTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRecordDialog(),
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildMedicalRecordsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Recent Records', Icons.medical_services),
          const SizedBox(height: 16),
          if (medicalRecords.isEmpty)
            _buildEmptyState('No medical records yet', 'Add your first medical record to get started')
          else
            ...medicalRecords.map((record) => _buildMedicalRecordCard(record)),
        ],
      ),
    );
  }

  Widget _buildConsultationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Consultations & Visits', Icons.local_hospital),
          const SizedBox(height: 16),
          if (consultations.isEmpty)
            _buildEmptyState('No consultations recorded', 'Track your doctor visits and consultations')
          else
            ...consultations.map((consultation) => _buildConsultationCard(consultation)),
        ],
      ),
    );
  }

  Widget _buildMedicationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Current Medications', Icons.medication),
          const SizedBox(height: 16),
          if (medications.isEmpty)
            _buildEmptyState('No medications tracked', 'Add medications to track your treatment')
          else
            ...medications.map((medication) => _buildMedicationCard(medication)),
        ],
      ),
    );
  }

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Health Summary', Icons.summarize),
          const SizedBox(height: 16),
          _buildHealthMetricsCard(),
          const SizedBox(height: 16),
          _buildRecentActivityCard(),
          const SizedBox(height: 16),
          _buildExportOptionsCard(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.pink, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildMedicalRecordCard(MedicalRecord record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getSeverityColor(record.severity).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getSeverityIcon(record.severity),
                  color: _getSeverityColor(record.severity),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_formatDate(record.date)} • Dr. ${record.doctor}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, size: 20),
                onPressed: () => _showRecordOptions(record),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (record.diagnosis.isNotEmpty) ...[
            _buildInfoRow('Diagnosis', record.diagnosis),
            const SizedBox(height: 8),
          ],
          if (record.symptoms.isNotEmpty) ...[
            _buildInfoRow('Symptoms', record.symptoms.join(', ')),
            const SizedBox(height: 8),
          ],
          if (record.notes.isNotEmpty)
            _buildInfoRow('Notes', record.notes),
        ],
      ),
    );
  }

  Widget _buildConsultationCard(Consultation consultation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getConsultationIcon(consultation.type),
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getConsultationTitle(consultation.type),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_formatDate(consultation.date)} • ${consultation.duration} min',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Doctor', consultation.doctor),
          if (consultation.notes.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildInfoRow('Notes', consultation.notes),
          ],
          if (consultation.prescription.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildInfoRow('Prescription', consultation.prescription),
          ],
        ],
      ),
    );
  }

  Widget _buildMedicationCard(Medication medication) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: medication.isActive ? Colors.green.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (medication.isActive ? Colors.green : Colors.grey).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.medication,
                  color: medication.isActive ? Colors.green : Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      medication.dosage,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: medication.isActive ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  medication.isActive ? 'Active' : 'Completed',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Prescribed by', medication.prescribedBy),
          const SizedBox(height: 4),
          _buildInfoRow('Purpose', medication.purpose),
          const SizedBox(height: 4),
          _buildInfoRow(
            'Duration',
            '${_formatDate(medication.startDate)} - ${_formatDate(medication.endDate)}',
          ),
        ],
      ),
    );
  }

  Widget _buildHealthMetricsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Health Metrics',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem('Total Records', '${medicalRecords.length}', Icons.folder_outlined, Colors.blue),
              ),
              Expanded(
                child: _buildMetricItem('Consultations', '${consultations.length}', Icons.local_hospital, Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem('Active Meds', '${medications.where((m) => m.isActive).length}', Icons.medication, Colors.orange),
              ),
              Expanded(
                child: _buildMetricItem('Last Visit', _getLastVisitText(), Icons.schedule, Colors.purple),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildActivityItem('Medical record added', '2 days ago', Icons.add_circle, Colors.green),
          _buildActivityItem('Consultation completed', '1 week ago', Icons.check_circle, Colors.blue),
          _buildActivityItem('Medication updated', '2 weeks ago', Icons.edit, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportOptionsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Export & Share',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildExportButton('Export PDF', Icons.picture_as_pdf, Colors.red),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildExportButton('Share Summary', Icons.share, Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton(String label, IconData icon, Color color) {
    return InkWell(
      onTap: () => _handleExport(label),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.folder_open,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  Color _getSeverityColor(Severity severity) {
    switch (severity) {
      case Severity.low:
        return Colors.green;
      case Severity.medium:
        return Colors.orange;
      case Severity.high:
        return Colors.red;
    }
  }

  IconData _getSeverityIcon(Severity severity) {
    switch (severity) {
      case Severity.low:
        return Icons.check_circle;
      case Severity.medium:
        return Icons.warning;
      case Severity.high:
        return Icons.error;
    }
  }

  IconData _getConsultationIcon(ConsultationType type) {
    switch (type) {
      case ConsultationType.routine:
        return Icons.event;
      case ConsultationType.followUp:
        return Icons.update;
      case ConsultationType.emergency:
        return Icons.emergency;
    }
  }

  String _getConsultationTitle(ConsultationType type) {
    switch (type) {
      case ConsultationType.routine:
        return 'Routine Checkup';
      case ConsultationType.followUp:
        return 'Follow-up Visit';
      case ConsultationType.emergency:
        return 'Emergency Visit';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getLastVisitText() {
    if (consultations.isEmpty) return 'None';
    consultations.sort((a, b) => b.date.compareTo(a.date));
    final daysDiff = DateTime.now().difference(consultations.first.date).inDays;
    return '${daysDiff}d ago';
  }

  // Dialog methods
  void _showAddRecordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Medical Record'),
        content: const Text('Feature coming soon! This will allow you to add new medical records securely.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Medical Records'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Search records, consultations, medications...',
            prefixIcon: Icon(Icons.search),
          ),
          onSubmitted: (value) => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showRecordOptions(MedicalRecord record) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Record'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share with Doctor'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export as PDF'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Record', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _handleExport(String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$type feature coming soon!'),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

// Data Models
class MedicalRecord {
  final String id;
  final String title;
  final DateTime date;
  final String doctor;
  final String diagnosis;
  final List<String> symptoms;
  final String notes;
  final Severity severity;

  MedicalRecord({
    required this.id,
    required this.title,
    required this.date,
    required this.doctor,
    required this.diagnosis,
    required this.symptoms,
    required this.notes,
    required this.severity,
  });
}

class Consultation {
  final String id;
  final DateTime date;
  final String doctor;
  final ConsultationType type;
  final int duration;
  final String notes;
  final String prescription;

  Consultation({
    required this.id,
    required this.date,
    required this.doctor,
    required this.type,
    required this.duration,
    required this.notes,
    required this.prescription,
  });
}

class Medication {
  final String id;
  final String name;
  final String dosage;
  final DateTime startDate;
  final DateTime endDate;
  final String prescribedBy;
  final String purpose;
  final bool isActive;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.startDate,
    required this.endDate,
    required this.prescribedBy,
    required this.purpose,
    required this.isActive,
  });
}

enum Severity { low, medium, high }
enum ConsultationType { routine, followUp, emergency }