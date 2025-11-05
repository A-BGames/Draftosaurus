const urlRanking = "../../Backend/Capa_de_Datos/ranking.php";

fetch(urlRanking)
  .then(response => {
    if (!response.ok) {
      throw new Error("Error al obtener el ranking: " + response.statusText);
    }
    return response.json();
  })
  .then(data => {
    if (!data.success) {
      throw new Error("Error al obtener el ranking: " + (data.error || "Desconocido"));
    }

    const ranking = data.ranking; // array de jugadores
    const cuerpoTabla = document.getElementById("cuerpoRanking");
    cuerpoTabla.innerHTML = ""; // limpiar tabla antes de agregar filas

    ranking.forEach((entrada, index) => {
      const fila = document.createElement("tr");

      const puesto = document.createElement("td");
      puesto.textContent = `${index + 1}º`;

      const nombre = document.createElement("td");
      nombre.textContent = entrada.nombre;

      const puntos = document.createElement("td");
      puntos.textContent = entrada.puntos;

      fila.appendChild(puesto);
      fila.appendChild(nombre);
      fila.appendChild(puntos);

      cuerpoTabla.appendChild(fila);
    });
  })
  .catch(error => {
    console.error("Error al cargar el ranking:", error);
    alert("No se pudo cargar el ranking. Intenta recargar la página.");
  });