import 'package:flutter/material.dart';
import 'dart:math';

class JenisBilanganPage extends StatefulWidget {
  const JenisBilanganPage({super.key});

  @override
  State<JenisBilanganPage> createState() => _JenisBilanganPageState();
}

class _JenisBilanganPageState extends State<JenisBilanganPage> {
  final TextEditingController _controller = TextEditingController(text: "0");
  Map<String, bool> hasil = {};
  List<String> messages = [];

  final List<String> kategori = [
    'Bilangan Cacah',
    'Bilangan Bulat',
    'Bilangan Desimal',
    'Bilangan Positif',
    'Bilangan Negatif',
    'Bilangan Prima',
  ];

  static const num batasMax = 10000000000000; // 10 triliun
  static const num batasMin = -10000000000000;
  static const int batasCekPrima = 100000000;

  @override
  void initState() {
    super.initState();
    cekJenisBilangan();
  }

  void cekJenisBilangan() {
    final input = _controller.text.trim();
    Map<String, bool> temp = {
      for (var k in kategori) k: false,
    };
    List<String> tempMsg = [];

    final number = num.tryParse(input);

    if (input.isEmpty) {
      setState(() {
        messages = ['❌ Input tidak boleh kosong'];
        hasil = {};
      });
      return;
    }

    if (number == null) {
      setState(() {
        messages = ['❌ Input bukan angka yang valid'];
        hasil = {};
      });
      return;
    }

    if (number > batasMax || number < batasMin) {
      setState(() {
        messages = ['❌ Angka harus antara -$batasMax dan $batasMax'];
        hasil = {};
      });
      return;
    }

    // jika valid
    if (number is int || number == number.roundToDouble()) {
      final int n = number.toInt();

      if (n >= 0) temp['Bilangan Cacah'] = true;
      temp['Bilangan Bulat'] = true;

      if (n > 0) temp['Bilangan Positif'] = true;
      if (n < 0) temp['Bilangan Negatif'] = true;

      if (n > 1 && n <= batasCekPrima && isPrima(n)) {
        temp['Bilangan Prima'] = true;
      } else if (n > batasCekPrima) {
        tempMsg
            .add('⚠ Pengecekan Bilangan Prima diabaikan karena terlalu besar');
      }
    } else {
      temp['Bilangan Desimal'] = true;
      if (number > 0) temp['Bilangan Positif'] = true;
      if (number < 0) temp['Bilangan Negatif'] = true;
    }

    setState(() {
      hasil = temp;
      messages = tempMsg;
    });
  }

  bool isPrima(int number) {
    if (number <= 1) return false;
    for (int i = 2; i <= sqrt(number).toInt(); i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  Widget _buildMessageBox(String text) {
    Color color =
        text.startsWith('❌') ? Colors.red.shade100 : Colors.orange.shade100;
    Color textColor = text.startsWith('❌') ? Colors.red : Colors.orange;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'MENU JENIS BILANGAN',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: SingleChildScrollView(
              // Tambahkan SingleChildScrollView di sini
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Masukkan Bilangan',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _controller,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Masukkan angka...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => cekJenisBilangan(),
                  ),
                  const SizedBox(height: 16),

                  // Error/Warning Box
                  ...messages.map((msg) => _buildMessageBox(msg)),

                  if (hasil.isNotEmpty)
                    ...kategori.map((jenis) {
                      final cocok = hasil[jenis] ?? false;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: Icon(
                            cocok ? Icons.check_circle : Icons.cancel,
                            color: cocok ? Colors.green : Colors.red,
                          ),
                          title: Text(
                            jenis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: cocok ? Colors.black87 : Colors.black45,
                            ),
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
