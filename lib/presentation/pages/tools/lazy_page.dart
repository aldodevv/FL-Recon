
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recon/core/constants/colors_const.dart';
import 'package:recon/presentation/widgets/section/infosection_widget.dart';

@RoutePage()
class LazyPage extends StatefulWidget {
  const LazyPage({super.key});

  @override
  State<LazyPage> createState() => _LazyPageState();
}

class _LazyPageState extends State<LazyPage> {
  final List<int> _items = List.generate(20, (index) => index);
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _items.addAll(List.generate(20, (index) => _items.length + index));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy Loading'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _items.length) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return InfoSectionWidget(
            text: "Total Transfer",
            value: _items[index],
            size: 12,
            leftIcon: Icons.money,
            colorType: ColorType.blue,
            rightIcon: Icons.arrow_forward_ios,
            onTap: () {
              debugPrint("Custom tapped");
            },
          );
        },
      ),
    );
  }
}
