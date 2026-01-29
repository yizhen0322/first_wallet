import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/theme/app_theme.dart';

/// QR Scanner screen that returns scanned address.
class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _hasScanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if running on web - camera scanning not supported
    if (kIsWeb) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            icon: const Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Scan QR Code',
            style: TextStyle(color: AppColors.textPrimary),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.no_photography,
                  size: 64,
                  color: AppColors.textSecondary.withValues(alpha: 128),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Camera not available on web',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please use paste button instead',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Scanner
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),
          // Overlay
          _buildOverlay(),
          // Close button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // Title
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 0,
            right: 0,
            child: const Text(
              'Scan QR Code',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Instructions
          Positioned(
            bottom: 100,
            left: 40,
            right: 40,
            child: const Text(
              'Position the QR code within the frame',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Torch button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: IconButton(
                icon: ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, state, child) {
                    return Icon(
                      state.torchState == TorchState.on
                          ? Icons.flash_on
                          : Icons.flash_off,
                      color: Colors.white,
                      size: 28,
                    );
                  },
                ),
                onPressed: () => _controller.toggleTorch(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.black.withValues(alpha: 128),
        BlendMode.srcOut,
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;

    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final value = barcode.rawValue;
      if (value == null) continue;

      // Parse ethereum address from various formats
      String address = value;

      // Handle ethereum: URI scheme
      if (value.startsWith('ethereum:')) {
        address = value.substring(9);
        // Remove any parameters
        final atIndex = address.indexOf('@');
        if (atIndex > 0) {
          address = address.substring(0, atIndex);
        }
        final questionIndex = address.indexOf('?');
        if (questionIndex > 0) {
          address = address.substring(0, questionIndex);
        }
      }

      if (!address.startsWith('0x')) continue;

      try {
        final parsed = EthereumAddress.fromHex(address);
        _hasScanned = true;
        Navigator.of(context).pop(parsed.hex);
        return;
      } catch (_) {
        // Keep scanning
      }
    }
  }
}
