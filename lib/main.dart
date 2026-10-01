import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const HangmanNeoBrutalismApp());
}

/// Model untuk kata dan petunjuk tematik coding/teknologi
class WordItem {
  final String word;
  final String category;
  final String hint;

  const WordItem({
    required this.word,
    required this.category,
    required this.hint,
  });
}

class HangmanNeoBrutalismApp extends StatelessWidget {
  const HangmanNeoBrutalismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman Neo-Brutalism',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'monospace',
        scaffoldBackgroundColor: const Color(0xFFFFFDF0), // Vintage warm cream
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFDE59),
          primary: const Color(0xFFFFDE59),
        ),
      ),
      home: const HangmanGameScreen(),
    );
  }
}

class HangmanGameScreen extends StatefulWidget {
  const HangmanGameScreen({super.key});

  @override
  State<HangmanGameScreen> createState() => _HangmanGameScreenState();
}

class _HangmanGameScreenState extends State<HangmanGameScreen> {
  // Bank kata acak bertema teknologi & coding
  static const List<WordItem> _wordBank = [
    WordItem(
      word: 'FLUTTER',
      category: 'FRAMEWORK',
      hint: 'UI toolkit multiplatform open-source besutan Google.',
    ),
    WordItem(
      word: 'WIDGET',
      category: 'FLUTTER CORE',
      hint: 'Blok pembangun deklaratif utama seluruh antarmuka Flutter.',
    ),
    WordItem(
      word: 'DART',
      category: 'PROGRAMMING',
      hint: 'Bahasa pemrograman modern yang dioptimasi untuk client-side.',
    ),
    WordItem(
      word: 'ALGORITHM',
      category: 'COMPUTER SCIENCE',
      hint: 'Instruksi sistematis & logis untuk menyelesaikan problem.',
    ),
    WordItem(
      word: 'INTERFACE',
      category: 'OOP & UI',
      hint: 'Kontrak perilaku kelas atau penghubung interaksi pengguna.',
    ),
    WordItem(
      word: 'COMPILER',
      category: 'SYSTEMS',
      hint: 'Penerjemah kode sumber manusia ke instruksi biner mesin.',
    ),
    WordItem(
      word: 'DATABASE',
      category: 'DATA STORAGE',
      hint: 'Kumpulan data terstruktur yang dikelola secara persisten.',
    ),
    WordItem(
      word: 'VARIABLE',
      category: 'CODING BASIC',
      hint: 'Pengidentifikasi bernama untuk menyimpan nilai di memori.',
    ),
    WordItem(
      word: 'FUNCTION',
      category: 'ARCHITECTURE',
      hint: 'Blok kode modular yang dapat dipanggil kembali dengan parameter.',
    ),
    WordItem(
      word: 'REACTIVE',
      category: 'PARADIGM',
      hint: 'Paradigma pemrograman yang berorientasi pada aliran data.',
    ),
  ];

  static const int _maxMistakes = 6;

  late WordItem _currentWordItem;
  final Set<String> _guessedLetters = <String>{};
  int _mistakes = 0;
  int _score = 0;
  int _streak = 0;

  // Keyboard layout QWERTY
  static const List<List<String>> _keyboardLayout = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  @override
  void initState() {
    super.initState();
    _currentWordItem = _wordBank[Random().nextInt(_wordBank.length)];
    _startNewGame(resetStats: true);
  }

  void _startNewGame({bool resetStats = false}) {
    final random = Random();
    WordItem nextItem;
    if (_wordBank.length > 1) {
      do {
        nextItem = _wordBank[random.nextInt(_wordBank.length)];
      } while (nextItem.word == _currentWordItem.word);
    } else {
      nextItem = _wordBank.first;
    }

    setState(() {
      _currentWordItem = nextItem;
      _guessedLetters.clear();
      _mistakes = 0;
      if (resetStats) {
        _score = 0;
        _streak = 0;
      }
    });
  }

  bool get _isWon {
    return _currentWordItem.word.split('').every(_guessedLetters.contains);
  }

  bool get _isLost {
    return _mistakes >= _maxMistakes;
  }

  bool get _isGameOver => _isWon || _isLost;

