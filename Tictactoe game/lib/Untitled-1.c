

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
  }
}