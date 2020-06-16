import 'dart:async';

import 'package:flutter/material.dart';

/// A widget that rebuilds on specific and / or periodic Timer events.
class TimeDismissBuilder extends StatefulWidget {
	final WidgetBuilder builder;
	final TimerGenerator generator;
	final Widget child;
	final bool enabled;
	final Function onFire;
	/// Use this constructor only if you need to provide a custom TimerGenerator.
	/// For general cases, prefer to use [TimeDismissBuilder.periodic] and [TimerBuilder..scheduled]
	/// This constructor accepts a custom generator function that returns the next time event
	/// to rebuild on.
	TimeDismissBuilder({
		/// Returns the next time event. If the returned time is in the past, it will be ignored and
		/// the generator will be called again to retrieve the next time event.
		/// If the generator returns [null], it indicates the end of time event sequence.
		@required
		this.generator,
		/// Builds the widget. Called for every time event or when the widget needs to be built/rebuilt.
		@required
		this.builder, this.onFire, this.child,  this.enabled = true,
	});

	@override
	State<StatefulWidget> createState() {
		return _TimeDismissBuilderState();
	}

	/// Rebuilds periodically
	TimeDismissBuilder.periodic(Duration interval, {
		/// Specifies the alignment unit for the generated time events. Specify Duration.zero
		/// if you want no alignment. By default, the alignment unit is computed from the interval.
		Duration alignment,
		/// Builds the widget. Called for every time event or when the widget needs to be built/rebuilt.
		this.builder, this.onFire, this.child, this.enabled = true,
	}): this.generator = periodicTimer(interval, alignment: alignment ?? getAlignmentUnit(interval));

	/// Rebuilds on a schedule
	TimeDismissBuilder.scheduled(Iterable<DateTime> schedule, {
		/// Builds the widget. Called for every time event or when the widget needs to be built/rebuilt.
		@required
		this.builder, this.onFire, this.child, this.enabled = true,
	}): this.generator = scheduledTimer(schedule);

}

class _TimeDismissBuilderState extends State<TimeDismissBuilder> {

	Stream<DateTime> stream;
	Completer completer;

	@override
	Widget build(BuildContext context) {
		return  widget.enabled ?
		StreamBuilder(
			stream: stream,
			builder: (context, _) {
				if(widget.onFire != null) widget.onFire();
				return widget.child;
			},
		) : widget.child;
	}

	@override
	void didUpdateWidget(TimeDismissBuilder oldWidget) {
		super.didUpdateWidget(oldWidget);
		if(widget.enabled) _update();
	}

	@override
	void initState() {
		super.initState();
		if(widget.enabled) _update();
	}

	@override
	void dispose() {
		super.dispose();
		if(widget.enabled) _cancel();
	}

	_update() {
		_cancel();
		completer = Completer();
		stream = createTimerStream(widget.generator, completer.future);
	}

	_cancel() {
		if(completer != null)
			completer.complete();
	}

}


/// Used by TimerBuilder to determine the next DateTime to trigger a rebuild on
typedef DateTime TimerGenerator(DateTime now);

/// A widget that rebuilds on specific and / or periodic Timer events.
class TimerBuilder extends StatefulWidget {
	final WidgetBuilder builder;
	final TimerGenerator generator;
	final bool enable;

	/// Use this constructor only if you need to provide a custom TimerGenerator.
	/// For general cases, prefer to use [TimerBuilder.periodic] and [TimerBuilder..scheduled]
	/// This constructor accepts a custom generator function that returns the next time event
	/// to rebuild on.
	TimerBuilder({
		/// Returns the next time event. If the returned time is in the past, it will be ignored and
		/// the generator will be called again to retrieve the next time event.
		/// If the generator returns [null], it indicates the end of time event sequence.
		@required this.generator,

		/// Builds the widget. Called for every time event or when the widget needs to be built/rebuilt.
		@required this.builder,
		this.enable = false,
	});

	@override
	State<StatefulWidget> createState() {
		return _TimerBuilderState();
	}

	/// Rebuilds periodically
	TimerBuilder.periodic(
			Duration interval, {

				/// Specifies the alignment unit for the generated time events. Specify Duration.zero
				/// if you want no alignment. By default, the alignment unit is computed from the interval.
				Duration alignment,

				/// Builds the widget. Called for every time event or when the widget needs to be built/rebuilt.
				@required this.builder,
				this.enable = false,
			}) : this.generator = periodicTimer(interval,
			alignment: alignment ?? getAlignmentUnit(interval));

	/// Rebuilds on a schedule
	TimerBuilder.scheduled(
			Iterable<DateTime> schedule, {

				/// Builds the widget. Called for every time event or when the widget needs to be built/rebuilt.
				@required this.builder,
				this.enable = false,
			}) : this.generator = scheduledTimer(schedule);
}

