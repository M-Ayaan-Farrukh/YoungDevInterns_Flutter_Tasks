import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  int oscore = 0;
  int xscore = 0;
  int draws = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF16213e),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
          child: Column(
            children: [
              // Current Player Indicator
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0f3460),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  '${oTurn ? "O" : "X"}\'s Turn',
                  style: TextStyle(
                    color: oTurn ? Colors.orange : Colors.lightBlue,
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              // Score Board
              Container(
                padding: EdgeInsets.all(isTablet ? 20 : 16),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0f3460),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildScoreCard('Player O', oscore, Colors.orange, isTablet),
                    Container(
                      width: 1,
                      height: isTablet ? 60 : 50,
                      color: Colors.white24,
                    ),
                    _buildScoreCard('Draws', draws, Colors.grey, isTablet),
                    Container(
                      width: 1,
                      height: isTablet ? 60 : 50,
                      color: Colors.white24,
                    ),
                    _buildScoreCard('Player X', xscore, Colors.lightBlue, isTablet),
                  ],
                ),
              ),
              
              // Game Board
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: isTablet ? 400 : 300,
                        maxHeight: isTablet ? 400 : 300,
                      ),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 9,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => _tapped(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF0f3460),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white24,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  displayXO[index].toUpperCase(),
                                  style: TextStyle(
                                    color: displayXO[index] == 'o' 
                                        ? Colors.orange 
                                        : Colors.lightBlue,
                                    fontSize: isTablet ? 48 : 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              
              // Reset Button
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: _resetGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFe94560),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 32 : 24,
                      vertical: isTablet ? 16 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Reset Game',
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard(String title, int score, Color color, bool isTablet) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 16 : 12,
            vertical: isTablet ? 8 : 6,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Text(
            score.toString(),
            style: TextStyle(
              color: color,
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _tapped(int index) {
    if (displayXO[index] == '') {
      setState(() {
        if (oTurn) {
          displayXO[index] = 'o';
        } else {
          displayXO[index] = 'x';
        }
        oTurn = !oTurn;
      });
      _checkWinner();
    }
  }

  void _checkWinner() {
    // Row win conditions
    if (displayXO[0] == displayXO[1] && displayXO[0] == displayXO[2] && displayXO[0] != '') {
      _showWinDialog(displayXO[0]);
    } else if (displayXO[3] == displayXO[4] && displayXO[3] == displayXO[5] && displayXO[3] != '') {
      _showWinDialog(displayXO[3]);
    } else if (displayXO[6] == displayXO[7] && displayXO[6] == displayXO[8] && displayXO[6] != '') {
      _showWinDialog(displayXO[6]);
    }
    // Column win conditions
    else if (displayXO[0] == displayXO[3] && displayXO[0] == displayXO[6] && displayXO[0] != '') {
      _showWinDialog(displayXO[0]);
    } else if (displayXO[1] == displayXO[4] && displayXO[1] == displayXO[7] && displayXO[1] != '') {
      _showWinDialog(displayXO[1]);
    } else if (displayXO[2] == displayXO[5] && displayXO[2] == displayXO[8] && displayXO[2] != '') {
      _showWinDialog(displayXO[2]);
    }
    // Diagonal win conditions
    else if (displayXO[0] == displayXO[4] && displayXO[0] == displayXO[8] && displayXO[0] != '') {
      _showWinDialog(displayXO[0]);
    } else if (displayXO[2] == displayXO[4] && displayXO[2] == displayXO[6] && displayXO[2] != '') {
      _showWinDialog(displayXO[2]);
    } else if (!displayXO.contains('')) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1a1a2e),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: winner == 'o' ? Colors.orange : Colors.lightBlue,
                size: 32,
              ),
              const SizedBox(width: 12),
              Text(
                'Player ${winner.toUpperCase()} Wins!',
                style: TextStyle(
                  color: winner == 'o' ? Colors.orange : Colors.lightBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Congratulations! 🎉',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFe94560),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Play Again"),
            ),
          ],
        );
      },
    );
    
    setState(() {
      if (winner == 'o') {
        oscore += 1;
      } else if (winner == 'x') {
        xscore += 1;
      }
    });
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1a1a2e),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.handshake,
                color: Colors.grey,
                size: 32,
              ),
              SizedBox(width: 12),
              Text(
                'It\'s a Draw!',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Good game! 🤝',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFe94560),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Play Again"),
            ),
          ],
        );
      },
    );
    
    setState(() {
      draws += 1;
    });
  }

  void _clearBoard() {
    setState(() {
      displayXO = ['', '', '', '', '', '', '', '', ''];
      oTurn = true;
    });
  }

  void _resetGame() {
    setState(() {
      displayXO = ['', '', '', '', '', '', '', '', ''];
      oTurn = true;
      oscore = 0;
      xscore = 0;
      draws = 0;
    });
  }
}