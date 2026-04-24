// game logic
let currentRunStartedAt = null;
let hasSavedCurrentRun = false;

window.addEventListener("message", async (event) => {
  const frame = document.getElementById("godot-frame");
  const isFromGameFrame = frame && event.source === frame.contentWindow;
  const isSameOrigin = !event.origin || event.origin === "null" || event.origin === window.location.origin;

  if (!isFromGameFrame || !isSameOrigin || !event.data || typeof event.data !== "object") {
    return;
  }

  if (event.data.type === "bobcat-go:run-started") {
    currentRunStartedAt = new Date().toISOString();
    hasSavedCurrentRun = false;
    return;
  }

  if (event.data.type !== "bobcat-go:game-over") {
    return;
  }

  if (hasSavedCurrentRun || !currentRunStartedAt || typeof saveRun !== "function") {
    return;
  }

  hasSavedCurrentRun = true;
  
  const durationMs = event.data.durationMs;
  const finalTime = formatDuration(durationMs);

  await saveRun({
  startedAt: currentRunStartedAt,
  durationMs: durationMs,
  mapId: currentMapId,
  });

  frame.src = "";

  document.getElementById("final-time-box").textContent = `You lasted ${finalTime}`;
  showScreen("gameover");

});


window.startGame = function(mapId) {
  currentMapId = mapId;
  currentRunStartedAt = null;
  hasSavedCurrentRun = false;

  showScreen("game");

  const frame = document.getElementById("godot-frame");
  frame.src = "godot/bobcatgo.html?map=" + mapId;
}

function exitGame() {
  const frame = document.getElementById("godot-frame");
  frame.src = "";
  currentRunStartedAt = null;
  hasSavedCurrentRun = false;

  showScreen("mapselect");
}

function formatDuration(durationMs) {
  const totalSeconds = Math.floor(durationMs / 1000);
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;
  const milliseconds = Math.floor((durationMs % 1000) / 10);

  return `${String(minutes).padStart(2, "0")}:${String(seconds).padStart(2, "0")}.${String(milliseconds).padStart(2, "0")}`;
}

window.restartGame = function() {
  if (!currentMapId) {
    showScreen("mapselect");
    return;
  }

  startGame(currentMapId);
};