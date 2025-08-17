// Recuperamos el ranking guardado (lista de jugadores)
const ranking = JSON.parse(localStorage.getItem("rankingDraftosaurus")) || [];

// Inicializamos conteos de partidas
let jugadoresConMasDe7 = 0;
let jugadoresSinMasDe7 = 0;

const jugadoresPorRanking = 1; 
let tempPartida = [];

for (let i = 0; i < ranking.length; i++) {
  tempPartida.push(ranking[i]);
  
  // Cada bloque de 1 o el último bloque se considera un jugador
  if (tempPartida.length === jugadoresPorRanking || i === ranking.length - 1) {
    // Verificamos si algún jugador tiene más de 7 puntos
    const algunoConMasDe7 = tempPartida.some(jugador => jugador.puntos > 7);
    if (algunoConMasDe7) {
        jugadoresConMasDe7++;
    } else {
        jugadoresSinMasDe7++;
    }
    tempPartida = [];
  }
}

// Graficar con Chart.js
const ctx = document.getElementById("graficoEstadisticas").getContext("2d");

new Chart(ctx, {
  type: 'pie',
  data: {
    labels: ['Jugadores con >7 puntos', 'Jugadores con ≤7 puntos'],
    datasets: [{
      data: [jugadoresConMasDe7, jugadoresSinMasDe7],
      backgroundColor: ['green', 'red'],
      borderColor: '#fff',
      borderWidth: 2
    }]
  },
  options: {
    responsive: true,
    plugins: {
      legend: { position: 'bottom' },
      tooltip: { enabled: true }
    }
  }
});