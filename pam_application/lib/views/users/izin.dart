import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PermissionPage(),
  ));
}

class PermissionPage extends StatefulWidget {
  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Izin'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Izin Keluar'),
            Tab(text: 'Izin Bermalam'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PermissionForm(type: PermissionType.leave),
          PermissionForm(type: PermissionType.overnight),
        ],
      ),
    );
  }
}

enum PermissionType {
  leave,
  overnight,
}

class PermissionForm extends StatefulWidget {
  final PermissionType type;

  PermissionForm({required this.type});

  @override
  _PermissionFormState createState() => _PermissionFormState();
}

class _PermissionFormState extends State<PermissionForm> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  String purpose = '';
  String destination = '';

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: isStartDate ? selectedStartDate : selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != null &&
        picked != (isStartDate ? selectedStartDate : selectedEndDate)) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = picked;
        } else {
          selectedEndDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    bool isStartTime,
  ) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: isStartTime ? selectedStartTime : selectedEndTime,
    ))!;

    if (picked != null &&
        picked != (isStartTime ? selectedStartTime : selectedEndTime)) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = picked;
        } else {
          selectedEndTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Rencana Berangkat:'),
                SizedBox(width: 16),
                IconButton(
                  onPressed: () => _selectDate(context, true),
                  icon: Icon(Icons.date_range),
                ),
                SizedBox(width: 8),
                Text('${selectedStartDate.toLocal()}'.split(' ')[0]),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () => _selectTime(context, true),
                  icon: Icon(Icons.access_time),
                ),
                SizedBox(width: 8),
                Text('${selectedStartTime.format(context)}'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Rencana Kembali:'),
                SizedBox(width: 16),
                Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: IconButton(
                    onPressed: () => _selectDate(context, false),
                    icon: Icon(Icons.date_range),
                  ),
                ),
                SizedBox(width: 8),
                Text('${selectedEndDate.toLocal()}'.split(' ')[0]),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () => _selectTime(context, false),
                  icon: Icon(Icons.access_time),
                ),
                SizedBox(width: 8),
                Text('${selectedEndTime.format(context)}'),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  purpose = value;
                });
              },
              maxLines: 3,
              decoration: InputDecoration(
                labelText: widget.type == PermissionType.leave
                    ? 'Keperluan Izin Keluar'
                    : 'Keperluan Izin Bermalam',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
            widget.type == PermissionType.overnight
                ? SizedBox(height: 16)
                : Container(),
            widget.type == PermissionType.overnight
                ? TextField(
                    onChanged: (value) {
                      setState(() {
                        destination = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Tujuan Izin Bermalam',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  )
                : Container(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(widget.type == PermissionType.leave
                          ? 'Izin Keluar Terkirim'
                          : 'Izin Bermalam Terkirim'),
                      content: Text('Silahkan menunggu persetujuan'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(widget.type == PermissionType.leave
                  ? 'Kirim Izin Keluar'
                  : 'Kirim Izin Bermalam'),
            ),
          ],
        ),
      ),
    );
  }
}
