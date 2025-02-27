import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'utils/utils.dart';

void main() {
  runApp(const HikingApp());
}

class HikingApp extends StatelessWidget {
  const HikingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF1D2E05),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const _HikeList(),
    );
  }
}

class _HikeList extends StatefulWidget {
  const _HikeList();

  @override
  State<_HikeList> createState() => _HikeListState();
}

class _HikeListState extends State<_HikeList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Hike? _selectedHike;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _VerticalSpacing(),
            for (final hike in hikeList)
              Row(
                children: [
                  Expanded(
                    child: _HikeSummary(
                      hike: hike,
                      showHikeDetails: _showHikeDetails,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child:
            _selectedHike == null
                ? const Center(child: Text('No hike selected.'))
                : _HikeDetails(hike: _selectedHike!, onClose: _hideHikeDetails),
      ),
    );
  }

  void _hideHikeDetails() {
    setState(() {
      _selectedHike = null;
    });
    _scaffoldKey.currentState?.closeEndDrawer();
  }

  void _showHikeDetails(Hike hike) {
    setState(() {
      _selectedHike = hike;
    });
    _scaffoldKey.currentState?.openEndDrawer();
  }
}

class _CloseButton extends StatelessWidget {
  final void Function() onClose;

  const _CloseButton({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.0,
      left: 20.0,
      child: IconButton(
        onPressed: onClose,
        color: Theme.of(context).buttonTheme.colorScheme?.onInverseSurface,
        icon: Icon(Icons.close),
      ),
    );
  }
}

class _DetailsTitle extends StatelessWidget {
  final Hike hike;

  const _DetailsTitle({required this.hike});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              hike.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyLabel extends StatelessWidget {
  final HikeDifficulty difficulty;

  final bool abbreviated;
  const _DifficultyLabel({required this.difficulty, this.abbreviated = true});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = colorsForDifficulty(difficulty);
    return Container(
      padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: colors.$1,
      ),
      child: Text(
        labelTextForDifficulty(difficulty, abbreviated: abbreviated),
        overflow: TextOverflow.clip,
        softWrap: false,
        style: theme.textTheme.bodySmall?.copyWith(
          color: colors.$2,
          backgroundColor: colors.$1,
        ),
      ),
    );
  }
}

class _Gradient extends StatelessWidget {
  const _Gradient();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Theme.of(context).colorScheme.surfaceContainerLow,
          ],
        ),
      ),
    );
  }
}

class _HikeDate extends StatelessWidget {
  final Hike hike;

  const _HikeDate({required this.hike});

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('MMMM d, yyyy').format(hike.hikeDate),
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}

class _HikeDescription extends StatelessWidget {
  final Hike hike;

  const _HikeDescription({required this.hike});

  @override
  Widget build(BuildContext context) {
    return Text(
      hike.details,
      overflow: TextOverflow.clip,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

class _HikeDetails extends StatelessWidget {
  final Hike hike;

  final void Function() onClose;
  const _HikeDetails({required this.hike, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 100,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Image.asset(hike.imagePath, fit: BoxFit.scaleDown),
              _Gradient(),
              _DetailsTitle(hike: hike),
              _CloseButton(onClose: onClose),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  _HikeDate(hike: hike),
                  _DifficultyLabel(
                    difficulty: hike.difficulty,
                    abbreviated: false,
                  ),
                ],
              ),
              _VerticalSpacing(),
              Text(loremIpsum),
            ],
          ),
        ),
      ],
    );
  }
}

class _HikeSummary extends StatelessWidget {
  final Hike hike;

  final void Function(Hike) showHikeDetails;

  const _HikeSummary({required this.hike, required this.showHikeDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Row(
        children: [
          _SummaryImage(hike: hike),
          _HorizontalSpacing(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(child: _SummaryTitle(hike: hike)),
                    _DifficultyLabel(difficulty: hike.difficulty),
                  ],
                ),
                _HikeDate(hike: hike),
                _HikeDescription(hike: hike),
                _ShowDetailsButton(
                  showHikeDetails: showHikeDetails,
                  hike: hike,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HorizontalSpacing extends StatelessWidget {
  const _HorizontalSpacing();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 10);
  }
}

class _ShowDetailsButton extends StatelessWidget {
  final void Function(Hike p1) showHikeDetails;

  final Hike hike;
  const _ShowDetailsButton({required this.showHikeDetails, required this.hike});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: TextButton(
        onPressed: () => showHikeDetails(hike),
        child: Text('Select hike'),
      ),
    );
  }
}

class _SummaryImage extends StatelessWidget {
  final Hike hike;

  const _SummaryImage({required this.hike});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        hike.imagePath,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _SummaryTitle extends StatelessWidget {
  final Hike hike;

  const _SummaryTitle({required this.hike});

  @override
  Widget build(BuildContext context) {
    return Text(hike.title, style: Theme.of(context).textTheme.bodyMedium);
  }
}

class _VerticalSpacing extends StatelessWidget {
  const _VerticalSpacing();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}
