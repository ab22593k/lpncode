import 'package:flutter/material.dart';
import 'package:lpncode/lpncode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LPNCode Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LPNDemoPage(),
    );
  }
}

class LPNDemoPage extends StatefulWidget {
  const LPNDemoPage({super.key});

  @override
  State<LPNDemoPage> createState() => _LPNDemoPageState();
}

class _LPNDemoPageState extends State<LPNDemoPage> {
  final generator = LPNGenerator();
  final validator = LPNValidator();
  final scanner = MockLPNScanner();
  LPNData? generatedLPN;
  LPNData? scannedLPN;
  String? validationMessage;

  void _generateNewLPN() {
    setState(() {
      generatedLPN = generator.generateLPN(
        locationCode: 'WH-001',
        metadata: {
          'product': 'Electronics',
          'quantity': 50,
        },
      );
    });
  }

  Future<void> _scanLPN() async {
    final result = await scanner.scan();
    setState(() {
      scannedLPN = result;
    });
  }

  void _validateLPN(String id) {
    final isValid = validator.isValidId(id);
    setState(() {
      validationMessage = isValid
          ? 'Valid LPN format'
          : 'Invalid LPN format - must be 12 characters, A-Z0-9 only';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LPNCode Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Generator section
            const Text(
              'LPN Generator',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _generateNewLPN,
              child: const Text('Generate New LPN'),
            ),
            if (generatedLPN != null) ...[
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${generatedLPN!.id}'),
                      Text('Location: ${generatedLPN!.locationCode}'),
                      Text('Created: ${generatedLPN!.createdAt}'),
                      Text('Metadata: ${generatedLPN!.metadata}'),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 32),

            // Scanner section
            const Text(
              'LPN Scanner',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _scanLPN,
              child: const Text('Scan LPN Barcode'),
            ),
            if (scannedLPN != null) ...[
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Scanned ID: ${scannedLPN!.id}'),
                      Text('Location: ${scannedLPN!.locationCode}'),
                      Text('Created: ${scannedLPN!.createdAt}'),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 32),

            // Validator section
            const Text(
              'LPN Validator',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter LPN to validate',
                hintText: 'e.g., ABC123XYZ789',
                border: OutlineInputBorder(),
              ),
              onChanged: _validateLPN,
            ),
            if (validationMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                validationMessage!,
                style: TextStyle(
                  color: validationMessage!.startsWith('Valid')
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
