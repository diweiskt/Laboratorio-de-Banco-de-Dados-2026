-- =========================
-- TABELA MEDICO
-- =========================
CREATE TABLE MEDICO (
    id_medico        NUMBER(10) PRIMARY KEY,
    nome             VARCHAR2(50) NOT NULL,
    crm              VARCHAR2(10) UNIQUE NOT NULL,
    telefone         VARCHAR2(15)
);

-- =========================
-- TABELA ESPECIALIDADE
-- =========================
CREATE TABLE ESPECIALIDADE (
    id_especialidade NUMBER(10) PRIMARY KEY,
    nome             VARCHAR2(50) NOT NULL,
    ch               NUMBER(4)   -- carga horária
);

-- =========================
-- TABELA MEDICO_ESPECIALIDADE
-- (Relacionamento N:N)
-- =========================
CREATE TABLE MEDICO_ESPECIALIDADE (
    id_medico        NUMBER(10),
    id_especialidade NUMBER(10),
    dataConclusao    DATE,

    CONSTRAINT pk_medico_especialidade 
        PRIMARY KEY (id_medico, id_especialidade),

    CONSTRAINT fk_me_medico 
        FOREIGN KEY (id_medico)
        REFERENCES MEDICO(id_medico),

    CONSTRAINT fk_me_especialidade 
        FOREIGN KEY (id_especialidade)
        REFERENCES ESPECIALIDADE(id_especialidade)
);

-- =========================
-- TABELA PACIENTE
-- =========================
CREATE TABLE PACIENTE (
    id_paciente NUMBER(10) PRIMARY KEY,
    nome        VARCHAR2(50) NOT NULL,
    cpf         VARCHAR2(14) UNIQUE NOT NULL,
    telefone    VARCHAR2(15),
    endereco    VARCHAR2(100),
    sexo        CHAR(1)
);

-- =========================
-- TABELA CONSULTA
-- =========================
CREATE TABLE CONSULTA (
    id_consulta NUMBER(10) PRIMARY KEY,
    data        DATE NOT NULL,
    hora        VARCHAR2(5) NOT NULL,
    status      VARCHAR2(20) CHECK (status IN ('agendada','realizada','cancelada')),
    valor       NUMBER(10,2),
    obs         VARCHAR2(200),

    id_paciente NUMBER(10) NOT NULL,
    id_medico   NUMBER(10) NOT NULL,

    CONSTRAINT fk_consulta_paciente 
        FOREIGN KEY (id_paciente)
        REFERENCES PACIENTE(id_paciente),

    CONSTRAINT fk_consulta_medico 
        FOREIGN KEY (id_medico)
        REFERENCES MEDICO(id_medico)
);

-- =========================
-- TABELA PROCEDIMENTO
-- =========================
CREATE TABLE PROCEDIMENTO (
    id_procedimento NUMBER(10) PRIMARY KEY,
    nome_procd      VARCHAR2(100) NOT NULL,
    descricao       VARCHAR2(200),
    valor_procd     NUMBER(10,2),
    id_consulta     NUMBER(10) NOT NULL,

    CONSTRAINT fk_procedimento_consulta 
        FOREIGN KEY (id_consulta)
        REFERENCES CONSULTA(id_consulta)
);

-- =========================
-- TABELA PAGAMENTO
-- =========================
CREATE TABLE PAGAMENTO (
    id_pagamento NUMBER(10) PRIMARY KEY,
    forma_pagto  VARCHAR2(20) CHECK (forma_pagto IN ('dinheiro','cartao','pix','boleto')),
    data_pagto   DATE NOT NULL,
    valor_pagto  NUMBER(10,2) NOT NULL,

    id_consulta  NUMBER(10) NOT NULL,

    CONSTRAINT fk_pagamento_consulta 
        FOREIGN KEY (id_consulta)
        REFERENCES CONSULTA(id_consulta)
);

-- ====== Carga de Dados ======

INSERT INTO MEDICO VALUES (1, 'Dr. Carlos Silva', 'CRM12345', '11999990001');
INSERT INTO MEDICO VALUES (2, 'Dra. Ana Souza', 'CRM23456', '11999990002');
INSERT INTO MEDICO VALUES (3, 'Dr. Paulo Mendes', 'CRM34567', '11999990003');
INSERT INTO MEDICO VALUES (4, 'Dra. Fernanda Lima', 'CRM45678', '11999990004');
INSERT INTO MEDICO VALUES (5, 'Dr. Ricardo Alves', 'CRM56789', '11999990005');

INSERT INTO ESPECIALIDADE VALUES (1, 'Cardiologia', 360);
INSERT INTO ESPECIALIDADE VALUES (2, 'Dermatologia', 240);
INSERT INTO ESPECIALIDADE VALUES (3, 'Ortopedia', 400);
INSERT INTO ESPECIALIDADE VALUES (4, 'Pediatria', 380);
INSERT INTO ESPECIALIDADE VALUES (5, 'Ginecologia', 350);


INSERT INTO MEDICO_ESPECIALIDADE VALUES (1, 1, TO_DATE('10/01/2015','DD/MM/YYYY'));
INSERT INTO MEDICO_ESPECIALIDADE VALUES (2, 2, TO_DATE('15/03/2016','DD/MM/YYYY'));
INSERT INTO MEDICO_ESPECIALIDADE VALUES (1, 3, TO_DATE('20/07/2014','DD/MM/YYYY'));
INSERT INTO MEDICO_ESPECIALIDADE VALUES (4, 4, TO_DATE('05/09/2018','DD/MM/YYYY'));
INSERT INTO MEDICO_ESPECIALIDADE VALUES (2, 5, '12/11/2017');

