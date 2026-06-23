import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/colors.dart';
import 'package:sigap/l10n/app_localizations.dart';

class EmergencyContact {
  final String nameKey;
  final String number;
  final IconData icon;
  final Color color;

  EmergencyContact({
    required this.nameKey,
    required this.number,
    required this.icon,
    required this.color,
  });
}

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  String _selectedCountry = 'ID'; // Default to Indonesia

  // Mock coordinates for sharing
  final String _mockLatitude = "-6.2088";
  final String _mockLongitude = "106.8456";
  final String _mockAddress = "Jl. M.H. Thamrin No.5, Jakarta Pusat";

  final Map<String, List<EmergencyContact>> _countryContacts = {
    'ID': [
      EmergencyContact(nameKey: 'callAmbulance', number: '118', icon: Icons.medical_services_rounded, color: AppColors.severityCritical),
      EmergencyContact(nameKey: 'callPolice', number: '110', icon: Icons.local_police_rounded, color: AppColors.blueAccent),
      EmergencyContact(nameKey: 'callFireDept', number: '113', icon: Icons.local_fire_department_rounded, color: AppColors.severityModerate),
      EmergencyContact(nameKey: 'callEMS', number: '119', icon: Icons.emergency_share_rounded, color: AppColors.tealPrimary),
    ],
    'US': [
      EmergencyContact(nameKey: 'callAmbulance', number: '911', icon: Icons.medical_services_rounded, color: AppColors.severityCritical),
      EmergencyContact(nameKey: 'callPolice', number: '911', icon: Icons.local_police_rounded, color: AppColors.blueAccent),
      EmergencyContact(nameKey: 'callFireDept', number: '911', icon: Icons.local_fire_department_rounded, color: AppColors.severityModerate),
      EmergencyContact(nameKey: 'callEMS', number: '911', icon: Icons.emergency_share_rounded, color: AppColors.tealPrimary),
    ],
    'UK': [
      EmergencyContact(nameKey: 'callAmbulance', number: '999', icon: Icons.medical_services_rounded, color: AppColors.severityCritical),
      EmergencyContact(nameKey: 'callPolice', number: '999', icon: Icons.local_police_rounded, color: AppColors.blueAccent),
      EmergencyContact(nameKey: 'callFireDept', number: '999', icon: Icons.local_fire_department_rounded, color: AppColors.severityModerate),
      EmergencyContact(nameKey: 'callEMS', number: '111', icon: Icons.emergency_share_rounded, color: AppColors.tealPrimary),
    ],
  };

  Future<void> _makeCall(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        // Fallback alert dialog if calling is not supported (e.g. tablet, emulator)
        _showCallErrorDialog(number);
      }
    } catch (_) {
      _showCallErrorDialog(number);
    }
  }

  void _showCallErrorDialog(String number) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Panggilan Gagal'),
        content: Text('Perangkat tidak mendukung panggilan telepon otomatis. Silakan hubungi nomor ini secara manual: $number'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _shareLocation(String message) {
    Clipboard.setData(ClipboardData(
      text: "SOS! Lokasi Saya:\nLat: $_mockLatitude, Long: $_mockLongitude\nAlamat: $_mockAddress",
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.tealPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  String _getLocalizedContactName(String nameKey, AppLocalizations l10n) {
    switch (nameKey) {
      case 'callAmbulance':
        return l10n.callAmbulance;
      case 'callPolice':
        return l10n.callPolice;
      case 'callFireDept':
        return l10n.callFireDept;
      case 'callEMS':
        return l10n.callEMS;
      default:
        return nameKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final contacts = _countryContacts[_selectedCountry] ?? _countryContacts['ID']!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.emergencyTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // Country Selector Dropdown
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCountry,
                dropdownColor: isDark ? AppColors.cardDark : Colors.white,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.textLightPrimary,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCountry = newValue;
                    });
                  }
                },
                items: const [
                  DropdownMenuItem(value: 'ID', child: Text('🇮🇩 ID (112)')),
                  DropdownMenuItem(value: 'US', child: Text('🇺🇸 US (911)')),
                  DropdownMenuItem(value: 'UK', child: Text('🇬🇧 UK (999)')),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Global Emergency Call Button (Huge Red Button)
                Card(
                  elevation: 6,
                  color: AppColors.severityCritical,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: InkWell(
                    onTap: () => _makeCall(_selectedCountry == 'ID' ? '112' : _selectedCountry == 'UK' ? '999' : '911'),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.contact_phone_rounded,
                            size: 64,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _selectedCountry == 'ID' 
                                ? l10n.sosButton 
                                : "CALL EMERGENCY " + (_selectedCountry == 'UK' ? '999' : '911'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.tapToCall,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Specific Category Phone numbers
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return Card(
                      margin: EdgeInsets.zero,
                      child: InkWell(
                        onTap: () => _makeCall(contact.number),
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: contact.color.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  contact.icon,
                                  color: contact.color,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _getLocalizedContactName(contact.nameKey, l10n),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                contact.number,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Location Card
                Card(
                  elevation: 0,
                  color: isDark ? AppColors.cardDark : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: AppColors.tealPrimary, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              l10n.currentLocation,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Latitude: $_mockLatitude",
                                    style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Longitude: $_mockLongitude",
                                    style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _mockAddress,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () => _shareLocation(l10n.locationMocked),
                          icon: const Icon(Icons.copy_rounded, size: 20),
                          label: Text(l10n.shareLocation.toUpperCase()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.tealPrimary,
                            minimumSize: const Size(double.infinity, 52),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
