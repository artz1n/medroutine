
DROP DATABASE IF EXISTS medroutine;
CREATE DATABASE medroutine
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE medroutine;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    senha      VARCHAR(100) NOT NULL
);

CREATE TABLE medicamento (
    id_medicamento      INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario          INT NOT NULL,
    nome                VARCHAR(100) NOT NULL,
    dosagem             VARCHAR(20)  NOT NULL,
    unidade             VARCHAR(20)  NOT NULL,
    quantidade_por_dose INT NOT NULL DEFAULT 1,
    estoque_atual       INT NOT NULL,
    estoque_total       INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);

CREATE TABLE horario (
    id_horario     INT AUTO_INCREMENT PRIMARY KEY,
    id_medicamento INT NOT NULL,
    hora           TIME NOT NULL,
    FOREIGN KEY (id_medicamento) REFERENCES medicamento (id_medicamento)
);

-- Dados de teste
INSERT INTO usuario (nome, email, senha)
VALUES ('Marina Souza', 'marina@exemplo.com', '123456');

INSERT INTO medicamento (id_usuario, nome, dosagem, unidade, quantidade_por_dose, estoque_atual, estoque_total)
VALUES (1, 'Losartana',  '50 mg',    'comprimido', 1, 12, 60),
       (1, 'Metformina', '850 mg',   'comprimido', 1, 40, 60),
       (1, 'Vitamina D', '2.000 UI', 'capsula',    1, 25, 30);

INSERT INTO horario (id_medicamento, hora) VALUES
       (1, '08:00:00'),
       (2, '08:00:00'),
       (2, '20:00:00'),
       (3, '14:00:00');

-- Consulta de conferência
SELECT m.nome, m.dosagem, m.estoque_atual, m.estoque_total,
       GROUP_CONCAT(TIME_FORMAT(h.hora, '%H:%i') ORDER BY h.hora SEPARATOR ', ') AS horarios
FROM medicamento m
LEFT JOIN horario h ON h.id_medicamento = m.id_medicamento
GROUP BY m.id_medicamento;
