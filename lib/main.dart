/// Flutter関係のインポート
import 'package:counterapp/normal_counter_page.dart';
import 'package:flutter/material.dart';

/// Firebase関係のインポート
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

/// 他ページのインポート

/// メイン
void main() async {
  /// Firebaseの初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// runApp w/ Riverpod
  runApp(const ProviderScope(child: MyApp()));
}

/// Providerの初期化
final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  /// カウントアップ
  void increment() => state++;
}

/// MaterialAppの設定
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// ホームページ画面
class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Homepage'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: const <Widget>[
          _PagePushButton(
            buttonTitle: 'ノーマルカウンター',
            pagename: NormalCounterPage(),
          ),
        ],
      ),
    );
  }
}

class _PagePushButton extends StatelessWidget {
  const _PagePushButton({
    Key? key,
    required this.buttonTitle,
    required this.pagename,
  }) : super(key: key);

  final String buttonTitle;
  final dynamic pagename;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(buttonTitle),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pagename),
        );
      },
    );
  }
}
