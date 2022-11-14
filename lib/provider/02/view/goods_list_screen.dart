import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtoolset/provider/01/model/goods.dart';
import 'package:wtoolset/provider/01/model/goods_list_provider.dart';

class GoodsListScreen extends StatelessWidget {
  const GoodsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品列表"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => GoodsListProvider(),
        child: Selector<GoodsListProvider, GoodsListProvider>(
          shouldRebuild: (previous, next) => false,
          selector: (context, provider) => provider,
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.total,
              itemBuilder: (BuildContext context, int index) {
                return Selector<GoodsListProvider, Goods>(
                  selector: (context, provider) => provider.goodList[index],
                  builder: (context, data, child) {
                    return ListTile(
                      title: Text(data.name),
                      trailing: GestureDetector(
                        onTap: () {
                          provider.collect(index);
                        },
                        child: Icon(
                            data.isCollection ? Icons.star : Icons.star_border),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
