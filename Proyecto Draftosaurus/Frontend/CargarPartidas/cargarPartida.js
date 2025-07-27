const partidas = JSON.parse(localStorage.getItem("partidasGuardadas")) || [];
const contendeorPartidas = document.getElementById("espacioPartidas");

partidas
  .filter(p => Array.isArray(p.jugadores)) // ← solo las partidas válidas
  .forEach(partida => {
    const tarjeta = document.createElement("div");
    tarjeta.classList.add("partidasPausadas");

    const jugadoresTxt = partida.jugadores.map(j => `${j.nombre}: ${j.puntos} pts`).join(' | ');

    tarjeta.innerHTML = `
      <h3 class="nombrePartida">Pausa ${new Date(partida.fecha).toLocaleString()}</h3>
      <p class="datos">${jugadoresTxt}</p>
      <p class="datos">Estado: ${partida.estado}</p>
      <button class="ver"><a href="../Partida/registroPartidas.html?id=${partida.id}" id="retomarJuego">Retomar</a></button>
    `;
    contendeorPartidas.appendChild(tarjeta);
  });