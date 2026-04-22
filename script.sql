DROP DATABASE IF EXISTS pilates;
CREATE DATABASE pilates;
USE pilates;

CREATE TABLE usuario (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         nome VARCHAR(100) NOT NULL,
                         email VARCHAR(100) NOT NULL,
                         senha VARCHAR(100) NOT NULL
);

CREATE TABLE professor (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           nome VARCHAR(100) NOT NULL,
                           telefone VARCHAR(20),
                           ativo BOOLEAN,
                           email VARCHAR(100)
);

CREATE TABLE aluno (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       nome VARCHAR(100) NOT NULL,
                       telefone VARCHAR(20),
                       cpf VARCHAR(11) UNIQUE,
                       email VARCHAR(100),
                       ficha_anamnese VARCHAR(255),
                       ativo BOOLEAN DEFAULT TRUE,
                       data_nascimento DATE,
                       data_cadastro DATE
);

CREATE TABLE plano (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       nome VARCHAR(50),
                       frequencia_semanal INT,
                       validade_dias INT,
                       valor_mensal DECIMAL(8,2)
);

CREATE TABLE aluno_plano (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             aluno_id INT,
                             plano_id INT,
                             data_inicio DATE,
                             data_fim DATE,
                             ativo BOOLEAN DEFAULT TRUE,
                             FOREIGN KEY (aluno_id) REFERENCES aluno(id),
                             FOREIGN KEY (plano_id) REFERENCES plano(id)
);

CREATE TABLE turma (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       dia_semana VARCHAR(20) NOT NULL,
                       hora_inicio TIME NOT NULL,
                       duracao_minutos INT DEFAULT 60,
                       capacidade_max INT,
                       ativa BOOLEAN DEFAULT TRUE,
                       professor_id INT,
                       FOREIGN KEY (professor_id) REFERENCES professor(id)
);

CREATE TABLE aluno_turma (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             aluno_id INT,
                             turma_id INT,
                             data_inicio DATE,
                             ativo BOOLEAN DEFAULT TRUE,
                             FOREIGN KEY (aluno_id) REFERENCES aluno(id),
                             FOREIGN KEY (turma_id) REFERENCES turma(id)
);

CREATE TABLE aula (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      turma_id INT,
                      data_aula DATE NOT NULL,
                      marcada BOOLEAN DEFAULT TRUE,
                      FOREIGN KEY (turma_id) REFERENCES turma(id)
);

CREATE TABLE aula_aluno (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            aula_id INT,
                            aluno_id INT,
                            status VARCHAR(20) DEFAULT 'AGENDADO',
                            aula_origem_id INT NULL,
                            FOREIGN KEY (aula_id) REFERENCES aula(id),
                            FOREIGN KEY (aluno_id) REFERENCES aluno(id),
                            FOREIGN KEY (aula_origem_id) REFERENCES aula(id)
);
INSERT INTO professor (nome, telefone, email)
VALUES ('Thais Almeida','11988887777','thais@pilates.com');

INSERT INTO aluno (nome, telefone, cpf, email, data_nascimento, data_cadastro, ficha_anamnese)
VALUES
    ('Bruno Silva','11999990000','12345678901','bruno@email.com','2003-04-12','2026-03-01', 'aa'),
    ('Isabella Chagas','11988881111','98765432100','ana@email.com','2002-09-17','2026-03-01', 'aa');

INSERT INTO plano (nome, frequencia_semanal, validade_dias, valor_mensal)
VALUES
    ('2x por semana',2,30,290.10),
    ('3x por semana',3,30,390.10);

INSERT INTO turma (dia_semana, hora_inicio, capacidade_max, professor_id)
VALUES
    ('SEGUNDA','10:00',5,1),
    ('QUARTA','10:00',5,1),
    ('SEXTA','10:00',5,1);

INSERT INTO aluno_plano (aluno_id, plano_id, data_inicio, data_fim)
VALUES (1,1,'2026-03-01','2026-03-31');

INSERT INTO aluno_turma (aluno_id, turma_id, data_inicio)
VALUES (1,1,'2026-03-01'),(1,2,'2026-03-01');

INSERT INTO aula (turma_id,data_aula)
VALUES
    (1,'2026-03-02'),(1,'2026-03-09'),(1,'2026-03-16'),(1,'2026-03-23'),(1,'2026-03-30'),
    (2,'2026-03-04'),(2,'2026-03-11'),(2,'2026-03-18'),(2,'2026-03-25'),
    (3,'2026-03-14');

INSERT INTO aula_aluno (aula_id,aluno_id,status)
VALUES
    (1,1,'AUSENTE'), (2,1,'AUSENTE'), (3,1,'AGENDADO'), (4,1,'AGENDADO'),
    (5,1,'AGENDADO'), (6,1,'AGENDADO'), (7,1,'AGENDADO'), (8,1,'AGENDADO'),
    (9,1,'AGENDADO'), (10,1,'REPOSICAO'), (6,1,'REPOSICAO');
SELECT a.nome, t.dia_semana, t.hora_inicio
FROM aluno_turma at
INNER JOIN aluno a ON at.aluno_id = a.id
    INNER JOIN turma t ON at.turma_id = t.id
WHERE t.id = 1;
SELECT *
FROM aula au
         INNER JOIN aula_aluno aa ON au.id = aa.aula_id
         INNER JOIN aluno al ON aa.aluno_id = al.id;
SELECT
    a_origem.data_aula AS aula_faltada,
    a_destino.data_aula AS aula_reposicao,
    aa.status
FROM aula_aluno aa
         JOIN aula a_destino ON aa.aula_id = a_destino.id
         LEFT JOIN aula a_origem ON aa.aula_origem_id = a_origem.id
WHERE aa.aluno_id = 1
  AND aa.status = 'REPOSICAO'
  AND a_destino.data_aula BETWEEN '2026-03-01' AND '2026-03-31'
ORDER BY a_destino.data_aula;