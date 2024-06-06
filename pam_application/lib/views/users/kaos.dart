import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: kaospage(),
  ));
}

class kaospage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pesan Kaos'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: KaosOrderForm(),
      ),
    );
  }
}

class KaosOrderForm extends StatefulWidget {
  @override
  _KaosOrderFormState createState() => _KaosOrderFormState();
}

class _KaosOrderFormState extends State<KaosOrderForm> {
  String selectedSize = '';
  String selectedPayment = '';
  String jumlahNominal = '';

  Map<String, int> hargaUkuran = {
    'S': 50000,
    'M': 60000,
    'L': 70000,
    'XL': 80000,
    'XXL': 90000,
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Pilih Ukuran Kaos:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSizeButton('S'),
                buildSizeButton('M'),
                buildSizeButton('L'),
                buildSizeButton('XL'),
                buildSizeButton('XXL'),
              ],
            ),
            SizedBox(height: 10),
            Text('Pilih Jenis Pembayaran:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildPaymentButton('Transfer'),
                buildPaymentButton('Cash'),
              ],
            ),
            SizedBox(height: 10),
            Text(
              selectedSize.isNotEmpty
                  ? 'Harga: ${hargaUkuran[selectedSize]}'
                  : 'Pilih ukuran kaos terlebih dahulu.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Jumlah Nominal',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                jumlahNominal = value;
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (selectedSize.isNotEmpty && selectedPayment.isNotEmpty) {
                  final harga = hargaUkuran[selectedSize];

                  if (int.parse(jumlahNominal) >= harga!) {
                    final response = await http.post(
                      Uri.parse('http://192.168.216.253:3060/api/'),
                      body: {
                        'ukuran_kaos': selectedSize,
                        'jenis_pembayaran': selectedPayment,
                        'jumlah_nominal': jumlahNominal,
                        'harga': harga.toString(),
                      },
                    );

                    if (response.statusCode == 200) {
                      showAlertDialog('Pembayaran Berhasil', 'Pesanan kaos Anda telah berhasil diproses.');
                    } else {
                      showAlertDialog('Pembayaran Gagal', 'Terjadi kesalahan saat memproses pesanan kaos Anda.');
                    }
                  } else {
                    showAlertDialog('Pembayaran Gagal', 'Jumlah nominal tidak mencukupi untuk pembayaran.');
                  }
                } else {
                  showAlertDialog('Pembayaran Gagal', 'Pilih ukuran kaos dan jenis pembayaran terlebih dahulu.');
                }
              },
              child: Text('Pesan Kaos'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSizeButton(String size) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedSize = size;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: selectedSize == size ? Colors.green : null,
      ),
      child: Text(size),
    );
  }

  Widget buildPaymentButton(String payment) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedPayment = payment;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: selectedPayment == payment ? Colors.blue : null,
      ),
      child: Text(payment),
    );
  }

  void showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
