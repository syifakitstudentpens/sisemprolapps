import 'package:flutter/material.dart';
import 'package:sisemprol/data/category/Category.dart';
import 'package:sisemprol/data/category/CategoryRepository.dart';
import 'package:sisemprol/view/Routes.dart';
import 'package:sisemprol/view/widget/CategoryItemWidget.dart';

class CategoryPageWidget extends StatefulWidget {
  @override
  _CategoryPageWidgetState createState() => _CategoryPageWidgetState();
}

class _CategoryPageWidgetState extends State<CategoryPageWidget> {
  @override
  BuildContext get context => super.context;

  List<Category> _list = [];
  CategoryRepository repository = CategoryRepository.create();

  _CategoryPageWidgetState();

  Future<Null> fetchData() {
    return repository.fetchAndGet().then((value) {
      setState(() {
        _list = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final List<Color> _colorList = [
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _list.length == 0 ? emptyView() : getList(),
    );
  }

  Widget getList() {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 3;
    final double itemHeight = 170;
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    return Container(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: fetchData,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          height: size.height,
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: itemWidth / itemHeight,
            shrinkWrap: true,
            children: List.generate(
              _list.length,
              (index) {
                var item = _list[index];
                return new CategoryItemWidget(
                  item,
                  _colorList[index % _colorList.length],
                  (category) {
                    NavigateHelper.navigateToCategoryPage(context, category);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget emptyView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
