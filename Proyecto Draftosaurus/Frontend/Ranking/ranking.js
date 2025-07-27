const ranking = JSON.parse(localStorage.getItem("rankingDraftosaurus")) || [];
      
        // Ordenar de mayor a menor puntaje
        ranking.sort((a, b) => b.puntos - a.puntos);
      
        const cuerpoTabla = document.getElementById("cuerpoRanking");
      
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