INSERT INTO PACIENTE VALUES (1, 'João Pereira', '123.456.789-00', '11988880001', 'Rua A, 123', 'M');
INSERT INTO PACIENTE VALUES (2, 'Maria Oliveira', '234.567.890-11', '11988880002', 'Rua B, 456', 'F');
INSERT INTO PACIENTE(id_paciente,nome,cpf,telefone,sexo) VALUES (3, 'Lucas Martins', '345.678.901-22', '11988880003', 'M');
INSERT INTO PACIENTE(id_paciente,nome,cpf,telefone,sexo) VALUES (4, 'Carla Santos', '456.789.012-33', '11988880004', 'F');
INSERT INTO PACIENTE VALUES (5, 'Pedro Costa', '567.890.123-44', '11988880005', 'Rua E, 654', 'M');

INSERT INTO CONSULTA VALUES (1, TO_DATE('01/02/2026','DD/MM/YYYY'), '09:00', 'realizada', 250.00, 'Consulta rotina', 1, 1);
INSERT INTO CONSULTA VALUES (2, TO_DATE('02/02/2026','DD/MM/YYYY'), '10:00', 'agendada', 300.00, 'Avaliação dermatológica', 2, 2);
INSERT INTO CONSULTA VALUES (3, TO_DATE('03/02/2026','DD/MM/YYYY'), '11:00', 'realizada', 400.00, 'Dor no joelho', 3, 3);
INSERT INTO CONSULTA VALUES (4, TO_DATE('04/02/2026','DD/MM/YYYY'), '14:00', 'cancelada', 200.00, 'Consulta pediátrica', 4, 4);
INSERT INTO CONSULTA VALUES (5, TO_DATE('05/02/2026','DD/MM/YYYY'), '15:00', 'realizada', 350.00, 'Exame preventivo', 5, 5);

INSERT INTO PROCEDIMENTO VALUES (1, 'Eletrocardiograma', 'Exame cardíaco', 150.00, 1);
INSERT INTO PROCEDIMENTO VALUES (2, 'Biópsia de Pele', 'Coleta para análise', 200.00, 2);
INSERT INTO PROCEDIMENTO VALUES (3, 'Raio-X Joelho', 'Imagem da articulação', 180.00, 3);
INSERT INTO PROCEDIMENTO VALUES (4, 'Vacinação', 'Aplicação de vacina', 100.00, 4);
INSERT INTO PROCEDIMENTO VALUES (5, 'Ultrassonografia', 'Exame ginecológico', 220.00, 5);

INSERT INTO PAGAMENTO VALUES (1, 'pix','01/02/2026', 400.00, 1);
INSERT INTO PAGAMENTO VALUES (2, 'cartao', '02/02/2026', 300.00, 2);
INSERT INTO PAGAMENTO VALUES (3, 'dinheiro','03/02/2026', 580.00, 3);
INSERT INTO PAGAMENTO VALUES (4, 'boleto', '04/02/2026', 200.00, 4);
INSERT INTO PAGAMENTO VALUES (5, 'pix', '05/02/2026', 570.00, 5);

-- ======== Exercicios 1 ========

-- 1 - Listar consultas realizadas após 02/02/2026.
  SELECT * FROM consulta
  WHERE status = 'realizada' and data > '02/02/2026';

-- 2 - Listar consultas com valor entre 250 e 350.
  SELECT * FROM consulta
  WHERE valor BETWEEN 250 AND 350;

-- 3 - Buscar pacientes cujo nome começa com "M".
  SELECT * FROM paciente
  WHERE nome LIKE 'M%';

-- 4 - Listar procedimentos que contenham a palavra "Joelho".
  SELECT * FROM PROCEDIMENTO
  WHERE nome_procd LIKE '%Joelho%';

-- 5 - Listar pagamentos feitos entre 01/02/2026 e 03/02/2026.
  SELECT * FROM pagamento
  WHERE data_pagto >= '01/02/2026' and data_pagto <= '03/02/2026';
-- ou WHERE data_pagto BETWEEN '01/02/2026' AND '03/02/2026';

-- Exemplo do professor
  SELECT count(*),avg(valor),max(valor),min(valor),sum(valor)
  FROM consulta
  
-- 6 - Listar a soma dos pagamentos do ano de 2026.
  SELECT sum(valor_pagto)
  FROM pagamento
  WHERE data_pagto >= '01/01/2026' and
        data_pagto <= '31/12/2026';
--ou
  WHERE extract (year from data_pagto) = 2026;
  
-- 7 - Listar quantas consultas foram realizadas no mês de fevereiro, independente do ano.
  SELECT count(*)
  FROM consulta
  WHERE extract (month from data) = 02 and
        status = 'realizada';
  
-- 8 - Listar os pacientes e médicos de cada uma das consultas
  SELECT paciente.nome, medico.nome
  FROM paciente INNER JOIN consulta ON
       paciente.id_paciente = consulta.id_paciente
       INNER JOIN medico ON medico.id_medico = consulta.id_medico;
  
