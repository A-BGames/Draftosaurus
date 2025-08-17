document.getElementById("numeroJugadores").addEventListener("change", function () {
    const cantidad = parseInt(this.value);
    const contenedor = document.getElementById("jugadoresInputs");
    contenedor.innerHTML = "";
  
    for (let i = 1; i <= cantidad; i++) {
      const label = document.createElement("label");
      label.textContent = `Nombre del Jugador ${i}:`;
      const input = document.createElement("input");
      input.type = "text";
      input.required = true;
      input.name = `jugador${i}`;
      input.classList.add("nombre-jugador");
      contenedor.appendChild(label);
      contenedor.appendChild(input);
      contenedor.appendChild(document.createElement("br"));
    }
  });
  
  document.getElementById("formularioNuevaPartida").addEventListener("submit", function (e) {
    e.preventDefault();
  
    const nombrePartida = document.getElementById("nombrePartida").value.trim();
    const cantidadJugadores = parseInt(document.getElementById("numeroJugadores").value);
    const inputs = document.querySelectorAll(".nombre-jugador");
    const nombresJugadores = [...inputs].map(input => input.value.trim());
  
    if (!nombrePartida || !cantidadJugadores || nombresJugadores.some(nombre => !nombre)) {
      alert("Debes completar todos los campos.");
      return;
    }
  
    // Guarda los datos en sessionStorage
    sessionStorage.setItem("nombrePartida", nombrePartida);
    sessionStorage.setItem("nombresJugadores", JSON.stringify(nombresJugadores));
  
    // Redirecciona a la página de juego
    window.location.href = "../Partida/registroPartidas.html";
  });