const jugadoresContainer = document.getElementById("jugadoresInputs");
const numeroJugadoresSelect = document.getElementById("numeroJugadores");

let usuario_actual = null;
let todosLosUsuarios = [];

// Cargar usuario actual y lista de todos los usuarios
async function cargarDatosUsuarios() {
  try {
    const resUsuario = await fetch("../../../Backend/Capa_de_Datos/usuarioActual.php");
    const dataUsuario = await resUsuario.json();
    usuario_actual = dataUsuario.usuario;

    const resUsuarios = await fetch("../../../Backend/Capa_de_Datos/listaUsuarios.php");
    todosLosUsuarios = await resUsuarios.json();

    // Elimina el usuario actual de la lista
    todosLosUsuarios = todosLosUsuarios.filter(u => u !== usuario_actual);
  } catch (err) {
    console.error("Error cargando usuarios:", err);
  }
}

// Genera inputs según cantidad de jugadores
numeroJugadoresSelect.addEventListener("change", async function () {
  const cantidad = parseInt(this.value);
  jugadoresContainer.innerHTML = "";

  await cargarDatosUsuarios();

  for (let i = 1; i <= cantidad; i++) {
    const label = document.createElement("label");
    label.textContent = `Nombre del Jugador ${i}:`;

    if (i === 1) {
      const input = document.createElement("input");
      input.type = "text";
      input.required = true;
      input.name = `jugador${i}`;
      input.value = usuario_actual;
      input.readOnly = true;
      input.classList.add("nombre-jugador");

      jugadoresContainer.appendChild(label);
      jugadoresContainer.appendChild(input);
    } else {
      const select = document.createElement("select");
      select.name = `jugador${i}`;
      select.required = true;
      select.classList.add("nombre-jugador");

      const defaultOption = document.createElement("option");
      defaultOption.value = "";
      defaultOption.disabled = true;
      defaultOption.selected = true;
      defaultOption.textContent = "Seleccione un jugador";
      select.appendChild(defaultOption);

      todosLosUsuarios.forEach(nombre => {
        const option = document.createElement("option");
        option.value = nombre;
        option.textContent = nombre;
        select.appendChild(option);
      });

      jugadoresContainer.appendChild(label);
      jugadoresContainer.appendChild(select);
    }

    jugadoresContainer.appendChild(document.createElement("br"));
  }
});


document.getElementById("formularioNuevaPartida").addEventListener("submit", async function (e) {
  e.preventDefault();

  const nombre_partida = document.getElementById("nombre_partida").value.trim();
  const id_modo = document.getElementById("id_modo").value;
  const cantidadJugadores = parseInt(document.getElementById("numeroJugadores").value);
  const inputs = document.querySelectorAll(".nombre-jugador");
  const nombresJugadores = [...inputs].map(input => input.value.trim());

  if (!nombre_partida || !id_modo || !cantidadJugadores || nombresJugadores.some(nombre => !nombre)) {
    alert("Debes completar todos los campos.");
    return;
  }

  try {
    const res = await fetch("../../../Backend/Capa_de_Datos/crearPartida.php", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ nombre_partida, id_modo, jugadores: nombresJugadores })
    });

    // Lee como texto para depurar errores
    const text = await res.text();
    try {
      const data = JSON.parse(text); // Convierte a JSON
      if (data.success) {
        window.location.href = `../Partida/registroPartidas.html?id=${data.idPartida}`;
      } else {
        alert("Error al crear la partida: " + (data.error || "Desconocido"));
      }
    } catch {
      console.error("Respuesta no JSON recibida:", text);
      alert("Error del servidor, revisa la consola.");
    }
  } catch (err) {
    console.error("Error conectando al servidor:", err);
    alert("Error al conectar con el servidor");
  }
});
