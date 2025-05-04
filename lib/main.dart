import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/provider/counter_provider.dart';
import 'package:provider_example/provider/theme_provider.dart';
import 'package:provider_example/provider/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final userName = context.select((UserProvider user) => user.name);
    final userAge = context.select((UserProvider user) => user.age);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Consumer<CounterProvider>(
              builder:
                  (context, value, child) => Text(
                    '${value.count}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
            ),
            SizedBox(height: 20,),
            Consumer<ThemeProvider>(
              builder:
                  (context, theme, child) => Switch(
                    value: theme.isDarkMode,
                    onChanged: (_) => theme.toggleTheme(),//함수 리턴이 아닌 호출을 해야 적용됨()
                  ),
            ),
            SizedBox(height: 20,),
            Text('${userName ?? ''}'),
            Text('${userAge ?? ''}'),
            ElevatedButton(onPressed: () => context.read<UserProvider>().updateName('sunfishes'), child: Text('update name')),
            ElevatedButton(onPressed: () => context.read<UserProvider>().updateAge(22), child: Text('update age')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterProvider>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
