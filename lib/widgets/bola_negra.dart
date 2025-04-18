part of 'widgets.dart';

class BolaNegra extends StatefulWidget {
  const BolaNegra({super.key, required this.respuestas, required this.thinking});
  final List<String> respuestas;
  final String thinking;

  @override
  State<BolaNegra> createState() => _BolaNegraState();
}

class _BolaNegraState extends State<BolaNegra> {
  int _times = 0;

  final interstitialUnit = InterstitialUnit();
  InterstitialAd? _interstitialAd;

  T getRandomElement<T>(List<T> list) {
    final random = Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  String? respuestaActual;

  @override
  void initState() {
    super.initState();
    interstitialUnit.loadAd();
  }

  void _adivinar() {
    setState(() {
      respuestaActual = widget.thinking;
    });
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          _times++;
          if (_times == 5) {
            _times = 0;
            _interstitialAd = interstitialUnit.interstitialAd;
            if (_interstitialAd != null) {
              _interstitialAd!.show();
              interstitialUnit.loadAd();
            }
          }
          respuestaActual = getRandomElement(widget.respuestas);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _adivinar,
      onVerticalDragEnd: (_) => _adivinar(),
      onHorizontalDragEnd: (_) => _adivinar(),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300, maxWidth: 300),
        decoration:
            const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: Center(
          child: _CirculoInterno(respuestaActual: respuestaActual),
        ),
      ),
    );
  }
}

class _CirculoInterno extends StatelessWidget {
  const _CirculoInterno({
    this.respuestaActual,
  });

  final String? respuestaActual;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 150, maxWidth: 150),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: respuestaActual == null
            ? const Text(
                '8',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 70,
                    fontWeight: FontWeight.bold),
              )
            : Text(
                respuestaActual!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 20,
                ),
              ),
      ),
    );
  }
}
