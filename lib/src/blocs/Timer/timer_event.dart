part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  final int duration;
  final User user;

  const TimerStarted({@required this.duration, this.user});

  @override
  String toString() => "TimerStarted { duration: $duration }";
}

class TimerTicked extends TimerEvent {
  final int duration;

  const TimerTicked({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "TimerTicked { duration: $duration }";
}
