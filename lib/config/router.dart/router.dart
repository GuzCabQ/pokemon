import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
    path: '/home/:page',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
]);
