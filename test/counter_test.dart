import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter_testing/app/counter.dart';

void main() {
  late Counter counter;
  // setUp: runs before each test
  setUp(() {
    counter = Counter();
  });

  // setUpAll: runs once before all tests
/*  setUpAll(() {
    // setupAll : runs once
    print('setupAll');
  });*/

  // group: group tests together
  group('Counter class - ', () {
    // given [arrange]
    //final Counter counter = Counter();
    // given when then
    // given: setup : given the Counter class
    // when: action : when the Counter class is instantiated
    // then: expectation : then the value should be zero
    test(
      'When Counter class is instantiated the value should be 0',
      () {
        // when [act]
        final int val = counter.count;
        // then [assert]
        expect(val, 0);
      },
    );

    test(
      'When counter is incremented the value should be 1',
      () {
        // when [act]
        counter.increment();
        final int val = counter.count;
        // then [assert]
        expect(val, 1);
      },
    );

    test(
      'When counter is decremented the value should be -1',
      () {
        // when [act]
        counter.decrement();
        final int val = counter.count;
        // then [assert]
        expect(val, -1);
      },
    );

    test(
      'When counter is reset the value should be 0',
      () {
        // when [act]
        counter.reset();
        final int val = counter.count;
        // then [assert]
        expect(val, 0);
      },
    );
  });

  // tearDown: runs after each test
/*  tearDown(() {
    // tearDown : runs after each test
    print('tearDown');
  });*/

  // tearDownAll: runs once after all tests
  /*tearDownAll(() {
    // tearDownAll : runs once
    print('tearDownAll');
  });*/
}
