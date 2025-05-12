import 'package:flutter/material.dart';

class KonverterWaktuPage extends StatefulWidget {
  const KonverterWaktuPage({super.key});

  @override
  State<KonverterWaktuPage> createState() => _KonverterWaktuPageState();
}

class _KonverterWaktuPageState extends State<KonverterWaktuPage> {
  final TextEditingController inputController = TextEditingController();
  double result = 0;
  String errorText = '';

  String fromUnit = 'Tahun (yr)';
  String toUnit = 'Detik (sec)';

  final Map<String, double> timeUnits = {
    'Tahun (yr)': 31536000, // 365 hari
    'Hari (day)': 86400,
    'Jam (hr)': 3600,
    'Menit (min)': 60,
    'Detik (sec)': 1,
  };

  void convert() {
    final input = double.tryParse(inputController.text);
    if (input == null) {
      setState(() {
        errorText = '❌ Masukkan nilai yang valid';
        result = 0;
      });
      return;
    }

    final fromValue = timeUnits[fromUnit]!;
    final toValue = timeUnits[toUnit]!;

    setState(() {
      result = input * fromValue / toValue;
      errorText = ''; // Clear the error when conversion is valid
    });
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
          'MENU KONVERSI WAKTU',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Masukkan Nilai Waktu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Input Field
                  TextField(
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Masukkan nilai',
                      border: const OutlineInputBorder(),
                      errorText: errorText.isEmpty ? null : errorText,
                    ),
                    onChanged: (_) => convert(),
                  ),
                  const SizedBox(height: 16),

                  // Custom Dropdown for "From" unit
                  DropdownButton<String>(
                    value: fromUnit,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down_circle_outlined,
                        color: Colors.teal),
                    iconSize: 30,
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    items: timeUnits.keys.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        fromUnit = value!;
                        convert();
                      });
                    },
                  ),
                  const SizedBox(height: 16),



                  // Output Field for Result
                  TextField(
                    readOnly: true,
                    controller:
                        TextEditingController(text: result.toStringAsFixed(2)),
                    decoration: const InputDecoration(
                      labelText: 'Hasil konversi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Custom Dropdown for "To" unit
                  DropdownButton<String>(
                    value: toUnit,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down_circle_outlined,
                        color: Colors.teal),
                    iconSize: 30,
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    items: timeUnits.keys.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        toUnit = value!;
                        convert();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
