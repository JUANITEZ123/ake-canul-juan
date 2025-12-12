CREATE DATABASE Hospital;
USE Hospital;

CREATE TABLE `pacientes` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) UNIQUE NOT NULL,
  `edad` int,
  `sexo` char(1)
);

CREATE TABLE `doctores` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `enfermeras` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `especialidades` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `doctor_especialidad` (
  `doctor_id` int NOT NULL,
  `especialidad_id` int NOT NULL
);

CREATE TABLE `medicinas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `paciente_medicina` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `paciente_id` int NOT NULL,
  `medicina_id` int NOT NULL,
  `dosis` varchar(255) NOT NULL,
  `frecuencia` varchar(255) NOT NULL
);

CREATE TABLE `paciente_medicina_horario` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `paciente_medicina_id` int NOT NULL,
  `hora` time NOT NULL
);

CREATE TABLE `paciente_doctor` (
  `paciente_id` int NOT NULL,
  `doctor_id` int NOT NULL
);

CREATE TABLE `paciente_enfermera` (
  `paciente_id` int NOT NULL,
  `enfermera_id` int NOT NULL
);

CREATE TABLE `contactos_emergencia` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `paciente_id` int NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(255),
  `relacion` varchar(255)
);

CREATE TABLE `companias_seguro` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `polizas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `compania_id` int NOT NULL,
  `plan` varchar(255) NOT NULL,
  `copago` decimal(10,2) DEFAULT 0
);

CREATE TABLE `paciente_poliza` (
  `paciente_id` int NOT NULL,
  `poliza_id` int NOT NULL
);

CREATE TABLE `facturas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(255) UNIQUE NOT NULL,
  `paciente_id` int NOT NULL,
  `poliza_id` int,
  `monto_total` decimal(10,2) NOT NULL,
  `fecha` date
);

CREATE TABLE `pagos` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `factura_id` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha` date NOT NULL,
  `metodo` varchar(255)
);

CREATE UNIQUE INDEX `doctor_especialidad_index_0` ON `doctor_especialidad` (`doctor_id`, `especialidad_id`);

CREATE UNIQUE INDEX `paciente_medicina_index_1` ON `paciente_medicina` (`paciente_id`, `medicina_id`);

CREATE UNIQUE INDEX `paciente_medicina_horario_index_2` ON `paciente_medicina_horario` (`paciente_medicina_id`, `hora`);

CREATE UNIQUE INDEX `paciente_doctor_index_3` ON `paciente_doctor` (`paciente_id`, `doctor_id`);

CREATE UNIQUE INDEX `paciente_enfermera_index_4` ON `paciente_enfermera` (`paciente_id`, `enfermera_id`);

CREATE UNIQUE INDEX `polizas_index_5` ON `polizas` (`compania_id`, `plan`);

CREATE UNIQUE INDEX `paciente_poliza_index_6` ON `paciente_poliza` (`paciente_id`, `poliza_id`);

ALTER TABLE `doctor_especialidad` ADD FOREIGN KEY (`doctor_id`) REFERENCES `doctores` (`id`);

ALTER TABLE `doctor_especialidad` ADD FOREIGN KEY (`especialidad_id`) REFERENCES `especialidades` (`id`);

ALTER TABLE `paciente_medicina` ADD FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`);

ALTER TABLE `paciente_medicina` ADD FOREIGN KEY (`medicina_id`) REFERENCES `medicinas` (`id`);

ALTER TABLE `paciente_medicina_horario` ADD FOREIGN KEY (`paciente_medicina_id`) REFERENCES `paciente_medicina` (`id`);

ALTER TABLE `paciente_doctor` ADD FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`);

ALTER TABLE `paciente_doctor` ADD FOREIGN KEY (`doctor_id`) REFERENCES `doctores` (`id`);

ALTER TABLE `paciente_enfermera` ADD FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`);

ALTER TABLE `paciente_enfermera` ADD FOREIGN KEY (`enfermera_id`) REFERENCES `enfermeras` (`id`);

ALTER TABLE `contactos_emergencia` ADD FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`);

ALTER TABLE `polizas` ADD FOREIGN KEY (`compania_id`) REFERENCES `companias_seguro` (`id`);

ALTER TABLE `paciente_poliza` ADD FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`);

ALTER TABLE `paciente_poliza` ADD FOREIGN KEY (`poliza_id`) REFERENCES `polizas` (`id`);

ALTER TABLE `facturas` ADD FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`);

ALTER TABLE `facturas` ADD FOREIGN KEY (`poliza_id`) REFERENCES `polizas` (`id`);

ALTER TABLE `pagos` ADD FOREIGN KEY (`factura_id`) REFERENCES `facturas` (`id`);
