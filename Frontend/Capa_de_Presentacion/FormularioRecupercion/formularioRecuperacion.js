document.addEventListener("DOMContentLoaded", () => {
    const medioSelect = document.getElementById("medio");
    const datosRecuperacion = document.getElementById("datosRecuperacion");

    medioSelect.addEventListener("change", () => {
        
        datosRecuperacion.innerHTML = "";

        if (medioSelect.value === "2") { 
            const label = document.createElement("label");
            label.setAttribute("for", "email");
            label.textContent = "Correo electrónico:";

            const input = document.createElement("input");
            input.setAttribute("type", "email");
            input.setAttribute("id", "email");
            input.setAttribute("name", "email");
            input.setAttribute("pattern", "^[a-zA-Z0-9._%+-]{1,}@[a-zA-Z]{3,}\.[a-zA-Z]{2,}$");
            input.setAttribute("required", true);
            input.setAttribute("placeholder", "Ej: algo@algo.algo");

            datosRecuperacion.appendChild(label);
            datosRecuperacion.appendChild(input);

        } else if (medioSelect.value === "3") { 
            const label = document.createElement("label");
            label.setAttribute("for", "celular");
            label.textContent = "Número de celular:";

            const input = document.createElement("input");
            input.setAttribute("type", "tel");
            input.setAttribute("id", "celular");
            input.setAttribute("name", "celular");
            input.setAttribute("pattern", "^09[0-9]{7}$");
            input.setAttribute("required", true);
            input.setAttribute("placeholder", "Ej: 098765432");

            datosRecuperacion.appendChild(label);
            datosRecuperacion.appendChild(input);
        }
    });
});