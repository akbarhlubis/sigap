import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import 'package:sigap/l10n/app_localizations.dart';

class LearningTopic {
  final String titleId;
  final String titleEn;
  final String categoryId;
  final String categoryEn;
  final IconData icon;
  final List<String> contentId;
  final List<String> contentEn;

  LearningTopic({
    required this.titleId,
    required this.titleEn,
    required this.categoryId,
    required this.categoryEn,
    required this.icon,
    required this.contentId,
    required this.contentEn,
  });
}

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final List<LearningTopic> _topics = [
    LearningTopic(
      titleId: "Prinsip Dasar Pertolongan Pertama (P3K)",
      titleEn: "Basic First Aid Principles (3Cs)",
      categoryId: "Dasar P3K",
      categoryEn: "First Aid Basics",
      icon: Icons.health_and_safety_rounded,
      contentId: [
        "1. Amankan Diri (Check): Pastikan lingkungan aman sebelum menolong korban agar Anda tidak menjadi korban berikutnya.",
        "2. Panggil Bantuan (Call): Hubungi nomor darurat 112 jika kondisi korban tidak sadar, sesak napas, atau pendarahan hebat.",
        "3. Beri Pertolongan (Care): Rawat korban dengan tenang sesuai instruksi di aplikasi ini hingga petugas medis tiba.",
        "4. Jaga Ketenangan: Jangan panik, kepanikan mempersulit pengambilan keputusan yang rasional."
      ],
      contentEn: [
        "1. Check the Scene: Ensure the environment is safe for you and the victim before approaching.",
        "2. Call for Help: Contact emergency services (112) immediately if the victim is unresponsive or seriously injured.",
        "3. Care for the Victim: Provide calm first aid based on app guidelines until medical professionals arrive.",
        "4. Stay Calm: Panic impairs decision-making. Take deep breaths and work systematically."
      ],
    ),
    LearningTopic(
      titleId: "Daftar Perlengkapan Kotak P3K Mandiri",
      titleEn: "First Aid Kit Checklist",
      categoryId: "Persiapan",
      categoryEn: "Preparedness",
      icon: Icons.medical_information_rounded,
      contentId: [
        "• Kasa Steril & Perban Gulung (berbagai ukuran)",
        "• Plester Luka (Band-Aid) untuk luka kecil",
        "• Cairan Antiseptik (Povidone Iodine / Betadine)",
        "• Gunting Medis & Pinset",
        "• Sarung Tangan Latex Steril (melindungi dari infeksi darah)",
        "• Masker Medis Cadangan",
        "• Obat-obatan Pribadi (pereda nyeri, anti-alergi)"
      ],
      contentEn: [
        "• Sterile Gauze Pads & Roller Bandages (assorted sizes)",
        "• Adhesive Bandages (Plasters) for small cuts",
        "• Antiseptic Wipes or Liquid (Povidone Iodine)",
        "• Medical Scissors & Tweezers",
        "• Sterile Disposable Gloves (protects against bloodborne pathogens)",
        "• Surgical Masks",
        "• Personal Medication (painkillers, anti-allergics)"
      ],
    ),
    LearningTopic(
      titleId: "Kesiapsiagaan Bencana Alam di Rumah",
      titleEn: "Natural Disaster Preparedness at Home",
      categoryId: "Bencana",
      categoryEn: "Disaster Ready",
      icon: Icons.tsunami_rounded,
      contentId: [
        "1. Siapkan Tas Siaga Bencana (TSB): Berisi air minum, makanan instan, senter, peluit, dokumen penting, dan kotak P3K.",
        "2. Pahami Jalur Evakuasi: Tentukan titik kumpul keluarga di luar rumah saat terjadi gempa bumi atau kebakaran.",
        "3. Matikan Instalasi Utama: Ketahui cara mematikan listrik, gas, dan air untuk menghindari ledakan atau sengatan listrik.",
        "4. Simpan Kontak Darurat: Catat nomor penting seperti Pemadam Kebakaran dan Ambulans di dekat pintu keluar."
      ],
      contentEn: [
        "1. Prepare a Go-Bag (Emergency Kit): Include water, non-perishable food, flashlight, whistle, documents, and first aid kit.",
        "2. Establish Evacuation Routes: Agree on a family assembly point outside the house in case of fire or earthquakes.",
        "3. Know Utility Shut-offs: Learn how to quickly turn off household gas, electricity, and water supplies.",
        "4. Save Emergency Contacts: Write down critical numbers (Fire, Police, Ambulance) and post them near the door."
      ],
    ),
    LearningTopic(
      titleId: "Pencegahan Cedera pada Anak",
      titleEn: "Child Injury Prevention",
      categoryId: "Pencegahan",
      categoryEn: "Prevention",
      icon: Icons.child_care_rounded,
      contentId: [
        "• Jauhkan Benda Kecil: Koin, kancing, atau mainan kecil berisiko tertelan dan menyumbat pernapasan (tersedak).",
        "• Amankan Stopkontak: Pasang pelindung penutup pada colokan listrik rendah yang terjangkau balita.",
        "• Kunci Bahan Kimia: Simpan sabun cuci, pembersih lantai, dan obat-obatan di lemari tinggi terkunci.",
        "• Pasang Pagar Pengaman: Gunakan pembatas pada tangga rumah untuk mencegah jatuh."
      ],
      contentEn: [
        "• Keep Small Objects Away: Coins, buttons, or tiny toys are choking hazards for toddlers.",
        "• Cover Outlets: Place safety covers on low electrical outlets within reach of crawling children.",
        "• Lock Away Chemicals: Store laundry detergents, floor cleaners, and drugs in high, locked cabinets.",
        "• Use Safety Gates: Install barriers at the top and bottom of stairs to prevent falls."
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.learningTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _topics.length,
          itemBuilder: (context, index) {
            final topic = _topics[index];
            final title = locale == 'en' ? topic.titleEn : topic.titleId;
            final category = locale == 'en' ? topic.categoryEn : topic.categoryId;
            final content = locale == 'en' ? topic.contentEn : topic.contentId;

            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              child: ExpansionTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.tealPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(topic.icon, color: AppColors.tealPrimary, size: 24),
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.tealPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                childrenPadding: const EdgeInsets.all(16),
                expandedAlignment: Alignment.topLeft,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: content.map((line) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          line,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                          ),
                        ),
                      );
                    }).toList(),
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
