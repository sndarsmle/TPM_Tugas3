import 'package:flutter/material.dart';
import 'welcome_page.dart';
import '../session_manager.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  Future<void> _logout(BuildContext context) async {
    await SessionManager.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'BANTUAN',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'Panduan Penggunaan Fitur',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      ExpansionTile(
                        title: Text('Stopwatch',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Fitur Stopwatch digunakan untuk menghitung waktu mundur maupun maju secara real-time. '
                              'Tekan tombol "Mulai" untuk memulai stopwatch, lalu "Berhenti" untuk menghentikannya. '
                              'Gunakan tombol "Reset" untuk mengatur ulang stopwatch ke 0.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Fitur Login digunakan untuk mengautentikasi pengguna sebelum mengakses aplikasi. '
                              'Masukkan username dan password, lalu tekan tombol "LOGIN". Jika data sesuai, pengguna diarahkan ke halaman utama.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('Jenis Bilangan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Fitur Jenis Bilangan digunakan untuk mengenali kategori dari angka yang dimasukkan. '
                              'Pengguna cukup mengetik angka, maka sistem akan menampilkan status apakah bilangan tersebut termasuk bilangan bulat, cacah, prima, positif, negatif, atau desimal, lengkap dengan ikon penanda.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('Konversi Waktu',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Fitur Konversi Waktu digunakan untuk mengubah nilai dari satu satuan waktu ke satuan waktu lainnya. '
                              'Masukkan angka waktu, pilih1satuan asal dan tujuan (misal dari tahun ke detik), maka hasil konversi akan langsung muncul.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('Situs Rekomendasi',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Fitur Situs Rekomendasi menampilkan daftar situs bermanfaat yang bisa dikunjungi langsung melalui aplikasi. '
                              'Tekan ikon hati untuk menandai situs sebagai favorit, dan gunakan tombol "Kunjungi situs" untuk membuka tautan.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('Situs Favorit',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Fitur Situs Favorit menampilkan daftar situs yang telah ditandai pengguna sebelumnya. '
                              'Daftar ini bersifat personal dan bisa diakses kapan saja untuk melihat situs-situs yang dianggap penting.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('Tracking Lokasi (LBS)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Fitur Tracking Lokasi (LBS) digunakan untuk melacak lokasi pengguna secara real-time di Google Maps. '
                              'Tekan tombol "Play" untuk memulai pelacakan dan "Stop" untuk menghentikannya. Posisi ditampilkan dengan marker otomatis.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _logout(context),
                label: const Text(
                  'LOGOUT',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black45,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
