import 'package:flutter/material.dart';

import '../features/account/presentation/base_currency_screen.dart';
import '../features/account/presentation/change_email_screens.dart';
import '../features/account/presentation/change_password_screens.dart';
import '../features/account/presentation/contacts_screen.dart';
import '../features/account/presentation/contact_us_screen.dart';
import '../features/account/presentation/identity_verification_screen.dart';
import '../features/account/presentation/phone_verification_screen.dart';
import '../features/account/presentation/support_center_screen.dart';
import '../features/account/presentation/wallet_connect_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/cards/presentation/order_card_screen.dart';
import '../features/cards/presentation/security_checklist_screen.dart';
import '../features/cards/presentation/support_request_sent_screen.dart';
import '../features/swap/presentation/dex_selector_screen.dart';
import '../features/swap/presentation/swap_confirm_screen.dart';
import '../features/swap/presentation/swap_main_screen.dart';
import '../features/swap/presentation/swap_settings_screen.dart';
import '../features/wallet/presentation/manage_wallets_screen.dart';
import '../features/wallet/presentation/new_wallet_screen.dart';
import '../features/wallet/presentation/network_list_screen.dart';
import '../features/wallet/presentation/import_wallet_screen.dart';
import '../features/wallet/presentation/receive_screen.dart';
import '../features/wallet/presentation/receive_address_screen.dart';
import '../features/wallet/presentation/send_asset_screen.dart';
import '../features/wallet/presentation/watch_wallet_screen.dart';
import '../features/wallet/presentation/wallet_details_screen.dart';
import '../features/wallet/presentation/private_keys_screen.dart';
import '../features/wallet/presentation/public_keys_screen.dart';
import '../features/wallet/presentation/evm_private_key_screen.dart';
import '../features/wallet/presentation/bip32_root_key_screen.dart';
import '../features/wallet/presentation/recovery_phrase_screen.dart';

class AppRoutes {
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  static const String manageWallets = '/wallet/manage';
  static const String walletDetails = '/wallet/details';
  static const String newWallet = '/wallet/new';
  static const String importWallet = '/wallet/import';
  static const String watchWallet = '/wallet/watch';
  static const String send = '/wallet/send';
  static const String receive = '/wallet/receive';
  static const String receiveAddress = '/wallet/receive/address';
  static const String networks = '/wallet/networks';
  static const String privateKeys = '/wallet/private-keys';
  static const String publicKeys = '/wallet/public-keys';
  static const String evmPrivateKey = '/wallet/evm-private-key';
  static const String bip32RootKey = '/wallet/bip32-root-key';
  static const String recoveryPhrase = '/wallet/recovery-phrase';

  static const String swap = '/swap';
  static const String swapDex = '/swap/dex';
  static const String swapSettings = '/swap/settings';
  static const String swapConfirm = '/swap/confirm';

  static const String orderCard = '/cards/order';
  static const String securityChecklist = '/cards/security';
  static const String supportRequestSent = '/cards/request-sent';

  static const String supportCenter = '/account/support';
  static const String contactUs = '/account/contact';
  static const String walletConnect = '/account/wallet-connect';
  static const String contacts = '/account/contacts';
  static const String baseCurrency = '/account/base-currency';
  static const String changeEmail = '/account/change-email';
  static const String changeEmailVerify = '/account/change-email/verify';
  static const String changePassword = '/account/change-password';
  static const String changePasswordNew = '/account/change-password/new';
  static const String changePasswordDone = '/account/change-password/done';
  static const String phoneVerification = '/account/phone';
  static const String identityVerification = '/account/identity';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case AppRoutes.manageWallets:
        return MaterialPageRoute(builder: (_) => const ManageWalletsScreen());
      case AppRoutes.walletDetails:
        return MaterialPageRoute(builder: (_) => const WalletDetailsScreen());
      case AppRoutes.newWallet:
        return MaterialPageRoute(builder: (_) => const NewWalletScreen());
      case AppRoutes.importWallet:
        return MaterialPageRoute(builder: (_) => const ImportWalletScreen());
      case AppRoutes.watchWallet:
        return MaterialPageRoute(builder: (_) => const WatchWalletScreen());
      case AppRoutes.send:
        return MaterialPageRoute(builder: (_) => const SendAssetScreen());
      case AppRoutes.receive:
        return MaterialPageRoute(builder: (_) => const ReceiveScreen());
      case AppRoutes.receiveAddress:
        return MaterialPageRoute(builder: (_) => const ReceiveAddressScreen());
      case AppRoutes.networks:
        return MaterialPageRoute(builder: (_) => const NetworkListScreen());
      case AppRoutes.privateKeys:
        return MaterialPageRoute(builder: (_) => const PrivateKeysScreen());
      case AppRoutes.publicKeys:
        return MaterialPageRoute(builder: (_) => const PublicKeysScreen());
      case AppRoutes.evmPrivateKey:
        return MaterialPageRoute(builder: (_) => const EvmPrivateKeyScreen());
      case AppRoutes.bip32RootKey:
        return MaterialPageRoute(builder: (_) => const Bip32RootKeyScreen());
      case AppRoutes.recoveryPhrase:
        return MaterialPageRoute(builder: (_) => const RecoveryPhraseScreen());

      case AppRoutes.swap:
        return MaterialPageRoute(builder: (_) => const SwapMainScreen());
      case AppRoutes.swapDex:
        return MaterialPageRoute(builder: (_) => const DexSelectorScreen());
      case AppRoutes.swapSettings:
        return MaterialPageRoute(builder: (_) => const SwapSettingsScreen());
      case AppRoutes.swapConfirm:
        return MaterialPageRoute(builder: (_) => const SwapConfirmScreen());

      case AppRoutes.orderCard:
        return MaterialPageRoute(builder: (_) => const OrderCardScreen());
      case AppRoutes.securityChecklist:
        return MaterialPageRoute(
          builder: (_) => const SecurityChecklistScreen(),
        );
      case AppRoutes.supportRequestSent:
        return MaterialPageRoute(
          builder: (_) => const SupportRequestSentScreen(),
        );

      case AppRoutes.supportCenter:
        return MaterialPageRoute(builder: (_) => const SupportCenterScreen());
      case AppRoutes.contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());
      case AppRoutes.walletConnect:
        return MaterialPageRoute(builder: (_) => const WalletConnectScreen());
      case AppRoutes.contacts:
        return MaterialPageRoute(builder: (_) => const ContactsScreen());
      case AppRoutes.baseCurrency:
        return MaterialPageRoute(builder: (_) => const BaseCurrencyScreen());
      case AppRoutes.changeEmail:
        return MaterialPageRoute(builder: (_) => const ChangeEmailScreen());
      case AppRoutes.changeEmailVerify:
        return MaterialPageRoute(builder: (_) => const VerifyNewEmailScreen());
      case AppRoutes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case AppRoutes.changePasswordNew:
        return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
      case AppRoutes.changePasswordDone:
        return MaterialPageRoute(builder: (_) => const PasswordChangedScreen());
      case AppRoutes.phoneVerification:
        return MaterialPageRoute(
          builder: (_) => const PhoneVerificationScreen(),
        );
      case AppRoutes.identityVerification:
        return MaterialPageRoute(
          builder: (_) => const IdentityVerificationScreen(),
        );
    }

    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: Center(child: Text('Route not found: ${settings.name}')),
      ),
    );
  }
}
