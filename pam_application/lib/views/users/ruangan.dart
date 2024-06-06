import 'package:flutter/material.dart';

class RuanganPage extends StatefulWidget {
  @override
  _RuanganPageState createState() => _RuanganPageState();
}

class _RuanganPageState extends State<RuanganPage> {
  late TextEditingController namaRuanganController;
  late TimeOfDay selectedStartTime;
  late TimeOfDay selectedEndTime;
  late TextEditingController alasanController;

  @override
  void initState() {
    super.initState();
    namaRuanganController = TextEditingController();
    selectedStartTime = TimeOfDay.now();
    selectedEndTime = TimeOfDay.now();
    alasanController = TextEditingController();
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
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
  void dispose() {
    namaRuanganController.dispose();
    alasanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Peminjaman Ruangan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: namaRuanganController,
              decoration: InputDecoration(
                labelText: 'Nama Ruangan',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Jam Peminjaman Awal:'),
                SizedBox(width: 16),
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
                Text('Jam Peminjaman Akhir:'),
                SizedBox(width: 16),
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
              controller: alasanController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Alasan Peminjaman',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implementasi logika pengiriman data peminjaman ruangan ke server atau penyimpanan lokal
                // Misalnya, Anda dapat menampilkan dialog konfirmasi atau mengirimkan data ke API
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Peminjaman Terkirim'),
                      content: Text('Terima kasih! Peminjaman ruangan Anda telah terkirim.'),
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
              child: Text('Kirim Peminjaman'),
            ),
          ],
        ),
      ),
    );
  }
}
