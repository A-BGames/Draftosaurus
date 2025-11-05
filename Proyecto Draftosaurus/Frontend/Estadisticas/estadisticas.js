const ctx = document.getElementById("grafico").getContext("2d");

const partidas = JSON.parse(localStorage.getItem("partidasGuardadas")) || [];

let jugadoresMayores = 0;
let jugadoresMenores = 0;

partidas.forEach(partida => {
  partida.jugadores.forEach(jugador => {
    if (jugador.puntos > 7) {
      jugadoresMayores++;
    } else {
      jugadoresMenores++;
    }
  });
});

new Chart(ctx, {
  type: "pie",
  data: {
    labels: ["Jugadores con más de 7 puntos", "Jugadores con 7 o menos puntos"],
    datasets: [{
      data: [jugadoresMayores, jugadoresMenores],
      backgroundColor: ["#91a492", "#e9c46a"],
      borderColor: ["#182b23", "#182b23"],
      borderWidth: 2
    }]
  },
  options: {
    responsive: true,
    plugins: {
      legend: {
        position: "bottom",
        labels: { color: "#182b23", font: { family: "Boogaloo", size: 16 } }
      }
    }
  }
});
