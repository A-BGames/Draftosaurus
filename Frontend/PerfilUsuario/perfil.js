async function cargarPerfil() {
  try {
    const respuesta = await fetch("../../Backend/Capa_de_Datos/usuarioActual.php");
    const datos = await respuesta.json();
    console.log(datos);

    if (datos.estado === "no_sesion") {
      window.location.href = "../InicioSesion/inicioSesion.html";
      return;
    }

    document.getElementById("nombre_usuario").textContent = datos.usuario;
    document.getElementById("correo_usuario").textContent = datos.correo;

  } catch (error) {
    console.error("Error cargando perfil:", error);
  }
}

document.getElementById("cerrarSesion").addEventListener("click", async () => {
  await fetch("../../Backend/Capa_de_Datos/cerrarSesion.php");
  window.location.href = "../InicioSesion/inicioSesion.html";
});

cargarPerfil();