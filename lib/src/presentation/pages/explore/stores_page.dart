import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nectar/src/bloc/stores/stores_bloc.dart';
import 'package:nectar/src/data/models/store.dart';
import 'package:nectar/src/presentation/widgets/cards/store_card.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  final _scrollController = ScrollController();
  DocumentSnapshot? _lastDocument;
  final List<Store> _stores = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StoresBloc>(context).add(
      FetchStoresWithPagination(_lastDocument),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_lastDocument == null) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<StoresBloc>(context).add(
        FetchStoresWithPagination(
          _lastDocument,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stores'),
      ),
      body: BlocListener<StoresBloc, StoresState>(
        listener: (context, state) {
          if (state is StoresLoaded) {
            _lastDocument = state.lastDocument;
            if (_lastDocument == null) {
              setState(() {});
            }
            for (final store in state.stores) {
              if (!_stores.contains(store)) {
                setState(() {
                  _stores.add(store);
                });
              }
            }
          }
        },
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          controller: _scrollController,
          itemCount: _stores.length + (_lastDocument != null ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _stores.length && _lastDocument != null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final Store store = _stores[index];
            return Column(
              children: [
                StoreCard(store: store),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
