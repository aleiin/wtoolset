import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wtoolset/path/01/test_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  // SystemChrome.setPreferredOrientations(// 使设备横屏显示
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  // SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  double extraPicHeight = 0;
  BoxFit fitType = BoxFit.fitWidth;
  double prevDy = 0;

  late AnimationController animationController;

  late Animation<double> anim;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void updatePicHeight(change) {
    if (prevDy == 0) {
      prevDy = change;
    }

    if (extraPicHeight >= 45) {
      fitType = BoxFit.fitHeight;
    } else {
      fitType = BoxFit.fitWidth;
    }

    extraPicHeight += change - prevDy;

    setState(() {
      prevDy = change;
      extraPicHeight = extraPicHeight;
      fitType = fitType;
    });
  }

  void runAnimate() {
    setState(() {
      anim = Tween(
        begin: extraPicHeight,
        end: 0.0,
      ).animate(animationController)
        ..addListener(() {
          if (extraPicHeight >= 45) {
            fitType = BoxFit.fitHeight;
          } else {
            fitType = BoxFit.fitWidth;
          }

          extraPicHeight = anim.value;
          fitType = fitType;

          setState(() {});
        });
      prevDy = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // backgroundColor: Colors.black,
        body: Listener(
          onPointerMove: (result) {
            updatePicHeight(result.position.dy);
          },
          onPointerUp: (_) {
            runAnimate();

            animationController.forward(from: 0);
          },
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {},
                ),
                // floating: false,
                pinned: true,
                // snap: false,
                expandedHeight: 234 + extraPicHeight,
                flexibleSpace: FlexibleSpaceBar(
                  background: SliverTopBar(
                    extraPicHeight: extraPicHeight,
                    fitType: fitType,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Text(
                      "This is Item $i",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverTopBar extends StatelessWidget {
  const SliverTopBar({
    Key? key,
    required this.extraPicHeight,
    required this.fitType,
  }) : super(key: key);

  /// 传入的加载图片高度
  final double extraPicHeight;

  /// 传入的填充方式
  final BoxFit fitType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                "https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg",
                height: 180 + extraPicHeight,
                fit: fitType,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 16,
                      top: 10,
                    ),
                    child: Text("lalallalal"),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 16,
                      top: 8,
                    ),
                    child: Text("lalallalal"),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: 30,
          top: 130 + extraPicHeight,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.deepOrange,
          ),
        )
      ],
    );
  }
}