  void _guessLetter(String letter) {
    if (_isGameOver || _guessedLetters.contains(letter)) return;

    setState(() {
      _guessedLetters.add(letter);
      if (!_currentWordItem.word.contains(letter)) {
        _mistakes++;
        if (_mistakes >= _maxMistakes) {
          _streak = 0;
          _showGameOverDialog(isWin: false);
        }
      } else {
        if (_isWon) {
          _score += 100 + (_maxMistakes - _mistakes) * 20;
          _streak++;
          _showGameOverDialog(isWin: true);
        }
      }
    });
  }

  void _showGameOverDialog({required bool isWin}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: NeoBrutalistContainer(
            backgroundColor: isWin ? const Color(0xFF2CEAA3) : const Color(0xFFFF5376),
            borderColor: Colors.black,
            borderWidth: 4,
            shadowOffset: const Offset(8, 8),
            borderRadius: BorderRadius.circular(16),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Badge Status
                NeoBrutalistBadge(
                  text: isWin ? '🏆 MISSION ACCOMPLISHED!' : '💀 GAME OVER!',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16,
                ),
                const SizedBox(height: 16),
                Text(
                  isWin ? 'KAMU BERHASIL!' : 'KESEMPATAN HABIS!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isWin
                      ? 'Luar biasa! Kata berhasil tertebak dengan $_mistakes kesalahan.'
                      : 'Kata tersembunyi yang gagal ditebak adalah:',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                // Kata Asli
                NeoBrutalistContainer(
                  backgroundColor: const Color(0xFFFFDE59),
                  borderColor: Colors.black,
                  borderWidth: 3,
                  shadowOffset: const Offset(4, 4),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    _currentWordItem.word,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                // Clue / Hint info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '💡 Hint: ${_currentWordItem.hint}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Tombol Main Lagi
                NeoBrutalistButton(
                  text: 'MAIN LAGI / NEXT WORD ➔',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  borderColor: Colors.black,
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    _startNewGame(resetStats: false);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header & Profile Card
                      _buildHeader(),
                      const SizedBox(height: 14),

                      // Game Info Bar (Category, Mistake Lives, Score)
                      _buildInfoBar(),
                      const SizedBox(height: 14),

                      // Hangman Visual Drawing Area
                      _buildHangmanCanvasCard(),
                      const SizedBox(height: 16),

                      // Clue Banner
                      _buildClueCard(),
                      const SizedBox(height: 18),

                      // Hidden Word Display
                      _buildHiddenWordSlots(),
                      const SizedBox(height: 20),

                      // Virtual Keyboard
                      _buildVirtualKeyboard(),
                      const SizedBox(height: 18),

                      // Bottom Control Buttons (Reset / New Game)
                      _buildBottomControls(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return NeoBrutalistContainer(
      backgroundColor: const Color(0xFFFFDE59), // Yellow punch
      borderColor: Colors.black,
      borderWidth: 3.5,
      shadowOffset: const Offset(4, 4),
      borderRadius: BorderRadius.circular(12),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'FLUTTER SPEED CODE CHALLENGE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'HANGMAN GAME #3',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              NeoBrutalistBadge(
                text: 'NEO-BRUTALISM',
                backgroundColor: const Color(0xFFFF5376),
                textColor: Colors.white,
                fontSize: 11,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.black, thickness: 2.5),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '👤 Attaridho Ananda Susilo',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              Text(
                '⚡ Max 6 Kesalahan',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBar() {
    return Row(
      children: [
        // Category Badge
        Expanded(
          flex: 5,
          child: NeoBrutalistContainer(
            backgroundColor: const Color(0xFF00F0FF), // Neon cyan
            borderColor: Colors.black,
            borderWidth: 3,
            shadowOffset: const Offset(3, 3),
            borderRadius: BorderRadius.circular(8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.code, size: 18, color: Colors.black),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _currentWordItem.category,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Mistakes Indicator
        Expanded(
          flex: 6,
          child: NeoBrutalistContainer(
            backgroundColor: _mistakes >= 5
                ? const Color(0xFFFF5376)
                : const Color(0xFFFFFDF0),
            borderColor: Colors.black,
            borderWidth: 3,
            shadowOffset: const Offset(3, 3),
            borderRadius: BorderRadius.circular(8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'KESALAHAN: ',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '$_mistakes/$_maxMistakes',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: _mistakes >= 5 ? Colors.white : Colors.red.shade900,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _mistakes >= _maxMistakes
                      ? Icons.heart_broken
                      : Icons.favorite,
                  size: 16,
                  color: _mistakes >= 5 ? Colors.white : Colors.red,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Score & Streak Badge
        Expanded(
          flex: 5,
          child: NeoBrutalistContainer(
            backgroundColor: const Color(0xFF2CEAA3), // Mint green
            borderColor: Colors.black,
            borderWidth: 3,
            shadowOffset: const Offset(3, 3),
            borderRadius: BorderRadius.circular(8),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Center(
              child: Text(
                'PTS: $_score | 🔥$_streak',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHangmanCanvasCard() {
    return NeoBrutalistContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.black,
      borderWidth: 3.5,
      shadowOffset: const Offset(5, 5),
      borderRadius: BorderRadius.circular(14),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Life progress bar / hearts
              Row(
                children: List.generate(_maxMistakes, (index) {
                  final isLostLife = index < _mistakes;
                  return Container(
                    margin: const EdgeInsets.only(right: 4),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isLostLife ? Colors.black26 : const Color(0xFFFF5376),
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDE59),
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'SISA NYAWA: ${_maxMistakes - _mistakes}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            width: double.infinity,
            child: CustomPaint(
              painter: HangmanCustomPainter(
                mistakes: _mistakes,
                isWon: _isWon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClueCard() {
    return NeoBrutalistContainer(
      backgroundColor: const Color(0xFFF3E8FF), // Pastel lavender
      borderColor: Colors.black,
      borderWidth: 2.5,
      shadowOffset: const Offset(3, 3),
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const Text('💡', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Petunjuk: ${_currentWordItem.hint}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHiddenWordSlots() {
    final letters = _currentWordItem.word.split('');
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: letters.map((char) {
        final isGuessed = _guessedLetters.contains(char);
        final revealWord = _isLost; // Buka jika kalah

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 44,
          height: 52,
          decoration: BoxDecoration(
            color: isGuessed
                ? const Color(0xFF2CEAA3) // Mint green jika benar
                : (revealWord
                    ? const Color(0xFFFF5376) // Pink merah jika kalah terungkap
                    : Colors.white),
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(3, 3),
                blurRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              isGuessed
                  ? char
                  : (revealWord ? char : '_'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: isGuessed
                    ? Colors.black
                    : (revealWord ? Colors.white : Colors.black45),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVirtualKeyboard() {
    return Column(
      children: _keyboardLayout.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((letter) {
              final isUsed = _guessedLetters.contains(letter);
              final isCorrect = isUsed && _currentWordItem.word.contains(letter);
              final isWrong = isUsed && !_currentWordItem.word.contains(letter);

              Color keyColor = Colors.white;
              if (isCorrect) {
                keyColor = const Color(0xFF2CEAA3); // Mint Green
              } else if (isWrong) {
                keyColor = const Color(0xFFFF5376); // Pink punch
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: SizedBox(
                  width: 32,
                  height: 42,
                  child: NeoBrutalistKeyButton(
                    letter: letter,
                    backgroundColor: keyColor,
                    isUsed: isUsed,
                    onPressed: () => _guessLetter(letter),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomControls() {
    return Row(
      children: [
        // Tombol Reset / Acak Baru
        Expanded(
          child: NeoBrutalistButton(
            text: '🔄 RESET / NEW GAME',
            backgroundColor: const Color(0xFFFFDE59),
            textColor: Colors.black,
            borderColor: Colors.black,
            borderWidth: 3.5,
            shadowOffset: const Offset(4, 4),
            onPressed: () => _startNewGame(resetStats: false),
          ),
        ),
        const SizedBox(width: 12),
        // Tombol Reset Skor Penuh
        SizedBox(
          width: 54,
          height: 48,
          child: NeoBrutalistIconButton(
            icon: Icons.refresh_outlined,
            tooltip: 'Reset Skor & Game',
            backgroundColor: Colors.white,
            onPressed: () => _startNewGame(resetStats: true),
          ),
        ),
      ],
    );
  }
}

/// CustomPainter untuk Karakter Hangman Interaktif Bertahap
class HangmanCustomPainter extends CustomPainter {
  final int mistakes;
  final bool isWon;

  HangmanCustomPainter({
    required this.mistakes,
    required this.isWon,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Definisi Paints dengan gaya Neo-Brutalism tebal
    final woodPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    final ropePaint = Paint()
      ..color = const Color(0xFFD35400) // Dark orange rope
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final bodyPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final headFillPaint = Paint()
      ..color = isWon
          ? const Color(0xFF2CEAA3)
          : (mistakes >= 6 ? const Color(0xFFFF5376) : const Color(0xFFFFDE59))
      ..style = PaintingStyle.fill;

    final headOutlinePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.5
      ..style = PaintingStyle.stroke;

    final centerW = size.width / 2;

    // --- 0. TIANG GANTUNGAN (GALLOWS) - Selalu Ditampilkan ---
    // Dasar gantung (Base beam)
    canvas.drawLine(
      Offset(centerW - 80, size.height - 10),
      Offset(centerW - 10, size.height - 10),
      woodPaint,
    );
    // Tiang vertikal (Vertical pole)
    canvas.drawLine(
      Offset(centerW - 45, size.height - 10),
      Offset(centerW - 45, 15),
      woodPaint,
    );
    // Balok horizontal atas (Top horizontal beam)
    canvas.drawLine(
      Offset(centerW - 45, 15),
      Offset(centerW + 45, 15),
      woodPaint,
    );
    // Penyangga diagonal (Diagonal strut)
    canvas.drawLine(
      Offset(centerW - 45, 45),
      Offset(centerW - 15, 15),
      woodPaint,
    );
    // Tali gantungan (Rope)
    canvas.drawLine(
      Offset(centerW + 45, 15),
      Offset(centerW + 45, 42),
      ropePaint,
    );

    // Titik pusat tubuh manusia gantung
    final headCenter = Offset(centerW + 45, 58);
    const headRadius = 16.0;

    // --- 1. KEPALA (MISTAKE >= 1) ---
    if (mistakes >= 1) {
      canvas.drawCircle(headCenter, headRadius, headFillPaint);
      canvas.drawCircle(headCenter, headRadius, headOutlinePaint);

      // Detail Wajah: Mata dan Mulut
      final facePaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      if (isWon) {
        // Mata Senang (Lengkung ^ ^)
        canvas.drawArc(
          Rect.fromCircle(center: Offset(headCenter.dx - 6, headCenter.dy - 2), radius: 3),
          pi,
          pi,
          false,
          facePaint,
        );
        canvas.drawArc(
          Rect.fromCircle(center: Offset(headCenter.dx + 6, headCenter.dy - 2), radius: 3),
          pi,
          pi,
          false,
          facePaint,
        );
        // Senyum lebar
        canvas.drawArc(
          Rect.fromCircle(center: Offset(headCenter.dx, headCenter.dy + 3), radius: 6),
          0,
          pi,
          false,
          facePaint,
        );
      } else if (mistakes >= 6) {
        // Mata X X (Game Over)
        _drawXEye(canvas, Offset(headCenter.dx - 6, headCenter.dy - 3), facePaint);
        _drawXEye(canvas, Offset(headCenter.dx + 6, headCenter.dy - 3), facePaint);
        // Mulut Sedih
        canvas.drawArc(
          Rect.fromCircle(center: Offset(headCenter.dx, headCenter.dy + 8), radius: 5),
          pi,
          pi,
          false,
          facePaint,
        );
      } else {
        // Mata Normal (.)
        final eyeDotPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(headCenter.dx - 5, headCenter.dy - 2), 2, eyeDotPaint);
        canvas.drawCircle(Offset(headCenter.dx + 5, headCenter.dy - 2), 2, eyeDotPaint);
        // Mulut Datar
        canvas.drawLine(
          Offset(headCenter.dx - 4, headCenter.dy + 6),
          Offset(headCenter.dx + 4, headCenter.dy + 6),
          facePaint,
        );
      }
    }

    // --- 2. BADAN / TORSO (MISTAKE >= 2) ---
    final neckY = headCenter.dy + headRadius;
    final hipY = neckY + 44;
    if (mistakes >= 2) {
      canvas.drawLine(
        Offset(headCenter.dx, neckY),
        Offset(headCenter.dx, hipY),
        bodyPaint,
      );
    }

    // --- 3. TANGAN KIRI (MISTAKE >= 3) ---
    final shoulderY = neckY + 12;
    if (mistakes >= 3) {
      canvas.drawLine(
        Offset(headCenter.dx, shoulderY),
        Offset(headCenter.dx - 26, shoulderY + 22),
        bodyPaint,
      );
    }

    // --- 4. TANGAN KANAN (MISTAKE >= 4) ---
    if (mistakes >= 4) {
      canvas.drawLine(
        Offset(headCenter.dx, shoulderY),
        Offset(headCenter.dx + 26, shoulderY + 22),
        bodyPaint,
      );
    }

    // --- 5. KAKI KIRI (MISTAKE >= 5) ---
    if (mistakes >= 5) {
      canvas.drawLine(
        Offset(headCenter.dx, hipY),
        Offset(headCenter.dx - 22, hipY + 34),
        bodyPaint,
      );
    }

    // --- 6. KAKI KANAN (MISTAKE >= 6 - GAME OVER) ---
    if (mistakes >= 6) {
      canvas.drawLine(
        Offset(headCenter.dx, hipY),
        Offset(headCenter.dx + 22, hipY + 34),
        bodyPaint,
      );
    }
  }

  void _drawXEye(Canvas canvas, Offset center, Paint paint) {
    const size = 3.5;
    canvas.drawLine(
      Offset(center.dx - size, center.dy - size),
      Offset(center.dx + size, center.dy + size),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx + size, center.dy - size),
      Offset(center.dx - size, center.dy + size),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant HangmanCustomPainter oldDelegate) {
    return oldDelegate.mistakes != mistakes || oldDelegate.isWon != isWon;
  }
}

/// Widget Container Khas Neo-Brutalism dengan Hard Shadow
class NeoBrutalistContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final Offset shadowOffset;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;

  const NeoBrutalistContainer({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.black,
    this.borderWidth = 3.0,
    this.shadowOffset = const Offset(4, 4),
    this.borderRadius,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: shadowOffset,
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Widget Badge Khas Neo-Brutalism
class NeoBrutalistBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;

  const NeoBrutalistBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// Widget Tombol Aksi Neo-Brutalism
class NeoBrutalistButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;
  final Offset shadowOffset;

  const NeoBrutalistButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFFFDE59),
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.borderWidth = 3.0,
    this.shadowOffset = const Offset(4, 4),
  });

  @override
  State<NeoBrutalistButton> createState() => _NeoBrutalistButtonState();
}

class _NeoBrutalistButtonState extends State<NeoBrutalistButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 70),
        transform: Matrix4.translationValues(
          _isPressed ? widget.shadowOffset.dx : 0,
          _isPressed ? widget.shadowOffset.dy : 0,
          0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.borderColor, width: widget.borderWidth),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black,
                    offset: widget.shadowOffset,
                    blurRadius: 0,
                  ),
                ],
        ),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget Tombol Ikon Neo-Brutalism
class NeoBrutalistIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final String? tooltip;

  const NeoBrutalistIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.tooltip,
  });

  @override
  State<NeoBrutalistIconButton> createState() => _NeoBrutalistIconButtonState();
}

class _NeoBrutalistIconButtonState extends State<NeoBrutalistIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? '',
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 70),
          transform: Matrix4.translationValues(
            _isPressed ? 3 : 0,
            _isPressed ? 3 : 0,
            0,
          ),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 3),
            boxShadow: _isPressed
                ? []
                : const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(3, 3),
                      blurRadius: 0,
                    ),
                  ],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: Colors.black,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget Tombol Tombol Keyboard Interaktif
class NeoBrutalistKeyButton extends StatelessWidget {
  final String letter;
  final Color backgroundColor;
  final bool isUsed;
  final VoidCallback onPressed;

  const NeoBrutalistKeyButton({
    super.key,
    required this.letter,
    required this.backgroundColor,
    required this.isUsed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUsed ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isUsed ? Colors.grey.shade400 : backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isUsed ? Colors.black54 : Colors.black,
            width: 2.2,
          ),
          boxShadow: isUsed
              ? []
              : const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 0,
                  ),
                ],
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: isUsed ? Colors.black45 : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
