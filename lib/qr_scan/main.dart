import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple QR Scan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController _cameraController;
  bool _shouldSkipScanning;
  String _scannedData;

  @override
  void initState() {
    super.initState();

    // 画面の向きをポートレートモード（縦向き）に固定する
    // 固定する必要性はないが、ランドスケープモードの比率の計算が面倒だったので。
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _shouldSkipScanning = false;
    _scannedData = 'スキャン中…';

    _cameraController = CameraController(
      null,
      null,
    );

    // この端末で利用可能なカメラを検出する
    availableCameras().then((value) {
      List<CameraDescription> cameraDescriptionList = value;

      _cameraController = CameraController(
        cameraDescriptionList[0], // 背面カメラを利用する。前面カメラならリスト1番目。
        ResolutionPreset.high, // 解像度高め。低すぎると認識精度が落ちる。
      );

      _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }

        // スキャン処理を実行する
        _scanQrCode();

        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _scanQrCode() async {
    _cameraController.startImageStream(
      (CameraImage availableImage) async {
        if (_shouldSkipScanning) {
          return;
        }

        _shouldSkipScanning = true;

        // スキャンしたイメージをFirebaseMLで使える形式に変換する
        final FirebaseVisionImageMetadata metadata =
            FirebaseVisionImageMetadata(
          rawFormat: availableImage.format.raw,
          size: Size(
            availableImage.width.toDouble(),
            availableImage.height.toDouble(),
          ),
          planeData: availableImage.planes
              .map(
                (currentPlane) => FirebaseVisionImagePlaneMetadata(
                  bytesPerRow: currentPlane.bytesPerRow,
                  height: currentPlane.height,
                  width: currentPlane.width,
                ),
              )
              .toList(),
        );
        final FirebaseVisionImage visionImage = FirebaseVisionImage.fromBytes(
          availableImage.planes.first.bytes,
          metadata,
        );

        // バーコードを検出する
        final BarcodeDetector barcodeDetector =
            FirebaseVision.instance.barcodeDetector();
        final List<Barcode> barcodeList = await barcodeDetector.detectInImage(
          visionImage,
        );

        if (barcodeList.length != 0) {
          setState(() {
            _scannedData = barcodeList.first.rawValue;
          });
          _shouldSkipScanning = false;
        } else {
          _shouldSkipScanning = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: _cameraController.value.isInitialized // 初期化が終わったらカメラ映像を描画
          ? Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio:
                          1 / _cameraController.value.previewSize.aspectRatio,
                      child: CameraPreview(
                        _cameraController,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                        ),
                        FittedBox(
                          // スキャンしたデータが何文字になるか分からないのでFittedBoxで囲った
                          child: Text(
                            _scannedData,
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 40.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
