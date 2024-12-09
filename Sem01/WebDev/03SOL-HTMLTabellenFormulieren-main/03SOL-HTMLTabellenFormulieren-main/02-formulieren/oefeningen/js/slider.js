const slider = document.getElementById("score");
const score = document.getElementById("showScore");
slider.addEventListener("input", () => {
  score.innerText = slider.value;
});
score.innerText = slider.value;
