import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SitusRekomendasiPage extends StatefulWidget {
  const SitusRekomendasiPage({super.key});

  @override
  State<SitusRekomendasiPage> createState() => _SitusRekomendasiPageState();
}

class _SitusRekomendasiPageState extends State<SitusRekomendasiPage> {
  final List<Map<String, String>> rekomendasi = [
    {
      'title': 'DAREBEE',
      'url': 'https://www.darebee.com',
      'image': 'https://th.bing.com/th/id/OIP.ipfZ3qnwSQyE0p_gUseV2gAAAA?w=186&h=186&c=7&r=0&o=7&cb=iwp2&dpr=1.1&pid=1.7&rm=3',
      'description':
          'Lebih dari 2.300 latihan gratis dengan ilustrasi dan program mingguan. Cocok untuk latihan di rumah tanpa alat.',
    },
    {
      'title': 'ACE Fitness',
      'url':
          'https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/',
      'image': 'https://th.bing.com/th/id/OIP.TWia-DVDt9pYYC091XLnAwHaHa?w=157&h=180&c=7&r=0&o=7&cb=iwp2&dpr=1.1&pid=1.7&rm=3',
      'description':
          'Koleksi latihan dengan panduan langkah demi langkah, termasuk pemanasan, kekuatan, dan fleksibilitas.',
    },
    {
      'title': 'JEFIT',
      'url': 'https://www.jefit.com/routines',
      'image': 'https://th.bing.com/th/id/OIP.6uj5D7gzSNc30nOKmhHnUAHaHa?w=173&h=180&c=7&r=0&o=7&cb=iwp2&dpr=1.1&pid=1.7&rm=3',
      'description':
          'Database latihan berdasarkan kelompok otot dan peralatan, cocok untuk perencanaan latihan di gym.',
    },
    {
      'title': 'Fitness Blender',
      'url': 'https://www.fitnessblender.com',
      'image': 'https://th.bing.com/th/id/OIP.cwhB0dOnrA-aTl7m5z4ZmAHaHa?w=177&h=180&c=7&r=0&o=7&cb=iwp2&dpr=1.1&pid=1.7&rm=3',
      'description':
          'Platform dengan ratusan video latihan gratis, mulai dari HIIT hingga yoga, yang dapat disesuaikan dengan kebutuhan.',
    },
    {
      'title': 'MuscleWiki',
      'url': 'https://musclewiki.com',
      'image': 'https://th.bing.com/th/id/OIP.Gxb7BDrvZyd8hQb1IbP3fAHaHa?w=168&h=180&c=7&r=0&o=7&cb=iwp2&dpr=1.1&pid=1.7&rm=3',
      'description':
          'Situs interaktif untuk memilih kelompok otot dan melihat latihan terkait, lengkap dengan video dan instruksi.',
    },
    {
      'title': 'WorkoutLabs',
      'url': 'https://workoutlabs.com/exercise-guide/',
      'image': 'https://th.bing.com/th/id/OIP.9VzGk-HPoJ-y5sHhebGvzAHaHO?w=186&h=181&c=7&r=0&o=7&cb=iwp2&dpr=1.1&pid=1.7&rm=3',
      'description':
          'Perpustakaan latihan dengan diagram dan ilustrasi animasi, cocok untuk semua level kebugaran.',
    },
    {
      'title': 'NASM Exercise Library',
      'url': 'https://www.nasm.org/',
      'image': 'https://th.bing.com/th/id/OIP.yrUOcBixS8GfzMYUwe8nTwHaD3?w=322&h=180&c=7&r=0&o=7&cb=iwp2&dpr=1.1&pid=1.7&rm=3',
      'description':
          'Panduan latihan dari National Academy of Sports Medicine dengan instruksi langkah demi langkah.',
    },
    {
      'title': 'Daily Burn',
      'url': 'https://dailyburn.com',
      'image': 'data:image/webp;base64,UklGRvYHAABXRUJQVlA4IOoHAABQLgCdASqxAMYAPp1Gn0wlo6KiJdJKILATiWVu4W0Q+PdM1e7G6CjvvROYeeT5gH6v9IjzAfsB6tH9Q9XnoAdKV6D37Femz7PGQk+bf8x3A/6nlx5iRM/n27G5XvATjw764xb9N+dn6y9hDy0PX1+4fsYfp2T2uUP6KbKWexHNGVnJ1RSz2Nxro3CmuMYGtPG7Iwi0B3M0qD5FPQlqN4/4CIaEyk1YjP477G5RldYjiN2yDVmjDkfHVzc2Us3tink3Y3v1iWGWYorZGe05Acl40gkOm+tZMH1HN9qmb5mkJoYdvQde5Ek/7hTse1AQR8gD+U9YcnH76meTGPWEKK+z6pK2cLbZMOdu/2pZxhvxThdBUfckgvg4+9WQ+gNLih6aj3nGOGHz9CME+6LOAC45r5FTZLBCCLk1LOPQm6wtxsfHiBsq+PWtTTXPSakJP0lpV/rjUW6wBpKSsMWXa/0BJNM5e32NJhdRS2dRRH2NVEHUJyHY3KZ47lFgAP7+OdADyNQFS2yrulvg1/9l1R+BRTgDyp/oEff/qee1dUVvS/2dUccTNDSmgxIdyPMUcYsPpUAdNCDsSTauqNLR1geQ91i7AoXmQO07W/cvo6R3C4CosOO+SYnixk8oLfJiaX3ppcQd+YEc+FTwc6zI5SNOrgdLvKj/HEJhPKi+Qlc5TDCxToe4dMmNtHJW8YlYOcY1ndEAEyHtn+5YTysqFk1si2XZtfJLdB4bYzZSnePXvvrJrhL1dVJ+r/Cs10ZfB1OJqoyYnJw+e1vyW9mQOZRfxVVlsjg3xt1hRZ2sSg4iSpgHvaDxG0mKDrot2gN788ylyY1Q4ZEoZqzkum76zOIiiKQwYEY74IOT/RYAjEQE33Iix/XEAeRY4abYU/TU9X9oBMZCcthPsfoh10AJZoYJ9NJfYb4cgA+/S885NyhHKP/JCmX453XH0iQXCIwj/blcQuIMz/uAYimSUcxqcUa3YYj1h2S8YeuMEDF7Jqokht+wdbuzMYLpTE38HAa29i0N29PbEnCoGWQGidZoETiDAzkSRzJ/dRX3jHvcgZU1cZPwA8UDlMx30rLHqACOA+wqrATijT+9GgRrRNzM1R2CJRqeAU5m6yIR22CQKjp3DVtJgKqN3odq2uXcgGSAZV7oZueegWZs4Sx33+13RJod5mnYwPbN34Ua37jQPUjfxXqPh73fMYMJk5eznR48EeuLr3QSKC+FnDvJ9UViH6y670c/+3M9YlsW9dvXg66Os012L+tHulKQHb3bGGsiGvn5OhKtD/JH2d4lB8uTryOnnKpxiwjLDPMD2M8YXcUK7CHK2QRtHZaRMboqeLR34foYiVYB1xAyRvv3JjiEgj/Z+Ruh3Nh3pZDnUi2DzCVQYfYs9Ql5/1kG1c7HsRIax9IFOg2IUkWVcgRkF/ZbkBrUI4v6DIY33a+XnfuteOcfnfxovGsS7+KA+rhOWdYoU7UjNFCNimVL0ieVKfU1e08yIt4V2H9ZLVq/u1E7xsSKBF9rOFpWSBZ9rFunnOO0sjNseb/txz/VjKkH6A1QtlvCfVBAcdujVu+jOI6PqKs2EXlRnGkOJYgCjkmxeRmiW+9ECD3MRUMPnvuMEWB8Vd5Pi8mcslSNAN53I0tfbaB/swGnRTWW4iiACxjIKih+W4rqyu9+/UNjCs6UrmWp71i0MhK5cIjMyHBegiR51kEImZl2KxJggNz5Itl0FHd30RqXEBBRME5E/GAQ2y2Nvx6RO4JN+pr+PhK5/80ergHaNRG955Y41N5n65aNziryh9PNGhaD5YDVkKZ9XN/avfJA4kkHcb/IznJWQvmz+4QeU2LEm82e74TeVORFJuxCotgiH7PTk53uPeSXrg7Focp9eSo3Ad5UtVYs/VYekxJmEISbl8NV7urCk2UM4IKbRGwzfxITtD2Lv7ukBoAFMwtnzEm04EI4IPlpt/hK+ZnFFlrQxStyYX4hxUOB3I3zZuA8DiZ2fmnG+Q9JL8u8PMgvZ5zFnulqKbOcU8Avzi2CYAghtVZGaHCOwL+c/qTZ/TVrydbmA1rfsa1xSbE06b1t84Zsn4vSqnXxgQmI4MC/kDl152zzhwJszg389FWKPoJAUdeRluqa33xpb9ony43ZKyGth15+J/NhrRpxudv4HgP/yVwq2/kLJ1QPy6L1XAMedwe2weW8NwBNxWdXYvn9iSk4mlRfFzCdEfnFhrRHRDWefZw8Sr/8lJDH/JZO/4vq+f/8x2ylY0u/m9bIPDCeFtdJfx03khTOadCgn6dvWkS7pwB3m5rkaWKNnT5lTK23tnNol01Vf3JptWpuhmQ1om8GkjeZBYAImclN/TCHHM65BEC3px8M1U0fAwzXstvVQ1OpEylZ3+XvwQ1fdsDybdrTjUMppSGbfSY7vh4T8ghjyVGmU/bznMvW+RNI/XXuncAmnL1+cGAKSGX/+uZsBcug1xM4HuTNici1ngFo5mIkR7dbaTKc2F7A+5T7BGrIXzcr/fbvBrs0sjgeo6xopLj7iXOwVwDeyxbzOLl1t8oXcbHMT+SnmcJmHgpGYpOdTFrtEP/86dn7hJZvQyd2YnAbCqouCAGjBuTrPps4WceYyIX8Qih9HdH3SrHvwImsfEw26RsXm6O8eT8R8TpcQYKlbFPwDmP0cRiXcsJDPCCgNK5C5sUxEYQKM8tmmdcLySSwDXs1R4AA',
      'description':
          'Video latihan streaming yang dipandu oleh pelatih profesional, tersedia melalui web dan aplikasi.',
    },
    {
      'title': 'ExRx.net',
      'url': 'https://exrx.net/Lists/Directory',
      'image': 'https://th.bing.com/th/id/OIP.GrQ5Z7q6w4dLHZs_877-EwHaFj?w=240&h=180&c=7&r=0&o=7&cb=iwp2&dpr=1.1&pid=1.7&rm=3',
      'description':
          'Informasi mendalam tentang latihan, analisis fisiologis, dan animasi instruksional.',
    },
  ];

  Set<String> favorites = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favoriteSites') ?? [];
    setState(() {
      favorites = favList.toSet();
    });
  }

  Future<void> _toggleFavorite(String url) async {
    final prefs = await SharedPreferences.getInstance();
    if (favorites.contains(url)) {
      favorites.remove(url);
    } else {
      favorites.add(url);
    }
    await prefs.setStringList('favoriteSites', favorites.toList());
    setState(() {});
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SITUS REKOMENDASI',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
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
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: rekomendasi.length,
          itemBuilder: (context, index) {
            final site = rekomendasi[index];
            final isFav = favorites.contains(site['url']);
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          site['image']!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 60),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              site['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF1D1C4C),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              site['description']!,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => _launchURL(site['url']!),
                        icon: const Icon(Icons.open_in_new, size: 18),
                        label: const Text(
                          'Kunjungi situs',
                          style: TextStyle(fontSize: 13),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blueAccent,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => _toggleFavorite(site['url']!),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
