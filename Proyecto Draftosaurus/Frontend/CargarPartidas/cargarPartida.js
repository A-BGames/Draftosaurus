const partidas = JSON.parse(localStorage.getItem("partidasGuardadas")) || [];
const contenedorPartidas = document.getElementById("espacioPartidas");
const plantilla = document.getElementById("plantilla-partida");

partidas
  .filter(p => Array.isArray(p.jugadores) && p.estado !== "Finalizada")
  .forEach(partida => {
    const clone = plantilla.content.cloneNode(true);
    clone.querySelector(".nombre-partida").textContent =
      `${partida.nombre || "Partida"} — ${new Date(partida.fecha).toLocaleDateString()}`;
    clone.querySelector(".jugadores").textContent =
      partida.jugadores.map(j => `${j.nombre}: ${j.puntos} pts`).join(" | ");
    clone.querySelector(".estado").textContent = `Estado: ${partida.estado}`;
    clone.querySelector(".retomar-btn").href =
      `../Partida/registroPartidas.html?id=${partida.id}`;
    contenedorPartidas.appendChild(clone);
  });

  

