part of 'day_bloc.dart';

enum DayStatus {
  initial,
}

class DayState extends Equatable {
  const DayState(
      {this.status = DayStatus.initial,
      this.day = const Day(zones: [
        Zone(
            label: 'Open',
            start: TimeOfDay(hour: 8, minute: 0),
            stop: TimeOfDay(
              hour: 8,
              minute: 59,
            ),
            footholds: [
              Foothold(label: 'Make the Bed', icon: Icon(Icons.bed)),
              Foothold(label: 'Open the Windows', icon: Icon(Icons.window)),
              Foothold(label: 'Start Coffee', icon: Icon(Icons.coffee)),
              Foothold(label: 'Play Wakeup Music', icon: Icon(Icons.music_note))
            ]),
        Zone(
          label: 'Bootup',
          start: TimeOfDay(hour: 9, minute: 0),
          stop: TimeOfDay(hour: 9, minute: 59),
          footholds: [
            Foothold(label: 'Ping Work Computer', icon: Icon(Icons.work)),
            Foothold(label: 'Get Dressed', icon: Icon(Icons.person)),
            Foothold(label: 'Walk the Dogs', icon: Icon(Icons.pets)),
            Foothold(label: 'Wakeup Dose', icon: Icon(Icons.medication_rounded))
          ],
        ),
        Zone(
          label: 'Launch',
          start: TimeOfDay(hour: 10, minute: 0),
          stop: TimeOfDay(hour: 11, minute: 29),
          footholds: [
            Foothold(label: 'Breakfast', icon: Icon(Icons.dining)),
            Foothold(
                label: 'Play Calming Cafe Music', icon: Icon(Icons.music_note)),
            Foothold(label: 'Play with Dogs', icon: Icon(Icons.pets)),
            Foothold(label: 'Todo Housekeeping', icon: Icon(Icons.task_alt))
          ],
        ),
        Zone(
          label: 'Work',
          start: TimeOfDay(hour: 11, minute: 30),
          stop: TimeOfDay(hour: 16, minute: 59),
          footholds: [
            Foothold(label: 'Go to Your Job', icon: Icon(Icons.work)),
            Foothold(label: 'Errands', icon: Icon(Icons.task_alt)),
            Foothold(
                label: 'Work on Personal Project',
                icon: Icon(Icons.star_rounded)),
            Foothold(label: 'Chores', icon: Icon(Icons.cleaning_services)),
            Foothold(label: 'Eat Protein Snacks', icon: Icon(Icons.dining))
          ],
        ),
        Zone(
          label: 'Log Off',
          start: TimeOfDay(hour: 17, minute: 0),
          stop: TimeOfDay(hour: 17, minute: 59),
          footholds: [
            Foothold(label: 'Close Work Computer', icon: Icon(Icons.work)),
            Foothold(label: 'Tidy Up', icon: Icon(Icons.cleaning_services)),
            Foothold(label: 'Take Dogs Out', icon: Icon(Icons.pets)),
            Foothold(label: 'Go on a Walk', icon: Icon(Icons.person))
          ],
        ),
        Zone(
          label: 'Touchdown',
          start: TimeOfDay(hour: 18, minute: 0),
          stop: TimeOfDay(hour: 20, minute: 59),
          footholds: [
            Foothold(label: 'Eat Dinner', icon: Icon(Icons.dining)),
            Foothold(label: 'Open the Windows', icon: Icon(Icons.window)),
            Foothold(label: 'Entertainment', icon: Icon(Icons.tv)),
            Foothold(label: 'Play with Dogs', icon: Icon(Icons.pets)),
            Foothold(label: 'Play Yoga Music', icon: Icon(Icons.music_note)),
            Foothold(label: 'Last Call', icon: Icon(Icons.nightlife)),
            Foothold(label: 'Sleep Dose', icon: Icon(Icons.medication_rounded))
          ],
        ),
        Zone(
          label: 'Close',
          start: TimeOfDay(hour: 21, minute: 0),
          stop: TimeOfDay(hour: 23, minute: 30),
          footholds: [
            Foothold(
                label: 'Turn off Lights', icon: Icon(Icons.cleaning_services)),
            Foothold(
                label: 'Close the Windows',
                icon: Icon(Icons.cleaning_services)),
            Foothold(label: 'Entertainment', icon: Icon(Icons.tv)),
            Foothold(label: 'Crate Dogs', icon: Icon(Icons.pets)),
            Foothold(label: 'Get Ready for Bed', icon: Icon(Icons.person)),
            Foothold(label: 'Go to Bed', icon: Icon(Icons.person)),
          ],
        ),
      ])});

  final DayStatus status;
  final Day day;

  @override
  List<Object> get props => [status, day];
}
