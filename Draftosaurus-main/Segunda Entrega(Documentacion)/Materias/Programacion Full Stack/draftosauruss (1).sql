-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-09-2025 a las 23:24:18
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `draftosauruss`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dinosaurios`
--

CREATE TABLE `dinosaurios` (
  `id_dino` int(1) NOT NULL,
  `color` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especie`
--

CREATE TABLE `especie` (
  `id_especie` int(1) NOT NULL,
  `nombre_especie` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especie`
--

INSERT INTO `especie` (`id_especie`, `nombre_especie`) VALUES
(1, 'Triceratops'),
(2, 'Tiranosaurio Rex'),
(3, 'Brontosaurio'),
(4, 'Espinosaurio'),
(5, 'Stegosaurio'),
(6, 'Parasaurolophus');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `id_estado` int(3) NOT NULL,
  `curso` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`id_estado`, `curso`) VALUES
(1, 'en_curso'),
(2, 'en_pausa'),
(3, 'finalizada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `id_jugador` int(3) NOT NULL,
  `primer_nombre` varchar(20) NOT NULL,
  `apellido_paterno` varchar(20) NOT NULL,
  `apellido_materno` varchar(20) NOT NULL,
  `nombre_usuario` varchar(40) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `correo` varchar(50) NOT NULL,
  `celular` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jugador`
--

INSERT INTO `jugador` (`id_jugador`, `primer_nombre`, `apellido_paterno`, `apellido_materno`, `nombre_usuario`, `contraseña`, `fecha_nacimiento`, `correo`, `celular`) VALUES
(1, 'Federico', 'Fernandez', 'Padron', 'Federico12', '$2y$10$Frui.kGpUGcxZVK4NYT1ze9mbBuMJjFmnnuLHvBiZkpGR6ggIDpXW', '2017-11-28', 'federico@gmail.com', 98564374),
(2, 'arjona', 'abrojo', 'alvez', 'arjona12', '$2y$10$GwDdMmZq1dN6hrp/DrP75eGk7aO5lJHKSGgxfV6qQmR2ukdLgt4ty', '2017-11-28', 'arjona@gmail.com', 98123456);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modo_juego`
--

CREATE TABLE `modo_juego` (
  `id_modo` int(3) NOT NULL,
  `modalidad` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `modo_juego`
--

INSERT INTO `modo_juego` (`id_modo`, `modalidad`) VALUES
(1, 'Estandar'),
(2, 'Hardcore'),
(3, 'Asistido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partida`
--

CREATE TABLE `partida` (
  `id_partida` int(3) NOT NULL,
  `nombre_partida` varchar(30) NOT NULL,
  `fecha` date NOT NULL,
  `ganador` int(3) DEFAULT NULL,
  `id_modo` int(3) NOT NULL,
  `id_estado` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `partida`
--

INSERT INTO `partida` (`id_partida`, `nombre_partida`, `fecha`, `ganador`, `id_modo`, `id_estado`) VALUES
(11, 'jurasic', '2025-09-15', 1, 1, 3),
(12, 'jurasic2', '2025-09-15', NULL, 1, 1),
(15, 'jurasic3', '2025-09-15', NULL, 1, 1),
(16, 'macaron', '2025-09-15', NULL, 2, 1),
(17, 'dinopark', '2025-09-15', NULL, 1, 1),
(18, 'dinopark2', '2025-09-15', NULL, 1, 1),
(19, 'jurasicpark', '2025-09-15', NULL, 1, 1),
(21, 'jurasicpark2', '2025-09-15', NULL, 1, 1),
(22, 'jurasicpark3', '2025-09-15', NULL, 1, 1),
(23, 'limon', '2025-09-15', NULL, 1, 1),
(24, 'limbo', '2025-09-15', NULL, 1, 1),
(25, 'latonia', '2025-09-15', NULL, 1, 1),
(26, 'bene', '2025-09-15', NULL, 1, 1),
(27, 'tera', '2025-09-15', NULL, 1, 1),
(28, 'tera2', '2025-09-15', NULL, 1, 1),
(30, 'tera21', '2025-09-15', NULL, 1, 1),
(31, 'tera211', '2025-09-15', NULL, 1, 1),
(32, 'tera2111', '2025-09-15', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partida_jugador`
--

CREATE TABLE `partida_jugador` (
  `id_jugador` int(11) NOT NULL,
  `id_partida` int(11) NOT NULL,
  `puntaje` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `partida_jugador`
--

INSERT INTO `partida_jugador` (`id_jugador`, `id_partida`, `puntaje`) VALUES
(1, 11, 0),
(1, 12, 0),
(1, 15, 0),
(1, 16, 0),
(1, 17, 0),
(1, 18, 0),
(1, 19, 0),
(1, 21, 0),
(1, 22, 0),
(1, 23, 0),
(1, 24, 0),
(1, 25, 0),
(1, 26, 0),
(1, 27, 0),
(1, 28, 0),
(1, 30, 0),
(1, 31, 0),
(1, 32, 0),
(2, 11, 0),
(2, 15, 0),
(2, 16, 0),
(2, 17, 0),
(2, 21, 0),
(2, 22, 0),
(2, 23, 0),
(2, 24, 0),
(2, 25, 0),
(2, 26, 0),
(2, 27, 0),
(2, 28, 0),
(2, 30, 0),
(2, 31, 0),
(2, 32, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ronda`
--

CREATE TABLE `ronda` (
  `id_ronda` int(2) NOT NULL,
  `nro_ronda` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ronda`
--

INSERT INTO `ronda` (`id_ronda`, `nro_ronda`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tablero`
--

CREATE TABLE `tablero` (
  `id_tablero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tablero`
--

INSERT INTO `tablero` (`id_tablero`) VALUES
(1),
(2),
(3),
(4),
(5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tablero_partida_jugador`
--

CREATE TABLE `tablero_partida_jugador` (
  `id_tablero` int(11) NOT NULL,
  `id_partida` int(11) NOT NULL,
  `id_jugador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tablero_partida_jugador`
--

INSERT INTO `tablero_partida_jugador` (`id_tablero`, `id_partida`, `id_jugador`) VALUES
(1, 23, 1),
(1, 24, 1),
(1, 25, 1),
(1, 26, 1),
(1, 27, 1),
(1, 28, 1),
(1, 30, 1),
(1, 31, 1),
(1, 32, 1),
(2, 23, 2),
(2, 24, 2),
(2, 25, 2),
(2, 26, 2),
(2, 27, 2),
(2, 28, 2),
(2, 30, 2),
(2, 31, 2),
(2, 32, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno`
--

CREATE TABLE `turno` (
  `id_turno` int(2) NOT NULL,
  `nro_turno` int(2) NOT NULL,
  `id_ronda` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `turno`
--

INSERT INTO `turno` (`id_turno`, `nro_turno`, `id_ronda`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 1, 2),
(8, 2, 2),
(9, 3, 2),
(10, 4, 2),
(11, 5, 2),
(12, 6, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno_partida_jugador`
--

CREATE TABLE `turno_partida_jugador` (
  `id_turno` int(2) NOT NULL,
  `id_partida` int(3) NOT NULL,
  `id_jugador` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `turno_partida_jugador`
--

INSERT INTO `turno_partida_jugador` (`id_turno`, `id_partida`, `id_jugador`) VALUES
(1, 21, 1),
(1, 21, 2),
(1, 22, 1),
(1, 22, 2),
(1, 23, 1),
(1, 23, 2),
(1, 24, 1),
(1, 24, 2),
(1, 25, 1),
(1, 25, 2),
(1, 26, 1),
(1, 26, 2),
(1, 27, 1),
(1, 27, 2),
(1, 28, 1),
(1, 28, 2),
(1, 30, 1),
(1, 30, 2),
(1, 31, 1),
(1, 31, 2),
(1, 32, 1),
(1, 32, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zona`
--

CREATE TABLE `zona` (
  `id_zona` int(1) NOT NULL,
  `nombre_zona` varchar(30) NOT NULL,
  `regla_zona` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `zona`
--

INSERT INTO `zona` (`id_zona`, `nombre_zona`, `regla_zona`) VALUES
(1, 'El Bosque de la Semejanza', 'Solo puedes colocar dinosaurios de la misma especi'),
(2, 'El Prado de la Diferencia', 'No puede haber más de un dinosaurio de la misma es'),
(3, 'La Pradera del Amor', 'Puedes colocar hasta dos dinosaurios de la misma e'),
(4, 'El Trío Frondoso', 'Este recinto sólo puede albergar 3 dinosaurios'),
(5, 'El Rey de la Selva', 'Este recinto puede albergar solo 1 dinosaurio'),
(6, 'La Isla Solitaria', 'Este recinto puede albergar solo 1 dinosaurio'),
(7, 'Rio', 'No hay');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `dinosaurios`
--
ALTER TABLE `dinosaurios`
  ADD PRIMARY KEY (`id_dino`);

--
-- Indices de la tabla `especie`
--
ALTER TABLE `especie`
  ADD PRIMARY KEY (`id_especie`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`id_jugador`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `celular` (`celular`);

--
-- Indices de la tabla `modo_juego`
--
ALTER TABLE `modo_juego`
  ADD PRIMARY KEY (`id_modo`);

--
-- Indices de la tabla `partida`
--
ALTER TABLE `partida`
  ADD PRIMARY KEY (`id_partida`),
  ADD UNIQUE KEY `nombre_partida` (`nombre_partida`),
  ADD KEY `id_modo` (`id_modo`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `ganador` (`ganador`);

--
-- Indices de la tabla `partida_jugador`
--
ALTER TABLE `partida_jugador`
  ADD PRIMARY KEY (`id_jugador`,`id_partida`),
  ADD KEY `id_partida` (`id_partida`);

--
-- Indices de la tabla `ronda`
--
ALTER TABLE `ronda`
  ADD PRIMARY KEY (`id_ronda`);

--
-- Indices de la tabla `tablero`
--
ALTER TABLE `tablero`
  ADD PRIMARY KEY (`id_tablero`);

--
-- Indices de la tabla `tablero_partida_jugador`
--
ALTER TABLE `tablero_partida_jugador`
  ADD PRIMARY KEY (`id_tablero`,`id_partida`,`id_jugador`),
  ADD KEY `id_partida` (`id_partida`),
  ADD KEY `id_jugador` (`id_jugador`);

--
-- Indices de la tabla `turno`
--
ALTER TABLE `turno`
  ADD PRIMARY KEY (`id_turno`),
  ADD KEY `id_ronda` (`id_ronda`);

--
-- Indices de la tabla `turno_partida_jugador`
--
ALTER TABLE `turno_partida_jugador`
  ADD PRIMARY KEY (`id_turno`,`id_partida`,`id_jugador`),
  ADD KEY `id_partida` (`id_partida`),
  ADD KEY `id_jugador` (`id_jugador`);

--
-- Indices de la tabla `zona`
--
ALTER TABLE `zona`
  ADD PRIMARY KEY (`id_zona`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `dinosaurios`
--
ALTER TABLE `dinosaurios`
  MODIFY `id_dino` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `especie`
--
ALTER TABLE `especie`
  MODIFY `id_especie` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `id_estado` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `jugador`
--
ALTER TABLE `jugador`
  MODIFY `id_jugador` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `modo_juego`
--
ALTER TABLE `modo_juego`
  MODIFY `id_modo` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `partida`
--
ALTER TABLE `partida`
  MODIFY `id_partida` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `partida_jugador`
--
ALTER TABLE `partida_jugador`
  MODIFY `id_jugador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ronda`
--
ALTER TABLE `ronda`
  MODIFY `id_ronda` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `turno`
--
ALTER TABLE `turno`
  MODIFY `id_turno` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `zona`
--
ALTER TABLE `zona`
  MODIFY `id_zona` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `partida`
--
ALTER TABLE `partida`
  ADD CONSTRAINT `partida_ibfk_1` FOREIGN KEY (`id_modo`) REFERENCES `modo_juego` (`id_modo`),
  ADD CONSTRAINT `partida_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id_estado`),
  ADD CONSTRAINT `partida_ibfk_3` FOREIGN KEY (`ganador`) REFERENCES `jugador` (`id_jugador`);

--
-- Filtros para la tabla `partida_jugador`
--
ALTER TABLE `partida_jugador`
  ADD CONSTRAINT `partida_jugador_ibfk_1` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`),
  ADD CONSTRAINT `partida_jugador_ibfk_2` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`),
  ADD CONSTRAINT `partida_jugador_ibfk_3` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`),
  ADD CONSTRAINT `partida_jugador_ibfk_4` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`);

--
-- Filtros para la tabla `tablero_partida_jugador`
--
ALTER TABLE `tablero_partida_jugador`
  ADD CONSTRAINT `tablero_partida_jugador_ibfk_1` FOREIGN KEY (`id_tablero`) REFERENCES `tablero` (`id_tablero`),
  ADD CONSTRAINT `tablero_partida_jugador_ibfk_2` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`),
  ADD CONSTRAINT `tablero_partida_jugador_ibfk_3` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`);

--
-- Filtros para la tabla `turno`
--
ALTER TABLE `turno`
  ADD CONSTRAINT `turno_ibfk_1` FOREIGN KEY (`id_ronda`) REFERENCES `ronda` (`id_ronda`);

--
-- Filtros para la tabla `turno_partida_jugador`
--
ALTER TABLE `turno_partida_jugador`
  ADD CONSTRAINT `turno_partida_jugador_ibfk_1` FOREIGN KEY (`id_turno`) REFERENCES `turno` (`id_turno`),
  ADD CONSTRAINT `turno_partida_jugador_ibfk_2` FOREIGN KEY (`id_partida`) REFERENCES `partida_jugador` (`id_partida`),
  ADD CONSTRAINT `turno_partida_jugador_ibfk_3` FOREIGN KEY (`id_jugador`) REFERENCES `partida_jugador` (`id_jugador`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
