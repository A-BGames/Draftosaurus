-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-11-2025 a las 21:08:56
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
-- Base de datos: `draftosaurus`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dinosaurio`
--

CREATE TABLE `dinosaurio` (
  `id_dinosaurio` int(5) NOT NULL,
  `id_zona` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dinosaurio_especie`
--

CREATE TABLE `dinosaurio_especie` (
  `id_dinosaurio` int(5) NOT NULL,
  `id_especie` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dinosaurio_partida_jugador`
--

CREATE TABLE `dinosaurio_partida_jugador` (
  `id_dinosaurio` int(5) NOT NULL,
  `id_partida` int(4) NOT NULL,
  `id_jugador` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especie`
--

CREATE TABLE `especie` (
  `id_especie` int(1) NOT NULL,
  `nombre_especie` varchar(20) NOT NULL,
  `color` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especie`
--

INSERT INTO `especie` (`id_especie`, `nombre_especie`, `color`) VALUES
(1, 'Triceratops', 'amarillo'),
(2, 'Tiranosaurio Rex', 'rojo'),
(3, 'Brontosaurio', 'violeta'),
(4, 'Espinosaurio', 'naranja'),
(5, 'Stegosaurio', 'celeste'),
(6, 'Parasaurolophus', 'verde');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `id_estado` int(1) NOT NULL,
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
-- Estructura de tabla para la tabla `fecha_partida`
--

CREATE TABLE `fecha_partida` (
  `id_partida` int(4) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `fecha_partida`
--

INSERT INTO `fecha_partida` (`id_partida`, `fecha`) VALUES
(5, '2025-09-22'),
(6, '2025-09-22'),
(7, '2025-09-23'),
(8, '2025-09-27'),
(9, '2025-09-27'),
(10, '2025-09-27'),
(11, '2025-10-16'),
(12, '2025-10-16'),
(13, '2025-10-16'),
(14, '2025-10-16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `id_jugador` int(4) NOT NULL,
  `primer_nombre` varchar(20) NOT NULL,
  `apellido_paterno` varchar(20) NOT NULL,
  `apellido_materno` varchar(20) NOT NULL,
  `nombre_usuario` varchar(40) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `celular` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jugador`
--

INSERT INTO `jugador` (`id_jugador`, `primer_nombre`, `apellido_paterno`, `apellido_materno`, `nombre_usuario`, `contraseña`, `correo`, `celular`) VALUES
(1, 'Federico', 'Fernandez', 'Padron', 'Federico12', '$2y$10$Qwcj4I0hSqAaxK5Ujbw28e57eWEw24BbD4QcOTg4GpUOQ.eRgdVmu', 'federico@gmail.com', 1234567),
(2, 'Luis', 'Fernandez', 'Padron', 'LuisC12', '$2y$10$2l.qWA48Yxrxz97qAgPWs.6dhbda2H9cacWUd6LMDT2PNYaopLkD.', 'luis@gmail.com', 1234566),
(3, 'Gabriel', 'Fernandez', 'Duarte', 'Gabi', '$2y$10$bD5mam4i6on.hLFPXJoBtuDwrNKSAIimdSbr4PPSqNAo/Fjcoi4VK', 'fz4.gabriel@gmail.com', 8782372),
(5, 'pablo', 'flores', 'acosta', 'pflores', '$2y$10$5LsCwz/BXVGoNSOKmipokuOIEnsi6cy8Yba.03iI9rnT.6R2MwL..', 'pflores@mail.com', 1234568);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modo_juego`
--

CREATE TABLE `modo_juego` (
  `id_modo` int(1) NOT NULL,
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
-- Estructura de tabla para la tabla `nacimiento_jugador`
--

CREATE TABLE `nacimiento_jugador` (
  `id_jugador` int(4) NOT NULL,
  `fecha_nacimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `nacimiento_jugador`
--

INSERT INTO `nacimiento_jugador` (`id_jugador`, `fecha_nacimiento`) VALUES
(1, '2017-11-29'),
(2, '2017-11-07'),
(3, '1994-04-25'),
(5, '1984-09-08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partida`
--

CREATE TABLE `partida` (
  `id_partida` int(4) NOT NULL,
  `nombre_partida` varchar(30) NOT NULL,
  `ganador` int(4) DEFAULT NULL,
  `id_modo` int(1) NOT NULL,
  `id_estado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `partida`
--

INSERT INTO `partida` (`id_partida`, `nombre_partida`, `ganador`, `id_modo`, `id_estado`) VALUES
(5, 'abracadabra6', NULL, 1, 1),
(6, 'tren', NULL, 1, 1),
(7, 'demo', NULL, 1, 1),
(8, 'pflores', NULL, 1, 1),
(9, 'pflores', NULL, 1, 1),
(10, 'pflores', NULL, 1, 1),
(11, 'kfjjs', NULL, 1, 1),
(12, 'poipo', NULL, 1, 1),
(13, 'gergerger', NULL, 1, 1),
(14, 'gergergerger', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partida_jugador`
--

CREATE TABLE `partida_jugador` (
  `id_jugador` int(4) NOT NULL,
  `id_partida` int(4) NOT NULL,
  `puntaje` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `partida_jugador`
--

INSERT INTO `partida_jugador` (`id_jugador`, `id_partida`, `puntaje`) VALUES
(1, 5, 0),
(1, 6, 0),
(1, 7, 0),
(1, 8, 0),
(1, 9, 0),
(1, 10, 0),
(1, 11, 0),
(1, 12, 0),
(1, 13, 0),
(1, 14, 0),
(2, 5, 0),
(2, 6, 0),
(2, 11, 0),
(2, 12, 0),
(2, 13, 0),
(2, 14, 0),
(3, 7, 0),
(3, 10, 0),
(5, 8, 0),
(5, 9, 0),
(5, 10, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ronda`
--

CREATE TABLE `ronda` (
  `id_ronda` int(1) NOT NULL,
  `nro_ronda` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ronda`
--

INSERT INTO `ronda` (`id_ronda`, `nro_ronda`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ronda_partida`
--

CREATE TABLE `ronda_partida` (
  `id_ronda` int(2) NOT NULL,
  `id_partida` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ronda_partida`
--

INSERT INTO `ronda_partida` (`id_ronda`, `id_partida`) VALUES
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tablero`
--

CREATE TABLE `tablero` (
  `id_tablero` int(4) NOT NULL,
  `nro_tablero` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tablero`
--

INSERT INTO `tablero` (`id_tablero`, `nro_tablero`) VALUES
(2, 1),
(3, 2),
(4, 1),
(5, 2),
(6, 1),
(7, 2),
(8, 1),
(9, 2),
(10, 1),
(11, 2),
(12, 1),
(13, 2),
(14, 3),
(15, 1),
(16, 2),
(17, 3),
(18, 1),
(19, 2),
(20, 3),
(21, 1),
(22, 2),
(23, 1),
(24, 2),
(25, 1),
(26, 2),
(27, 1),
(28, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tablero_partida_jugador`
--

CREATE TABLE `tablero_partida_jugador` (
  `id_tablero` int(4) NOT NULL,
  `id_partida` int(4) NOT NULL,
  `id_jugador` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tablero_partida_jugador`
--

INSERT INTO `tablero_partida_jugador` (`id_tablero`, `id_partida`, `id_jugador`) VALUES
(6, 5, 2),
(7, 5, 1),
(8, 6, 2),
(9, 6, 1),
(10, 7, 3),
(11, 7, 1),
(12, 8, 5),
(13, 8, 1),
(15, 9, 5),
(16, 9, 1),
(18, 10, 5),
(19, 10, 1),
(20, 10, 3),
(21, 11, 2),
(22, 11, 1),
(23, 12, 2),
(24, 12, 1),
(25, 13, 2),
(26, 13, 1),
(27, 14, 2),
(28, 14, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno`
--

CREATE TABLE `turno` (
  `id_turno` int(2) NOT NULL,
  `nro_turno` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `turno`
--

INSERT INTO `turno` (`id_turno`, `nro_turno`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno_partida_jugador`
--

CREATE TABLE `turno_partida_jugador` (
  `id_turno` int(2) NOT NULL,
  `id_partida` int(4) NOT NULL,
  `id_jugador` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `turno_partida_jugador`
--

INSERT INTO `turno_partida_jugador` (`id_turno`, `id_partida`, `id_jugador`) VALUES
(1, 5, 1),
(1, 5, 2),
(1, 6, 1),
(1, 6, 2),
(1, 7, 1),
(1, 7, 3),
(1, 8, 1),
(1, 8, 5),
(1, 9, 1),
(1, 9, 5),
(1, 10, 1),
(1, 10, 3),
(1, 10, 5),
(1, 11, 1),
(1, 11, 2),
(1, 12, 1),
(1, 12, 2),
(1, 13, 1),
(1, 13, 2),
(1, 14, 1),
(1, 14, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno_ronda`
--

CREATE TABLE `turno_ronda` (
  `id_turno` int(2) NOT NULL,
  `id_ronda` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `turno_ronda`
--

INSERT INTO `turno_ronda` (`id_turno`, `id_ronda`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2);

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zona_tablero`
--

CREATE TABLE `zona_tablero` (
  `id_zona` int(1) NOT NULL,
  `id_tablero` int(4) NOT NULL,
  `zona_puntos` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `dinosaurio`
--
ALTER TABLE `dinosaurio`
  ADD PRIMARY KEY (`id_dinosaurio`),
  ADD KEY `fk_dino_zona` (`id_zona`);

--
-- Indices de la tabla `dinosaurio_especie`
--
ALTER TABLE `dinosaurio_especie`
  ADD PRIMARY KEY (`id_dinosaurio`,`id_especie`),
  ADD KEY `fk_de_especie` (`id_especie`);

--
-- Indices de la tabla `dinosaurio_partida_jugador`
--
ALTER TABLE `dinosaurio_partida_jugador`
  ADD PRIMARY KEY (`id_dinosaurio`),
  ADD KEY `fk_dpj_partida` (`id_partida`),
  ADD KEY `fk_dpj_jugador` (`id_jugador`);

--
-- Indices de la tabla `especie`
--
ALTER TABLE `especie`
  ADD PRIMARY KEY (`id_especie`),
  ADD UNIQUE KEY `nombre_especie` (`nombre_especie`),
  ADD UNIQUE KEY `color` (`color`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `fecha_partida`
--
ALTER TABLE `fecha_partida`
  ADD PRIMARY KEY (`id_partida`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`id_jugador`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD UNIQUE KEY `celular` (`celular`);

--
-- Indices de la tabla `modo_juego`
--
ALTER TABLE `modo_juego`
  ADD PRIMARY KEY (`id_modo`);

--
-- Indices de la tabla `nacimiento_jugador`
--
ALTER TABLE `nacimiento_jugador`
  ADD PRIMARY KEY (`id_jugador`);

--
-- Indices de la tabla `partida`
--
ALTER TABLE `partida`
  ADD PRIMARY KEY (`id_partida`),
  ADD KEY `fk_partida_modo` (`id_modo`),
  ADD KEY `fk_partida_estado` (`id_estado`),
  ADD KEY `fk_partida_ganador` (`ganador`);

--
-- Indices de la tabla `partida_jugador`
--
ALTER TABLE `partida_jugador`
  ADD PRIMARY KEY (`id_jugador`,`id_partida`),
  ADD KEY `fk_pj_partida` (`id_partida`);

--
-- Indices de la tabla `ronda`
--
ALTER TABLE `ronda`
  ADD PRIMARY KEY (`id_ronda`);

--
-- Indices de la tabla `ronda_partida`
--
ALTER TABLE `ronda_partida`
  ADD PRIMARY KEY (`id_ronda`,`id_partida`),
  ADD KEY `fk_rp_partida` (`id_partida`);

--
-- Indices de la tabla `tablero`
--
ALTER TABLE `tablero`
  ADD PRIMARY KEY (`id_tablero`);

--
-- Indices de la tabla `tablero_partida_jugador`
--
ALTER TABLE `tablero_partida_jugador`
  ADD PRIMARY KEY (`id_tablero`),
  ADD KEY `fk_tapj_partida` (`id_partida`),
  ADD KEY `fk_tapj_jugador` (`id_jugador`);

--
-- Indices de la tabla `turno`
--
ALTER TABLE `turno`
  ADD PRIMARY KEY (`id_turno`);

--
-- Indices de la tabla `turno_partida_jugador`
--
ALTER TABLE `turno_partida_jugador`
  ADD PRIMARY KEY (`id_turno`,`id_partida`,`id_jugador`),
  ADD KEY `fk_tpj_partida` (`id_partida`),
  ADD KEY `fk_tpj_jugador` (`id_jugador`);

--
-- Indices de la tabla `turno_ronda`
--
ALTER TABLE `turno_ronda`
  ADD PRIMARY KEY (`id_turno`),
  ADD KEY `fk_tr_ronda` (`id_ronda`);

--
-- Indices de la tabla `zona`
--
ALTER TABLE `zona`
  ADD PRIMARY KEY (`id_zona`);

--
-- Indices de la tabla `zona_tablero`
--
ALTER TABLE `zona_tablero`
  ADD PRIMARY KEY (`id_zona`,`id_tablero`),
  ADD KEY `fk_zt_tablero` (`id_tablero`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `dinosaurio`
--
ALTER TABLE `dinosaurio`
  MODIFY `id_dinosaurio` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `especie`
--
ALTER TABLE `especie`
  MODIFY `id_especie` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `id_estado` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `jugador`
--
ALTER TABLE `jugador`
  MODIFY `id_jugador` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `modo_juego`
--
ALTER TABLE `modo_juego`
  MODIFY `id_modo` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `partida`
--
ALTER TABLE `partida`
  MODIFY `id_partida` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `ronda`
--
ALTER TABLE `ronda`
  MODIFY `id_ronda` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tablero`
--
ALTER TABLE `tablero`
  MODIFY `id_tablero` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `turno`
--
ALTER TABLE `turno`
  MODIFY `id_turno` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `zona`
--
ALTER TABLE `zona`
  MODIFY `id_zona` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `dinosaurio`
--
ALTER TABLE `dinosaurio`
  ADD CONSTRAINT `fk_dino_zona` FOREIGN KEY (`id_zona`) REFERENCES `zona` (`id_zona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `dinosaurio_especie`
--
ALTER TABLE `dinosaurio_especie`
  ADD CONSTRAINT `fk_de_dinosaurio` FOREIGN KEY (`id_dinosaurio`) REFERENCES `dinosaurio` (`id_dinosaurio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_de_especie` FOREIGN KEY (`id_especie`) REFERENCES `especie` (`id_especie`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `dinosaurio_partida_jugador`
--
ALTER TABLE `dinosaurio_partida_jugador`
  ADD CONSTRAINT `fk_dpj_dinosaurio` FOREIGN KEY (`id_dinosaurio`) REFERENCES `dinosaurio` (`id_dinosaurio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dpj_jugador` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dpj_partida` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `fecha_partida`
--
ALTER TABLE `fecha_partida`
  ADD CONSTRAINT `fk_fecha_partida` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `nacimiento_jugador`
--
ALTER TABLE `nacimiento_jugador`
  ADD CONSTRAINT `fk_Nacimiento_Jugador` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `partida`
--
ALTER TABLE `partida`
  ADD CONSTRAINT `fk_partida_estado` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id_estado`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_partida_ganador` FOREIGN KEY (`ganador`) REFERENCES `jugador` (`id_jugador`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_partida_modo` FOREIGN KEY (`id_modo`) REFERENCES `modo_juego` (`id_modo`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `partida_jugador`
--
ALTER TABLE `partida_jugador`
  ADD CONSTRAINT `fk_pj_jugador` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pj_partida` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ronda_partida`
--
ALTER TABLE `ronda_partida`
  ADD CONSTRAINT `fk_rp_partida` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rp_ronda` FOREIGN KEY (`id_ronda`) REFERENCES `ronda` (`id_ronda`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tablero_partida_jugador`
--
ALTER TABLE `tablero_partida_jugador`
  ADD CONSTRAINT `fk_tapj_jugador` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tapj_partida` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tapj_tablero` FOREIGN KEY (`id_tablero`) REFERENCES `tablero` (`id_tablero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `turno_partida_jugador`
--
ALTER TABLE `turno_partida_jugador`
  ADD CONSTRAINT `fk_tpj_jugador` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id_jugador`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tpj_partida` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tpj_turno` FOREIGN KEY (`id_turno`) REFERENCES `turno` (`id_turno`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `turno_ronda`
--
ALTER TABLE `turno_ronda`
  ADD CONSTRAINT `fk_tr_ronda` FOREIGN KEY (`id_ronda`) REFERENCES `ronda` (`id_ronda`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tr_turno` FOREIGN KEY (`id_turno`) REFERENCES `turno` (`id_turno`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `zona_tablero`
--
ALTER TABLE `zona_tablero`
  ADD CONSTRAINT `fk_zt_tablero` FOREIGN KEY (`id_tablero`) REFERENCES `tablero` (`id_tablero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_zt_zona` FOREIGN KEY (`id_zona`) REFERENCES `zona` (`id_zona`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
