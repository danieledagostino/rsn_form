import 'package:rsn_form/form_widget/date_field.dart';
import 'package:test/test.dart';

void main() {
  test('Select date on datetimefiled change success', () {
    final field = RsnDateField(step: 1, question: '');
    //expect(DateTime.now().day, field.selectedDate.day);
    //expect(DateTime.now().month, field.selectedDate.month);
    final testDate = DateTime.tryParse('1970-01-01');

/*
    field.addListener(() {
      expect(testDate.day, field.selectedDate.day);
      expect(testDate.month, field.selectedDate.month);
    });
    */
    field.update(testDate);
  });
}
