import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SuratPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Surat'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SuratCard(
                title: 'Surat Penggantian KTM',
                icon: FontAwesomeIcons.idCard,
              ),
              SuratCard(
                title: 'Surat Mahasiswa Aktif',
                icon: FontAwesomeIcons.userGraduate,
              ),
              SuratCard(
                title: 'Surat Pengantar Proyek',
                icon: FontAwesomeIcons.fileSignature,
              ),
              SuratCard(
                title: 'Surat Pengantar Magang',
                icon: FontAwesomeIcons.briefcase,
              ),
              SuratCard(
                title: 'Surat MBKM',
                icon: FontAwesomeIcons.award,
              ),
              SuratCard(
                title: 'Surat Pengantar Kompetisi',
                icon: FontAwesomeIcons.trophy,
              ),
              SuratCard(
                title: 'Surat Pengantar Tugas Akhir',
                icon: FontAwesomeIcons.graduationCap,
              ),
              SuratCard(
                title: 'Surat Permohonan Kerja Praktek',
                icon: FontAwesomeIcons.suitcase,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuratCard extends StatelessWidget {
  final String title;
  final IconData icon;

  SuratCard({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: FaIcon(icon, size: 30),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios), // Tambahkan panah di sini
        onTap: () {
          // Handle card tap
        },
      ),
    );
  }
}
