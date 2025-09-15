let tableros = []; 
let id_partida = null; 
let turnoActual = 0;
document.addEventListener('DOMContentLoaded', async () => {
  const params = new URLSearchParams(window.location.search);
  id_partida = params.get('id');

  if (!id_partida) {
    alert('No se encontró el ID de la partida.');
    return;
  }
  let puntaje = [];
  let jugadoresNombres = [];
  
  try {
   
    
    const res = await fetch(`../../Backend/registroPartidas.php?id=${id_partida}`);
    const data = await res.json();
 console.log(data);
    if (!data.success) {
      alert('Error al obtener los datos de la partida: ' + data.error);
      return;
    }

    const jugadores = data.jugadores; 
    jugadoresNombres = jugadores.map(j => j.nombre);
    const contenedor = document.getElementById('tablerosContainer');
    const template = document.getElementById('templateTablero');
    
    jugadores.forEach(jugador => {
      const clone = template.content.cloneNode(true);
      const tablero = clone.querySelector('.tableroJugador');
      const nombreEl = tablero.querySelector('.nombreJugador');
      const contadorEl = tablero.querySelector('.contador');
      const zonas = tablero.querySelectorAll('.zona');
      const fichas = tablero.querySelectorAll('.ficha');

      let puntos = 0;
      nombreEl.textContent = jugador.nombre;
      tablero.dataset.idJugador = jugador.id;

      const jugadorData = { 
        id: jugador.id,
        nombre: jugador.nombre, 
        puntos: 0, 
        tablero: tablero  
      };

puntaje.push(jugadorData);
tableros.push(jugadorData);
      // Asocia el evento de arrastre a las fichas
      fichas.forEach(ficha => activarDragFicha(ficha));

      zonas.forEach(zona => {
    zona.addEventListener('dragover', e => {
      if (tablero.classList.contains("activo")) { 
        e.preventDefault();
      }
    });
        zona.addEventListener('drop', e => {
      if (!tablero.classList.contains("activo")) return; 
      e.preventDefault();

          const zonaId = zona.dataset.zona;
          const fichaSrc = e.dataTransfer.getData('src');
          const fichaId = e.dataTransfer.getData('id');

          const nuevaFicha = document.createElement('img');
          nuevaFicha.src = fichaSrc;
          nuevaFicha.classList.add('ficha');
          nuevaFicha.dataset.id = fichaId;
          
          nuevaFicha.draggable = true;
          activarDragFicha(nuevaFicha);
          zona.appendChild(nuevaFicha);

          puntos++;
          jugadorData.puntos = puntos;
          contadorEl.textContent = `Puntos: ${puntos}`;
        });
      });

      contenedor.appendChild(clone);
    });
    actualizarTurno();
  } catch (err) {
    console.error('Error al cargar los datos de la partida:', err);
    alert('Error al conectar con el servidor.');
  }
  async function siguienteTurno() {
  const jugadorActual = tableros[turnoActual];

  try {
    
    const res = await fetch("../../Backend/actualizarPartida.php", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        id_partida: parseInt(id_partida),
        id_estado: 1,        // en curso
        id_jugador: jugadorActual.id
      })
    });
    const data = await res.json();
    if (!data.success) {
      return alert('Error al actualizar la partida: ' + (data.error || "Desconocido"));
    }
    console.log("Turno global actualizado:", data.turno);

    
    turnoActual = (turnoActual + 1) % tableros.length;
    actualizarTurno();

  } catch (err) {
    console.error("Error al conectar con el servidor:", err);
  }
}
  function actualizarTurno() {
  const turnoEl = document.getElementById('turnoActualTexto');
  turnoEl.textContent = "Turno de: " + jugadoresNombres[turnoActual];

  tableros.forEach(t => t.tablero.classList.remove("activo"));
  tableros[turnoActual].tablero.classList.add("activo");
}
  
  document.getElementById('lanzarDado').addEventListener('click', async () => {
    await siguienteTurno();
  });
  function determinarGanador(puntaje) {
  return puntaje.reduce((max, jugador) => jugador.puntos > max.puntos ? jugador : max, puntaje[0]).nombre;
}

  function recolectarEstado() {
    const dinos = [];
    const mapaEspecies = {
      rojo: "Tiranosaurio Rex",
      amarillo: "Triceratops",
      verde: "Parasaurolophus",
      lila: "Brontosaurio",
      azul: "Stegosaurio",
      naranja: "Espinosaurio"
    };

    document.querySelectorAll(".tableroJugador").forEach(tablero => {
      const idJugador = parseInt(tablero.dataset.idJugador);
      tablero.querySelectorAll(".zona").forEach(zona => {
        const idZona = zona.dataset.zona;
        zona.querySelectorAll(".ficha").forEach(ficha => {
          dinos.push({
            id_jugador: idJugador,
            especie: mapaEspecies[ficha.dataset.id] || "Desconocido",
            id_zona: idZona,
            puntos: parseInt(ficha.dataset.puntos || 0)
          });
        });
      });
    });

    return dinos;
  }
  
  document.getElementById('finalizar').addEventListener('click', async () => {
    const estadoDinos = recolectarEstado();
  try {
    const res = await fetch("../../Backend/finalizarPartida.php", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        id_partida: parseInt(id_partida),
        estado: "finalizada",
          turno: turnoActual + 1,
          ronda: (turnoActual + 1 <= 6 ? 1 : 2),
          dinosaurios: estadoDinos,
        jugadores: puntaje, 
        ganador: determinarGanador(puntaje) 
      })
    });

    const data = await res.json();

    if (!data.success) {
      alert("Error al finalizar la partida: " + (data.error || "Desconocido"));
      return;
    }

    window.location.href = "../Ranking/ranking.html?id=" + id_partida;
  } catch (err) {
    console.error('Error al finalizar la partida:', err);
    alert('Error al conectar con el servidor.');
  }
});

  
  document.getElementById('pausar').addEventListener('click', async () => {
    const tableros = document.querySelectorAll('.tableroJugador');

    const jugadoresGuardados = Array.from(tableros).map(tablero => {
      const nombre = tablero.querySelector('.nombreJugador').textContent;
      const puntos = parseInt(tablero.querySelector('.contador').textContent.split(': ')[1]);

      const zonas = {};
      tablero.querySelectorAll('.zona').forEach(zona => {
        const zonaId = zona.dataset.zona;
        const fichas = Array.from(zona.querySelectorAll('.ficha')).map(f => f.dataset.id);
        zonas[zonaId] = fichas;
      });

      return { nombre, puntos, zonas };
    });

    const partida = {
      id: id_partida || Date.now(), 
      fecha: new Date().toISOString(),
      jugadores: jugadoresGuardados,
      estado: "En curso"
    };

    
    try {
      const res = await fetch("../../Backend/actualizarPartida.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          id_partida: parseInt(id_partida),
          estado: "En curso"
        })
      });

      const data = await res.json();

      if (!data.success) {
        alert("Error al actualizar el estado de la partida en la base de datos: " + (data.error || "Desconocido"));
        return;
      }

    
      const pausaRes = await fetch("../../Backend/pausarPartida.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          id_partida: parseInt(id_partida),
          estado: "en_pausa", 
          jugadores: jugadoresGuardados
        })
      });

      const pausaData = await pausaRes.json();

      if (!pausaData.success) {
        alert('Error al pausar la partida: ' + (pausaData.error || "Desconocido"));
        return;
      }

      window.location.href = "../Index/index.html"; 
    } catch (err) {
      console.error("Error al pausar la partida:", err);
      alert("Fallo al conectar con el servidor.");
    }
  });
});


function activarDragFicha(ficha) {
  ficha.addEventListener("dragstart", e => {
    e.dataTransfer.setData("src", ficha.src);
    e.dataTransfer.setData("id", ficha.dataset.id);
  });
}