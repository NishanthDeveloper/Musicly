import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicly/core/providers/current_user_notifier.dart';
import 'package:musicly/core/theme/theme.dart';
import 'package:musicly/features/auth/view/pages/signup_page.dart';
import 'package:musicly/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:musicly/features/home/view/pages/home_page.dart';
import 'package:musicly/features/home/view/pages/upload_song_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  final container = ProviderContainer();

  // Ensure shared preferences are initialized
  await container.read(authViewModelProvider.notifier).initSharedPreferences();

  // Fetch user data (this will wait for the data to load)
 final user =  await container.read(authViewModelProvider.notifier).getData();
print(user);
  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.x
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Musicly',
        theme: AppTheme.darkThemeMode,
        home: currentUser == null ? SignupPage() : const HomePage());
  }
}
