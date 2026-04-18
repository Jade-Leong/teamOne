//game logic
let selectedMap = null;

function startGame(mapId) {
  selectedMap = mapId;
  window.selectedMap = mapId;

  showScreen('game');

  const frame = document.getElementById('godot-frame');
  frame.src = 'godot/bobcatgo.html?map=' + mapId;
}

function exitGame() {
  const frame = document.getElementById('godot-frame');
  frame.src = '';

  showScreen('mapselect');
}