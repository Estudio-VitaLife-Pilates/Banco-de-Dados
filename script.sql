DROP DATABASE IF EXISTS pilates;
CREATE DATABASE pilates;
USE pilates;


CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, 
    senha VARCHAR(255) NOT NULL        
);



CREATE TABLE professor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    ativo BOOLEAN DEFAULT TRUE,
    email VARCHAR(100),
    criado_por_usuario_id INT,
    atualizado_por_usuario_id INT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (criado_por_usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (atualizado_por_usuario_id) REFERENCES usuario(id)
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
    data_cadastro DATE,
    criado_por_usuario_id INT,
    atualizado_por_usuario_id INT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (criado_por_usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (atualizado_por_usuario_id) REFERENCES usuario(id)
);

CREATE TABLE plano (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    frequencia_semanal INT,
    validade_dias INT,
    valor_mensal DECIMAL(8,2),
    criado_por_usuario_id INT,
    atualizado_por_usuario_id INT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (criado_por_usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (atualizado_por_usuario_id) REFERENCES usuario(id)
);

CREATE TABLE aluno_plano (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT,
    plano_id INT,
    data_inicio DATE,
    data_fim DATE,
    ativo BOOLEAN DEFAULT TRUE,
    criado_por_usuario_id INT,
    atualizado_por_usuario_id INT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (aluno_id) REFERENCES aluno(id),
    FOREIGN KEY (plano_id) REFERENCES plano(id),
    FOREIGN KEY (criado_por_usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (atualizado_por_usuario_id) REFERENCES usuario(id)
);

CREATE TABLE turma (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dia_semana VARCHAR(20) NOT NULL,
    hora_inicio TIME NOT NULL,
    duracao_minutos INT DEFAULT 60,
    capacidade_max INT,
    ativa BOOLEAN DEFAULT TRUE,
    criado_por_usuario_id INT,
    atualizado_por_usuario_id INT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (criado_por_usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (atualizado_por_usuario_id) REFERENCES usuario(id)
);

CREATE TABLE aluno_turma (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT,
    turma_id INT,
    data_inicio DATE,
    ativo BOOLEAN DEFAULT TRUE,
    criado_por_usuario_id INT,
    atualizado_por_usuario_id INT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (aluno_id) REFERENCES aluno(id),
    FOREIGN KEY (turma_id) REFERENCES turma(id),
    FOREIGN KEY (criado_por_usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (atualizado_por_usuario_id) REFERENCES usuario(id)
);

CREATE TABLE aula (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT,
    professor_id INT,
    data_aula DATE NOT NULL,
    marcada BOOLEAN DEFAULT TRUE,
    criado_por_usuario_id INT,
    atualizado_por_usuario_id INT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (turma_id) REFERENCES turma(id),
    FOREIGN KEY (professor_id) REFERENCES professor(id),
    FOREIGN KEY (criado_por_usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (atualizado_por_usuario_id) REFERENCES usuario(id)
);

CREATE TABLE aula_aluno (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aula_id INT,
    aluno_id INT,
    status VARCHAR(20) DEFAULT 'AGENDADO',
    aula_origem_id INT NULL,
    criado_por_usuario_id INT,
    atualizado_por_usuario_id INT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (aula_id) REFERENCES aula(id),
    FOREIGN KEY (aluno_id) REFERENCES aluno(id),
    FOREIGN KEY (aula_origem_id) REFERENCES aula(id),
    FOREIGN KEY (criado_por_usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (atualizado_por_usuario_id) REFERENCES usuario(id)
);

=

INSERT INTO usuario (nome, email, senha)
VALUES 
    (' Camila', 'camila@pilates.com', '1234'),
    (' Rodrigo', 'rodrigo@pilates.com', '1234');

-- 2. Cadastros feitos pela Atendente Camila (usuario_id = 1)
INSERT INTO professor (nome, telefone, email, criado_por_usuario_id)
VALUES ('Thais Almeida','11988887777','thais@pilates.com', 1);

INSERT INTO aluno (nome, telefone, cpf, email, data_nascimento, data_cadastro, ficha_anamnese, criado_por_usuario_id)
VALUES
    ('Bruno Silva','11999990000','12345678901','bruno@email.com','2003-04-12','2026-03-01', 'aa', 1),
    ('Isabella Chagas','11988881111','98765432100','ana@email.com','2002-09-17','2026-03-01', 'aa', 1);

-- 3. Cadastros de planos feitos pelo Gerente Rodrigo (usuario_id = 2)
INSERT INTO plano (nome, frequencia_semanal, validade_dias, valor_mensal, criado_por_usuario_id)
VALUES
    ('2x por semana',2,30,290.10, 2),
    ('3x por semana',3,30,390.10, 2);

INSERT INTO turma (dia_semana, hora_inicio, capacidade_max, criado_por_usuario_id)
VALUES
    ('SEGUNDA','10:00',5, 2),
    ('QUARTA','10:00',5, 2),
    ('SEXTA','10:00',5, 2);

-- 4. Vinculações feitas pela Atendente Camila (usuario_id = 1)
INSERT INTO aluno_plano (aluno_id, plano_id, data_inicio, data_fim, criado_por_usuario_id)
VALUES (1,1,'2026-03-01','2026-03-31', 1);

INSERT INTO aluno_turma (aluno_id, turma_id, data_inicio, criado_por_usuario_id)
VALUES (1,1,'2026-03-01', 1),(1,2,'2026-03-01', 1);

INSERT INTO aula (turma_id, professor_id, data_aula, criado_por_usuario_id)
VALUES
    (1,1,'2026-03-02', 1),(1,1,'2026-03-09', 1),(1,1,'2026-03-16', 1),(1,1,'2026-03-23', 1),(1,1,'2026-03-30', 1),
    (2,1,'2026-03-04', 1),(2,1,'2026-03-11', 1),(2,1,'2026-03-18', 1),(2,1,'2026-03-25', 1),
    (3,1,'2026-03-14', 1);

INSERT INTO aula_aluno (aula_id,aluno_id,status, criado_por_usuario_id)
VALUES
    (1,1,'AUSENTE', 1), (2,1,'AUSENTE', 1), (3,1,'AGENDADO', 1), (4,1,'AGENDADO', 1),
    (5,1,'AGENDADO', 1), (6,1,'AGENDADO', 1), (7,1,'AGENDADO', 1), (8,1,'AGENDADO', 1),
    (9,1,'AGENDADO', 1), (10,1,'REPOSICAO', 1), (6,1,'REPOSICAO', 1);
    
    -- QUERIES

-- alunos da turma
SELECT a.nome, t.dia_semana, t.hora_inicio
FROM aluno_turma at
INNER JOIN aluno a ON at.aluno_id = a.id
INNER JOIN turma t ON at.turma_id = t.id
WHERE t.id = 1;

-- aulas com alunos
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

-- aula + professor + turma
SELECT 
    au.data_aula,
    p.nome AS professor,
    t.dia_semana,
    t.hora_inicio
FROM aula au
JOIN professor p ON au.professor_id = p.id
JOIN turma t ON au.turma_id = t.id;
