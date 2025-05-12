import 'package:flutter/material.dart';
import 'package:tugas3_tpm/screens/favorite_page.dart';
import 'package:tugas3_tpm/screens/jenis_bilangan_page.dart';
import 'package:tugas3_tpm/screens/situs_rekomendasi_page.dart';
import 'package:tugas3_tpm/screens/stopwatch_page.dart';
import 'package:tugas3_tpm/screens/konversiwaktu_page.dart';
import 'package:tugas3_tpm/screens/tracking_lbs_page.dart';

Widget buildMainMenu(BuildContext context) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal, Colors.teal],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo-hijau.jpg', width: 400),
            const SizedBox(height: 12),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalMenuCard(context, 'Stopwatch', Icons.timer, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => StopwatchPage()));
                }),
                verticalMenuCard(context, 'Tracking LBS', Icons.location_on, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => TrackingPage()));
                }),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: menuCard(context, 'Konversi Waktu', Icons.access_time,
                      () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => KonverterWaktuPage()));
                  }),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: menuCard(
                      context, 'Jenis Bilangan', Icons.calculate, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => JenisBilanganPage()));
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            menuCard(context, 'Website Rekomendasi', Icons.web, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SitusRekomendasiPage()));
            }, fullWidth: true),
            const SizedBox(height: 12),
            menuCard(context, 'Favorite', Icons.favorite, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => FavoritePage()));
            }, fullWidth: true),
          ],
        ),
      ),
    ),
  );
}

Widget menuCard(BuildContext context, String title, IconData icon,
    VoidCallback onTap,
    {bool fullWidth = false}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    width: fullWidth ? double.infinity : null,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment:
              fullWidth ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.teal, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                textAlign:
                    fullWidth ? TextAlign.center : TextAlign.start,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget verticalMenuCard(
    BuildContext context, String title, IconData icon, VoidCallback onTap) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.42,
    height: 130,
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.teal, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    ),
  );
}
