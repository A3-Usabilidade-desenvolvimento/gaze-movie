import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/common/widgets/nested_back_button.dart';
import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/core/extensions/string_extensions.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/features/series/presentation/bloc/searched/series_list_bloc.dart';
import 'package:gaze/features/series/presentation/enum/search_type.dart';
import 'package:gaze/features/series/presentation/widgets/series_item.dart';

class SeriesListScreen extends StatefulWidget {
  const SeriesListScreen({required this.args, super.key});

  final NavigationSearchTypeArgs args;

  @override
  State<SeriesListScreen> createState() => _SeriesListScreenState();
}

class _SeriesListScreenState extends State<SeriesListScreen> {
  @override
  void initState() {
    if (widget.args.searchType == SearchType.genre) {
      context.read<SeriesListBloc>().add(
            LoadSeriesListEvent(
              genre: widget.args.genre,
              searchType: widget.args.searchType,
            ),
          );
    }
    if (widget.args.searchType == SearchType.text) {
      context.read<SeriesListBloc>().add(
            LoadSeriesListEvent(
              text: widget.args.text,
              searchType: widget.args.searchType,
            ),
          );
    }
    if (widget.args.searchType == SearchType.network) {
      context.read<SeriesListBloc>().add(
            LoadSeriesListEvent(
              network: widget.args.network,
              searchType: widget.args.searchType,
            ),
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.defaultColor,
      appBar: AppBar(
        title: Text(
          widget.args.searchType == SearchType.genre
              ? genreNameFromGenres[widget.args.genre]!
              : widget.args.searchType == SearchType.network
                  ? getNetworkName[widget.args.network]!
                  : widget.args.text.toFirstUpperCase,
        ),
        leading: const NestedBackButton(),
      ),
      body: BlocBuilder<SeriesListBloc, SeriesListState>(
        builder: (context, state) {
          return Stack(
            children: [
              if (state is LoadedSeriesList)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 40,
                            crossAxisSpacing: 20,
                            childAspectRatio: 500 / 750),
                    itemCount: state.seriesList.length,
                    itemBuilder: (context, index) {
                      return SeriesItem(seriesModel: state.seriesList[index]);
                    },
                  ),
                )
              else
                const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colours.secondaryColor,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}