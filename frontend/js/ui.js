// UI state and screen navigation

let currentUser = '';

function showScreen(id) {
  //document.querySelectorAll('.screen').forEach(s => s.classList.remove('active'));
  //document.getElementById(id).classList.add('active');


  //function showScreen(id) {
  console.log("showing screen:", id);

  document.querySelectorAll(".screen").forEach(s => {
    s.classList.remove("active");
  });

  const nextScreen = document.getElementById(id);

  if (!nextScreen) {
    console.error("No screen found with id:", id);
    return;
  }

  nextScreen.classList.add("active");
};


function selectMap(btn) {
  document.querySelectorAll('.map-btn').forEach(b => b.classList.remove('selected'));
  btn.classList.add('selected');
}

function updateLeaderboard() {
  if (!currentUser) return;
  // highlight the current user's row if they appear, otherwise add them
  const rows = document.querySelectorAll('.lb-row');
  let found = false;
  rows.forEach(row => {
    const cell = row.querySelector('div');
    if (cell.textContent === currentUser) {
      cell.style.fontWeight = 'bold';
      cell.style.color = '#5a4fa0';
      found = true;
    }
  });
  // if not already on board, update last row with their name
  if (!found && rows.length > 0) {
    rows[rows.length - 1].querySelector('div').textContent = currentUser;
  }
}

function goBack() {
  showScreen('mapselect');
}



let isSignUpMode = true;

function handleAuth() {
  if (isSignUpMode) {
    goSignUp();
  } else {
    goSignIn();
  }
}

function switchAuthMode() {
  const mainAuthBtn = document.getElementById("main-auth-btn");
  const authText = document.getElementById("auth-text");
  const switchAuthBtn = document.getElementById("switch-auth-btn");

  if (isSignUpMode) {
    isSignUpMode = false;

    mainAuthBtn.textContent = "SIGN IN";
    authText.textContent = "Need an account?";
    switchAuthBtn.textContent = "Sign up";
  } else {
    isSignUpMode = true;

    mainAuthBtn.textContent = "SIGN UP";
    authText.textContent = "Already have an account?";
    switchAuthBtn.textContent = "Sign in";
  }
}