class _TimerBuilderState extends State<TimerBuilder> {
	Stream<DateTime> stream;
	Completer completer;

	@override
	Widget build(BuildContext context) {
		if (widget.enable != null && widget.enable)
			return StreamBuilder(
				stream: stream,
				builder: (context, _) => widget.builder(context),
			);

		return Builder(builder: (context) => widget.builder(context));
	}

	@override
	void didUpdateWidget(TimerBuilder oldWidget) {
		super.didUpdateWidget(oldWidget);
		_update();
	}

	@override
	void initState() {
		super.initState();
		if (widget.enable != null && widget.enable)  _update();
	}

	@override
	void dispose() {
		super.dispose();
		if (widget.enable != null && widget.enable)   _cancel();
	}

	_update() {
		_cancel();
		completer = Completer();
		stream = createTimerStream(widget.generator, completer.future);
	}

	_cancel() {
		if (completer != null) completer.complete();
	}
}

TimerGenerator periodicTimer(Duration interval,
		{Duration alignment = Duration.zero}) {
	assert(interval > Duration.zero);

	DateTime next;
	return (DateTime now) {
		next = alignDateTime((next ?? now).add(interval), alignment);
		if (now.compareTo(next) < 0) {
			next = alignDateTime(now.add(interval), alignment);
		}
		return next;
	};
}

TimerGenerator scheduledTimer(Iterable<DateTime> schedule) {
	List<DateTime> sortedSpecific =
	List.from(schedule.where((e) => e != null).toList());
	sortedSpecific.sort((a, b) => a.compareTo(b));

	return fromIterable(sortedSpecific);
}

TimerGenerator fromIterable(Iterable<DateTime> iterable) {
	final iterator = iterable.iterator;
	return (DateTime now) {
		return iterator.moveNext() ? iterator.current : null;
	};
}

/// Creates a stream tha produces DateTime objects at the times specified by the [generator].
/// Stops the stream when [stopSignal] is received.
Stream<DateTime> createTimerStream(
		TimerGenerator generator,
		Future stopSignal,
		) async* {
	var now = DateTime.now();
	DateTime next;
	while ((next = generator(now)) != null) {
		if (now.compareTo(next) > 0) continue;
		Duration waitTime = next.difference(now);
		try {
			await stopSignal.timeout(waitTime);
			return;
		} on TimeoutException catch (_) {
			yield next;
		}
		now = DateTime.now();
	}
}

/// Returns an alignment unit can be passed to [alignDateTime] in order to align
/// the date/time units. For example, if the specified interval is 15 minutes,
/// the alignment unit is 1 minute.
Duration getAlignmentUnit(Duration interval) {
	return Duration(
		days: interval.inDays > 0 ? 1 : 0,
		hours: interval.inDays == 0 && interval.inHours > 0 ? 1 : 0,
		minutes: interval.inHours == 0 && interval.inMinutes > 0 ? 1 : 0,
		seconds: interval.inMinutes == 0 && interval.inSeconds > 0 ? 1 : 0,
		milliseconds:
		interval.inSeconds == 0 && interval.inMilliseconds > 0 ? 1 : 0,
		microseconds:
		interval.inMilliseconds == 0 && interval.inMicroseconds > 0 ? 1 : 0,
	);
}

/// Rounds down or up a [DateTime] object using a [Duration] object.
/// If [roundUp] is true, the result is rounded up, otherwise it's rounded down.
/// If the duration is a multiple of days, the result will be aligned at
/// the day mark in the timezone of the source datetime.
DateTime alignDateTime(DateTime dt, Duration alignment,
		[bool roundUp = false]) {
	assert(alignment >= Duration.zero);
	if (alignment == Duration.zero) return dt;
	final correction = Duration(
			days: 0,
			hours: alignment.inDays > 0
					? dt.hour
					: alignment.inHours > 0 ? dt.hour % alignment.inHours : 0,
			minutes: alignment.inHours > 0
					? dt.minute
					: alignment.inMinutes > 0 ? dt.minute % alignment.inMinutes : 0,
			seconds: alignment.inMinutes > 0
					? dt.second
					: alignment.inSeconds > 0 ? dt.second % alignment.inSeconds : 0,
			milliseconds: alignment.inSeconds > 0
					? dt.millisecond
					: alignment.inMilliseconds > 0
					? dt.millisecond % alignment.inMilliseconds
					: 0,
			microseconds: alignment.inMilliseconds > 0 ? dt.microsecond : 0);
	if (correction == Duration.zero) return dt;
	final corrected = dt.subtract(correction);
	final result = roundUp ? corrected.add(alignment) : corrected;
	return result;
}