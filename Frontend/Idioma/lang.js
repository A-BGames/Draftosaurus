(function () {
  let idiomaActual = localStorage.getItem("idioma") || "es";
  const RUTA_JSON = "../Idioma/lang.json"; // Ruta fija correcta en tu estructura

  function aplicarIdioma() {
    fetch(RUTA_JSON, { cache: "no-store" })
      .then(res => res.json())
      .then(data => {
        const textos = data[idiomaActual];
        document.querySelectorAll("[data-lang]").forEach(el => {
          const clave = el.getAttribute("data-lang");
          if (!textos[clave]) return;

          // Soporta inputs y texto con saltos <br>
          if (el.tagName === "INPUT" && el.type !== "submit") {
            el.placeholder = textos[clave];
          } else if (el.tagName === "OPTION") {
            el.textContent = textos[clave];
          } else {
            el.innerHTML = textos[clave]; // <-- importante!
          }
        });
      });

  }

  function init() {
    const btn = document.getElementById("cambiarIdioma");

    if (btn) {
      btn.addEventListener("click", () => {
        idiomaActual = (idiomaActual === "es") ? "en" : "es";
        localStorage.setItem("idioma", idiomaActual); // Guardar preferencia
        aplicarIdioma();
      });
    }

    aplicarIdioma();
  }

  document.readyState === "loading"
    ? document.addEventListener("DOMContentLoaded", init)
    : init();
})();
