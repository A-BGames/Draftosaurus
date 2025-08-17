const jugadores = JSON.parse(sessionStorage.getItem("nombresJugadores") || "[]");

const jugadoresEnOrden = [...jugadores]; 
const contenedor = document.getElementById("tablerosContainer");
const template = document.getElementById("templateTablero");

const puntajes = []; 
const params = new URLSearchParams(window.location.search);
const idPartida = params.get('id');

let partidasGuardadas = JSON.parse(localStorage.getItem("partidasGuardadas")) || [];
let partidaActual;
let turnoActual = 0;

const turnoTexto = document.getElementById("turnoActualTexto");

function actualizarTextoTurno() {
  turnoTexto.textContent = `Turno de: ${jugadoresEnOrden[turnoActual]}`;
}





document.getElementById("finalizar").addEventListener("click", () => {
 
  if (idPartida) {
    partidasGuardadas = partidasGuardadas.filter(p => p.id != idPartida);
    localStorage.setItem("partidasGuardadas", JSON.stringify(partidasGuardadas));
  }
  
});
jugadores.forEach(jugador => {
  const clone = template.content.cloneNode(true);
  const tablero = clone.querySelector(".tableroJugador");
  const nombreEl = tablero.querySelector(".nombreJugador");
  const contadorEl = tablero.querySelector(".contador");
  const zonas = tablero.querySelectorAll(".zona");
  const fichas = tablero.querySelectorAll(".ficha");

  
  let puntos = 0;
  
  
  
  

  nombreEl.textContent = jugador;

 
  const jugadorData = { nombre: jugador, puntos: 0 };
  puntajes.push(jugadorData);

  if (partidaActual) {
    const jugadorEnPartida = partidaActual.jugadores.find(j => j.nombre === jugador);
  
    if (jugadorEnPartida) {
      
      puntos = jugadorEnPartida.puntos;
      jugadorData.puntos = puntos;
      contadorEl.textContent = `Puntos: ${puntos}`;
  
     
    }
  }





  fichas.forEach(ficha => {
    ficha.addEventListener("dragstart", e => {
      e.dataTransfer.setData("src", ficha.src);
      e.dataTransfer.setData("id", ficha.dataset.id);
    });
  });

  

  zonas.forEach(zona => {
    zona.addEventListener("dragover", e => e.preventDefault());

    zona.addEventListener("drop", e => {
      e.preventDefault();

      const zonaId = zona.dataset.zona;

      const fichaSrc = e.dataTransfer.getData("src");
      const fichaId = e.dataTransfer.getData("id");
      

      const nuevaFicha = document.createElement("img");
      nuevaFicha.src = fichaSrc;
      nuevaFicha.classList.add("ficha");
      nuevaFicha.dataset.id = fichaId;
      nuevaFicha.draggable = true;
      zona.appendChild(nuevaFicha);

      puntos++;
      jugadorData.puntos = puntos;
      contadorEl.textContent = `Puntos: ${puntos}`;
      
    });
  });

  contenedor.appendChild(clone);
  
});

// FINALIZAR → guarda puntos en ranking
document.getElementById("finalizar").addEventListener("click", () => {
  const rankingGuardado = JSON.parse(localStorage.getItem("rankingDraftosaurus")) || [];
  const nuevoRanking = [...rankingGuardado, ...puntajes];

  localStorage.setItem("rankingDraftosaurus", JSON.stringify(nuevoRanking));
  window.location.href = "../Ranking/ranking.html";
});
// PAUSAR → guarda estado de la partida con ID único
document.getElementById("pausar").addEventListener("click", () => {
  const tableros = document.querySelectorAll(".tableroJugador");

  const jugadoresGuardados = Array.from(tableros).map(tablero => {
    const nombre = tablero.querySelector(".nombreJugador").textContent;
    const puntos = parseInt(tablero.querySelector(".contador").textContent.split(": ")[1]);

    const zonas = {};
    tablero.querySelectorAll(".zona").forEach(zona => {
      const zonaId = zona.dataset.zona;
      const fichas = Array.from(zona.querySelectorAll(".ficha")).map(f => f.dataset.id);
      zonas[zonaId] = fichas;
    });

    return {
      nombre,
      puntos,
      zonas
    };
  });

  const partida = {
    id: idPartida || Date.now(), // reutiliza si ya existe
    fecha: new Date().toISOString(),
    jugadores: jugadoresGuardados,
    estado: "pausada"
  };

  let partidas = JSON.parse(localStorage.getItem("partidasGuardadas")) || [];

  // Si se está re-pausing una existente, actualizala en lugar de duplicar
  const existente = partidas.findIndex(p => p.id == partida.id);
  if (existente !== -1) {
    partidas[existente] = partida;
  } else {
    partidas.push(partida);
  }

  localStorage.setItem("partidasGuardadas", JSON.stringify(partidas));
  window.location.href = "../Index/index.html";
});
function capitalize(str) {
  return str.charAt(0).toUpperCase() + str.slice(1);
}