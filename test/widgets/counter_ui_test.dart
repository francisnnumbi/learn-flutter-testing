import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter_testing/app/ui/counter_ui.dart';

void main() {
  group('CounterUi', () {
    testWidgets('should display the title', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester
          .pumpWidget(const MaterialApp(home: CounterUi(title: 'Counter')));

      // Verify that our counter starts at 0.
      expect(find.text('Counter'), findsOneWidget);
    });

    testWidgets('should display the counter', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester
          .pumpWidget(const MaterialApp(home: CounterUi(title: 'Counter')));

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('should increment the counter', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester
          .pumpWidget(const MaterialApp(home: CounterUi(title: 'Counter')));

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);

      final Finder incrementFinder =
          find.byKey(const Key('counterUi_increment_floatingActionButton'));

      final incrementButton = tester.widget<FloatingActionButton>(
        incrementFinder,
      );

      expect(incrementButton.backgroundColor, Colors.green.shade300);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(
          find.byKey(const Key('counterUi_increment_floatingActionButton')));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should decrement the counter', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester
          .pumpWidget(const MaterialApp(home: CounterUi(title: 'Counter')));

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);

      final Finder decrementFinder =
          find.byKey(const Key('counterUi_decrement_floatingActionButton'));

      final decrementButton = tester.widget<FloatingActionButton>(
        decrementFinder,
      );

      expect(decrementButton.backgroundColor, Colors.red.shade300);

      // Tap the '-' icon and trigger a frame.
      await tester.tap(
          find.byKey(const Key('counterUi_decrement_floatingActionButton')));
      await tester.pump();

      // Verify that our counter has decremented.
      expect(find.text('-1'), findsOneWidget);
    });
  });
}
