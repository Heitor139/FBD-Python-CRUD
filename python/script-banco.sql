DROP TABLE IF EXISTS 
Ficha_Anamnese, Exame, Internacao, Leito, Materiais_Insumos, Medicamento, 
Consulta, Alerta, Mensagens, Horarios_plantao, Medico, 
Profissionais_enfermagem, Departamento, Contatos_emergencia, 
Paciente, Usuario 
CASCADE;

CREATE TABLE Usuario (
  id SERIAL PRIMARY KEY,
  nome VARCHAR NOT NULL,
  login VARCHAR NOT NULL UNIQUE,
  senha VARCHAR NOT NULL,
  permissoes VARCHAR NOT NULL
);

CREATE TABLE Paciente (
  id SERIAL PRIMARY KEY,
  cpf VARCHAR NOT NULL UNIQUE,
  nome VARCHAR NOT NULL,
  sexo VARCHAR NOT NULL,
  data_nascimento DATE NOT NULL,
  rua VARCHAR NOT NULL,
  bairro VARCHAR NOT NULL,
  cidade VARCHAR NOT NULL,
  pais VARCHAR NOT NULL
);

CREATE TABLE Contatos_emergencia (
  id SERIAL PRIMARY KEY,
  numero VARCHAR NOT NULL,
  cpf VARCHAR NOT NULL,
  UNIQUE (cpf, numero),
  FOREIGN KEY (cpf) REFERENCES Paciente(cpf)
);

CREATE TABLE Departamento (
  id SERIAL PRIMARY KEY,
  nome_dep VARCHAR NOT NULL UNIQUE
);

CREATE TABLE Profissionais_enfermagem (
  id SERIAL PRIMARY KEY,
  coren VARCHAR NOT NULL UNIQUE,
  especialidade VARCHAR NOT NULL,
  turno VARCHAR NOT NULL,
  login VARCHAR NOT NULL,
  nome_dep VARCHAR NOT NULL,
  FOREIGN KEY (login) REFERENCES Usuario(login),
  FOREIGN KEY (nome_dep) REFERENCES Departamento(nome_dep)
);

CREATE TABLE Medico (
  id SERIAL PRIMARY KEY,
  crm VARCHAR NOT NULL UNIQUE,
  login VARCHAR NOT NULL,
  nome_dep VARCHAR NOT NULL,
  FOREIGN KEY (login) REFERENCES Usuario(login),
  FOREIGN KEY (nome_dep) REFERENCES Departamento(nome_dep)
);


CREATE TABLE Horarios_plantao (
  id SERIAL PRIMARY KEY,
  horario_inicio INT NOT NULL,
  horario_fim INT NOT NULL,
  data DATE NOT NULL,
  crm VARCHAR NOT NULL,
  login VARCHAR NOT NULL,
  FOREIGN KEY (crm) REFERENCES Medico(crm),
  UNIQUE (data, crm)
);

CREATE TABLE Mensagens (
  id SERIAL PRIMARY KEY,
  data_hora TIMESTAMP NOT NULL,
  descricao VARCHAR NOT NULL,
  login_snd VARCHAR NOT NULL,
  login_rec VARCHAR NOT NULL,
  FOREIGN KEY (login_snd) REFERENCES Usuario(login),
  FOREIGN KEY (login_rec) REFERENCES Usuario(login)
);

CREATE TABLE Alerta (
  id SERIAL PRIMARY KEY,
  prioridade INT NOT NULL,
  data_hora TIMESTAMP NOT NULL,
  evento VARCHAR NOT NULL,
  login_adm VARCHAR NOT NULL,
  FOREIGN KEY (login_adm) REFERENCES Usuario(login)
);

CREATE TABLE Consulta (
  id SERIAL PRIMARY KEY,
  data_requisicao DATE NOT NULL,
  data_hora_consulta TIMESTAMP NOT NULL UNIQUE,
  observacoes VARCHAR,
  diagnostico VARCHAR,
  status VARCHAR NOT NULL,
  especialidade VARCHAR NOT NULL,
  cpf VARCHAR NOT NULL,
  FOREIGN KEY (cpf) REFERENCES Paciente(cpf)
);

CREATE TABLE Medicamento (
  id SERIAL PRIMARY KEY,
  fabricante VARCHAR NOT NULL,
  nome_generico VARCHAR NOT NULL,
  unidades INT NOT NULL,
  data_validade DATE NOT NULL,
  lote VARCHAR NOT NULL,
  crm VARCHAR NOT NULL,
  coren VARCHAR NOT NULL,
  cpf VARCHAR NOT NULL,
  FOREIGN KEY (cpf) REFERENCES Paciente(cpf),
  FOREIGN KEY (coren) REFERENCES Profissionais_enfermagem(coren),
  FOREIGN KEY (crm) REFERENCES Medico(crm)
);

CREATE TABLE Materiais_Insumos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR NOT NULL,
  tipo VARCHAR NOT NULL,
  quantidade INT NOT NULL,
  data_validade DATE NOT NULL,
  fornecedor VARCHAR NOT NULL,
  lote VARCHAR NOT NULL,
  nome_dep VARCHAR NOT NULL,
  FOREIGN KEY (nome_dep) REFERENCES Departamento(nome_dep)
);

CREATE TABLE Leito (
  id SERIAL PRIMARY KEY,
  numero INT NOT NULL UNIQUE,
  tipo VARCHAR NOT NULL
);

CREATE TABLE Internacao (
  id SERIAL PRIMARY KEY,
  data_hora_entrada TIMESTAMP NOT NULL,
  data_hora_saida TIMESTAMP,
  numero INT NOT NULL,
  cpf VARCHAR NOT NULL,
  crm VARCHAR NOT NULL,
  FOREIGN KEY (numero) REFERENCES Leito(numero),
  FOREIGN KEY (cpf) REFERENCES Paciente(cpf),
  FOREIGN KEY (crm) REFERENCES Medico(crm)
);

CREATE TABLE Exame (
  id SERIAL PRIMARY KEY,
  tipo VARCHAR NOT NULL,
  resultado VARCHAR,
  data_hora TIMESTAMP NOT NULL,
  crm VARCHAR NOT NULL,
  cpf VARCHAR NOT NULL,
  FOREIGN KEY (crm) REFERENCES Medico(crm),
  FOREIGN KEY (cpf) REFERENCES Paciente(cpf)
);

CREATE TABLE Ficha_Anamnese (
  id SERIAL PRIMARY KEY,
  cpf VARCHAR NOT NULL,
  data DATE NOT NULL,
  convenio VARCHAR,
  queixa_principal VARCHAR NOT NULL,
  sintomas VARCHAR NOT NULL,
  descricao VARCHAR NOT NULL,
  habitos_de_vida VARCHAR,
  procedimentos VARCHAR,
  FOREIGN KEY (cpf) REFERENCES Paciente(cpf)
);

INSERT INTO Usuario (nome, login, senha, permissoes) VALUES 
('Carol Alves', 'carolalves', 'carol123', 'Administradora'),
('Milena sousa', 'milenasousa', 'milena412', 'Enfermeira'),
('Marta Ribeiro', 'martaribeiro', 'marta789', 'Enfermeira'),
('Ana Clara', 'anaclara', 'ana987', 'Enfermeira'),
('João Pedro', 'joaopedro', 'joao321', 'Enfermeiro'),
('Dr. Felipe Santos', 'felipesantos', 'felipe654', 'Médico'),
('Dr. Ricardo Almeida', 'ricardoalmeida', 'ricardo159', 'Médico'),
('Sofia Nunes', 'sofianunes', 'sofia753', 'Enfermeira');


INSERT INTO Usuario (nome, login, senha, permissoes) VALUES 
('Dr. Pedro Lima', 'pedrolima', 'pedro456', 'Médico'),
('Mariana Costa', 'marianacosta', 'mariana852', 'Enfermeira'),
('Dr. Eduardo Fernandes', 'eduardofernandes', 'eduardo258', 'Médico'),
('Beatriz Silva', 'beatrizsilva', 'beatriz369', 'Enfermeira'),
('Dr. Thiago Rocha', 'thiagorocha', 'thiago963', 'Médico'),
('Fernanda Lima', 'fernandalima', 'fernanda741', 'Enfermeira'),
('Dr. Rafael Moreira', 'rafaelmoreira', 'rafael852', 'Médico'),
('Dr. Gustavo Carvalho', 'gustavocarvalho', 'gustavo456', 'Médico'),
('Larissa Oliveira', 'larissaoliveira', 'larissa753', 'Enfermeira'),
('Marcos da Silva', 'marcosdasilva', 'marcos654', 'Supervisor'),
('Dr. Vinicius Alves', 'viniciusalves', 'vinicius837', 'Médico'),
('Yuri Araujo', 'yuriaraujo', 'yuri625', 'Enfermeiro'),
('Dr. Fabiano Souza', 'fabianosouza', 'fabiano917', 'Médico'),
('Vitória Pereira', 'vitoriapereira', 'vitoria204', 'Enfermeira'),
('Dr. Amanda Martins', 'amandamartins', 'amanda321', 'Médico'),
('Dr. Beatriz Costa', 'beatrizcosta', 'beatriz856', 'Médico'),
('Rafael Gomes', 'rafaelgomes', 'rafael478', 'Enfermeiro'),
('Dr. Lucas Ribeiro', 'lucasribeiro', 'lucas145', 'Médico'),
('Mariana Souza', 'marianasouza', 'mariana369', 'Enfermeira'),
('Thiago Mendes', 'thiagomendes', 'thiago258', 'Enfermeiro'),
('Jorge Costa', 'jorgecosta', 'jorge482', 'Médico'),
('Amanda Nunes', 'amandanunes', 'amanda753', 'Médico'),
('Lucas Nunes', 'lucasnunes', 'lucas159', 'Médico');

INSERT INTO Departamento(nome_dep) VALUES
('Cardiologia'),
('Pronto-Socorro'),
('UTI'),
('Enfermagem'),
('Centro Cirúrgico'),
('Clínica Médica'),
('Pediatria'),
('Obstetrícia'),
('Psiquiatria'),
('Administração'),
('Neurologia'),           
('Ortopedia'),   
('Estoque'),         
('Gastroenterologia'),
('Radiologia'),
('Pneumologia');



INSERT INTO Medico (crm, login, nome_dep) VALUES
('CE123456', 'pedrolima', 'Cardiologia'),
('RJ234567', 'felipesantos', 'Neurologia'),
('SP345678', 'ricardoalmeida', 'Cardiologia'),
('BA456789', 'eduardofernandes', 'Pediatria'),
('RS567890', 'thiagorocha', 'Ortopedia'),
('PE678901', 'rafaelmoreira', 'Clínica Médica'),
('PR789012', 'gustavocarvalho', 'Gastroenterologia'),
('MG890123', 'viniciusalves', 'UTI'),
('RJ901234', 'fabianosouza', 'Clínica Médica'),
('AM012345', 'amandamartins', 'Obstetrícia'),
('GO101112', 'beatrizcosta', 'Pediatria'),
('CE121314', 'lucasribeiro', 'Cardiologia'),
('CE838182', 'jorgecosta', 'Radiologia'),
('CE616263', 'amandanunes', 'Pneumologia'),
('CE515253', 'lucasnunes', 'Psiquiatria');


INSERT INTO Leito (numero, tipo) VALUES
(1, 'Clínico'),          -- Para pacientes como Benjamin (DPOC) ou Samuel (Dengue)
(2, 'Semi-Intensiva'),    -- Para pacientes que precisam de monitoramento cardíaco, como Sérgio
(3, 'Clínico'),          -- Outro leito clínico para casos gerais
(4, 'Psiquiátrico'),      -- Para pacientes em crise, como Helena
(5, 'UTI Geral'),         -- Para paciente em estado grave
(6, 'Clínico'),
(7, 'Maternidade'),       -- Para simular uma paciente em parto
(8, 'Pediatria'),         -- Para paciente pediátrico
(9, 'Cirúrgico'),         -- Para paciente em pós-operatório
(10, 'Isolamento'),       -- Para paciente com doença contagiosa (ex: Dengue grave)
(11, 'Clínico'),
(12, 'Semi-Intensiva'),
(13, 'UTI Geral'),
(14, 'Psiquiátrico'),
(15, 'Cirúrgico'),
(16, 'Pediatria');

INSERT INTO Paciente(cpf, nome, sexo, data_nascimento, rua, bairro, cidade, pais) VALUES
('15919081325', 'Benjamin Heitor Ramos','M' ,'1968-07-08', 'Rua 715', 'Conjunto Ceará', 'Fortaleza', 'Brasil'),
('72219489760', 'Felipe Guilherme Lopes','M' ,'1948-07-13', 'Rua Comerciante Assis Vieira', 'De Lourdes', 'Fortaleza', 'Brasil'),
('95563215008', 'Helena Emilly Amanda Martins', 'F' ,'1994-02-19', 'Rua Bruno Ângelo de Figueiredo', 'Brejo Seco', 'Juazeiro do Norte', 'Brasil'),
('76129904827', 'Sérgio Matheus Nascimento', 'M' ,'1945-10-09', 'Vila Paissandu', 'Jardim América', 'Fortaleza', 'Brasil'),
('43727104295', 'Fernanda Marlene dos Santos','F' ,'1994-06-18', 'Rua Principal, s/n', 'Centro', 'Patos', 'Brasil'),
('61235916065', 'Samuel Cláudio da Conceição','M' ,'1973-07-10', 'Rua Raimundo Simplício de Carvalho 512', 'Centro', 'Chorozinho', 'Brasil'),
('31877804827', 'Caleb Marcelo Freitas','M' ,'1961-05-11', 'Praça Maciel de Brito', 'Bela Vista', 'Fortaleza','Brasil'),
('88116107453', 'Renato Oliver Heitor Pires', 'M' ,'1977-09-23', 'Vila Bruno', 'Benfica', 'Fortaleza', 'Brasil'),
('63685814508', 'Márcio Carlos Eduardo Bernardo Aparício', 'M' ,'2001-10-01', 'Rua Antônio Ferreira de Andrade', 'Jarí', 'Maracanaú', 'Brasil'),
('02868676723', 'Sophie Jennifer Isabelly Fernandes', 'F' ,'2007-08-21', 'Rua Joaquim Alves de Oliveira', 'Leandro Bezerra de Meneses', 'Juazeiro do Norte', 'Brasil'),
('12345678900', 'Ravi Andrade da Silva', 'M' ,'2020-08-21', 'Rua Joaquim Alves de Oliveira', 'Leandro Bezerra de Meneses', 'Juazeiro do Norte', 'Brasil'),
('12345678922', 'Ianara Andrade da Silva','F' ,'1999-08-21', 'Rua Joaquim Alves de Oliveira', 'Leandro Bezerra de Meneses', 'Juazeiro do Norte', 'Brasil'),
('12345678933', 'Arthur Andrade da Silva','M' ,'1989-08-21', 'Rua Joaquim Alves de Oliveira', 'Leandro Bezerra de Meneses', 'Juazeiro do Norte', 'Brasil');

INSERT INTO Profissionais_enfermagem (coren, especialidade, turno, login, nome_dep) VALUES
('ENF-SP14293', 'UTI Adulto', 'Diurno', 'martaribeiro', 'UTI'),
('ENF-RJ62924', 'Geral', 'Noturno', 'marianacosta', 'Enfermagem'),
('ENF-MG43740', 'Obstetrícia', 'Diurno', 'beatrizsilva', 'Obstetrícia'),
('ENF-BA42576', 'Pediatria', 'Diurno', 'fernandalima', 'Pediatria'),
('ENF-RS85617', 'Psiquiatria', 'Noturno', 'larissaoliveira', 'Psiquiatria'),
('ENF-PE60798', 'Geral', 'Diurno', 'yuriaraujo', 'Enfermagem'),
('ENF-PR07189', 'Geral', 'Noturno', 'vitoriapereira', 'Clínica Médica'),
('ENF-CE28790', 'Centro Cirúrgico', 'Diurno', 'rafaelgomes', 'Centro Cirúrgico'),
('ENF-RJ10872', 'UTI', 'Noturno', 'marianasouza', 'Enfermagem'),
('ENF-MG28649', 'Obstetrícia', 'Noturno', 'thiagomendes', 'Obstetrícia');

INSERT INTO Internacao (data_hora_entrada, data_hora_saida, numero, cpf, crm) VALUES
('2025-09-21 08:00:00', NULL, 1, '15919081325', 'CE616263'),  -- Pneumologia (Benjamin/DPOC)
('2025-10-16 11:00:00', '2025-10-22 17:00:00', 3, '72219489760', 'PE678901'),  -- Clínica Médica
('2023-04-11 14:00:00', NULL, 4, '95563215008', 'CE515253'),  -- Psiquiatria (Helena/Crise)
('2025-01-20 09:00:00', '2025-01-22 18:00:00', 2, '76129904827', 'CE123456'),  -- Cardiologia (Sérgio/Monitoramento)
('2023-06-08 15:00:00', '2023-06-10 10:00:00', 6, '43727104295', 'RJ901234'),  -- Clínica Médica
('2023-11-11 14:00:00', '2023-11-15 16:00:00', 10, '61235916065', 'PE678901'), -- Clínica Médica (Samuel/Dengue)
('2024-12-01 10:00:00', NULL, 8, '12345678900', 'BA456789'),  -- Pediatria (Ravi)
('2024-06-25 22:00:00', NULL, 5, '88116107453', 'MG890123'),  -- UTI (Renato)
('2025-03-05 06:00:00', NULL, 7, '12345678922', 'AM012345'),  -- Obstetrícia (Ianara/Maternidade)
('2025-04-10 14:00:00', '2025-04-14 11:00:00', 9, '12345678933', 'RS567890');  -- Ortopedia (Arthur/Cirúrgico)

INSERT INTO Contatos_emergencia (numero, cpf) VALUES
('+55 (85) 98123-4567', '15919081325'),
('+55 (85) 99765-4321', '72219489760'),
('+55 (88) 98765-1234', '95563215008'),
('+55 (85) 99187-6543', '76129904827'),
('+55 (88) 99456-7890', '43727104295'),
('+55 (85) 98543-2109', '61235916065'),
('+55 (85) 99321-0987', '31877804827'),
('+55 (85) 98901-2345', '88116107453'),
('+55 (88) 99234-5678', '63685814508'),
('+55 (88) 98678-9012', '02868676723');

INSERT INTO Horarios_plantao (horario_inicio, horario_fim, data, crm, login) VALUES
(7, 15, '2025-11-26','CE123456', 'pedrolima'),
(6, 14, '2025-11-26','RJ234567', 'felipesantos'),
(10, 18, '2025-11-26','SP345678', 'ricardoalmeida'),
(9, 17, '2025-11-26','BA456789', 'eduardofernandes'),
(11, 19, '2025-11-26','RS567890', 'thiagorocha'),
(13, 21, '2025-11-26','PE678901', 'rafaelmoreira'),
(14, 22, '2025-11-26','PR789012', 'gustavocarvalho'),
(22, 5, '2025-11-26','MG890123', 'viniciusalves'),
(5, 13, '2025-11-26','RJ901234', 'fabianosouza'),
(7, 15, '2025-11-26','AM012345', 'amandamartins'),
(10, 18, '2025-11-26','GO101112', 'beatrizcosta');

INSERT INTO Mensagens (data_hora, descricao, login_snd, login_rec) VALUES
('2025-11-26 13:25', 'Dr. Pedro, preciso de sua opinião sobre este paciente.', 'felipesantos', 'pedrolima'),
('2025-11-26 18:30', 'Vitória, poderia checar esse resultado para mim?', 'gustavocarvalho', 'vitoriapereira'),
('2025-11-26 11:00', 'Dr. Fabiano, poderia verificar este exame quando possível?', 'martaribeiro', 'fabianosouza'),
('2025-11-26 14:10', 'Dra. Amanda, podemos conversar sobre a nova paciente da Obstetrícia?', 'beatrizcosta', 'amandamartins'),
('2025-11-26 16:45', 'Dr. Eduardo, poderia avaliar essa situação quando possível?', 'rafaelmoreira', 'eduardofernandes'),
('2025-11-26 23:05', 'Paciente do leito 15 com febre alta (38.8°C). Aguardando nova orientação.', 'fernandalima', 'viniciusalves'),
('2025-11-26 14:20', 'Dr. Ricardo, preciso alinhar um caso com você.', 'pedrolima', 'ricardoalmeida'),
('2025-11-26 06:25', 'Dra. Amanda, poderia revisar o caso que encaminhei?', 'fabianosouza', 'amandamartins'),
('2025-11-26 17:15', 'Beatriz, poderia me encaminhar os dados do novo paciente da pediatria?', 'thiagorocha', 'beatrizcosta'),
('2025-11-26 11:35', 'Felipe, consegue ver essa demanda assim que possível?', 'amandamartins', 'felipesantos'),
('2025-11-26 10:00', 'Fernanda, preciso confirmar uma informação com você.', 'marianacosta', 'fernandalima'),
('2025-11-26 19:05', 'Relatório de plantão noturno finalizado e anexado ao sistema.', 'larissaoliveira', 'marcosdasilva');

INSERT INTO Alerta (prioridade, data_hora, evento, login_adm) VALUES
(3, '2025-11-25 22:15:00', 'Falha no sistema de agendamento de consultas', 'carolalves'),
(1, '2025-11-25 10:30:00', 'Incêndio detectado na Ala Oeste', 'carolalves'),
(2, '2025-11-26 11:20:00', 'Contaminação em lote de Dipirona 1G', 'marcosdasilva'),
(1, '2025-11-25 15:45:00', 'Queda de energia na UTI Neonatal', 'carolalves'),
(2, '2025-11-25 18:00:00', 'Estoque de Morfina abaixo do mínimo', 'marcosdasilva'),
(1, '2025-11-26 14:55:00', 'Evasão de paciente da ala de Psiquiatria', 'carolalves'),
(2, '2025-11-26 01:30:00', 'Vazamento de água na Pediatria', 'marcosdasilva'),
(1, '2025-11-26 06:40:00', 'Parada Cardiorrespiratória no Leito 5', 'carolalves'),
(3, '2025-11-26 09:00:00', 'Atualização de software pendente na UTI', 'carolalves'),
(3, '2025-11-26 16:30:00', 'Lâmpada queimada na sala de Raio-X', 'marcosdasilva');


INSERT INTO Consulta(data_requisicao, data_hora_consulta, observacoes, diagnostico, status, especialidade, cpf) VALUES
('2025-09-06 10:30:00', '2025-09-20 14:00:00', 'Paciente fumante. Saturação 92%. Exame de espirometria solicitado.', 'Bronquite Crônica', 'Realizada', 'Pneumologia', '15919081325'),
('2025-10-15 14:00:00', '2025-11-28 09:00:00', NULL, NULL, 'Em espera', 'Ortopedia', '72219489760'),
('2023-04-10 09:30:00', '2023-04-10 10:30:00', 'Relata preocupação excessiva e ataques de pânico. Histórico familiar de transtornos de humor.', 'Transtorno de Ansiedade Generalizada (TAG)', 'Realizada', 'Psiquiatria', '95563215008'),
('2025-01-20 08:00:00', '2025-01-20 15:30:00', 'Eletrocardiograma dentro dos padrões esperados para paciente com marca-passo. Sem sinais de isquemia.', 'Avaliação e ajuste de Marca-passo', 'Realizada', 'Cardiologia', '76129904827'),
('2023-06-08 11:00:00', '2023-07-05 08:00:00', NULL, NULL, 'Cancelada', 'Neurologia', '43727104295'),
('2023-11-11 12:00:00', '2023-11-11 12:30:00', 'Sinais vitais verificados. Rash cutâneo presente. Teste rápido positivo.', 'Dengue', 'Realizada', 'Clínica Geral', '61235916065'),
('2023-04-05 13:00:00', '2023-04-25 16:00:00', 'Dor intermitente no abdômen. Sem sangue nas fezes. Realizou colonoscopia recente (negativa).', 'Síndrome do Intestino Irritável (SII)', 'Realizada', 'Gastroenterologia', '31877804827'),
('2024-06-23 10:00:00', '2024-07-01 13:00:00', NULL, NULL, 'Em espera', 'Gastroenterologia', '88116107453'),
('2025-01-14 15:00:00', '2025-02-10 11:00:00', NULL, NULL, 'Em espera', 'Psiquiatria', '63685814508'),
('2024-01-05 09:00:00', '2024-01-05 09:30:00', 'Radiografia confirma entorse, sem fratura óssea. Indicações de gelo e repouso.', 'Entorse de Tornozelo (Grau II)', 'Realizada', 'Ortopedia', '02868676723');

INSERT INTO Medicamento (fabricante, nome_generico, unidades, data_validade, lote, crm, coren, cpf) VALUES
('PharmaCorp', 'Paracetamol 500mg', 1500, '2027-10-01', 'LOTE_PCM1027', 'PE678901', 'ENF-PE60798', '72219489760'), 
('MedLabor', 'Amoxicilina 500mg', 800, '2026-08-15', 'LOTE_AMO2026', 'BA456789', 'ENF-BA42576', '12345678900'), 
('MedLabor', 'Ibuprofeno 600mg', 1500, '2027-12-15', 'LOTE_IBU1227', 'RS567890', 'ENF-PR07189', '63685814508'), 
('GlobalLabs', 'Sinvastatina 20mg', 1200, '2028-05-20', 'LOTE_SINV0528', 'SP345678', 'ENF-SP14293', '31877804827'), 
('PharmaCorp', 'Dipirona 1g', 3000, '2027-01-30', 'LOTE_DIP0127', 'RJ901234', 'ENF-RJ62924', '43727104295'),
('MedLabor', 'Insulina NPH', 400, '2026-03-01', 'LOTE_INSUL0326', 'PE678901', 'ENF-PE60798', '15919081325'), 
('BioFarma', 'Cloreto de Sódio 0.9%', 500, '2029-11-01', 'LOTE_SF09_29', 'MG890123', 'ENF-RJ10872', '88116107453'), 
('GlobalLabs', 'Omeprazol 20mg', 950, '2028-07-25', 'LOTE_OMP0728', 'PR789012', 'ENF-RJ62924', '76129904827'), 
('BioFarma', 'AAS 100mg', 600, '2026-10-05', 'LOTE_AAS1026', 'CE121314', 'ENF-SP14293', '72219489760'), 
('MedLabor', 'Morfina 10mg', 200, '2028-04-10', 'LOTE_MORF0428', 'MG890123', 'ENF-CE28790', '88116107453'); 


INSERT INTO Materiais_Insumos (nome, tipo, quantidade, data_validade, fornecedor, lote, nome_dep) VALUES
('Máscara Cirúrgica PFF2', 'EPI', 5000, '2028-06-01', 'SafetyMed', 'M95LOTE001', 'Estoque'),
('Gaze Estéril 7.5x7.5', 'Curativo', 5500, '2029-01-20', 'CleanCare', 'GAZE0129A', 'Enfermagem'),
('Luva de Procedimento M', 'Descartável', 10500, '2027-11-20', 'GlovesPlus', 'LVPRCL10B', 'Estoque'),
('Monitor de Glicemia', 'Equipamento', 200, '2030-01-01', 'BioTools', 'GLICEM15X', 'UTI'),
('Seringa 5ml', 'Descartável', 8000, '2029-03-15', 'SyringeFast', 'S5MLLOTE05', 'Enfermagem'),
('Scalp 23G', 'Acesso Venoso', 3000, '2028-09-01', 'NeedleTech', 'SCAL23G01', 'Pronto-Socorro'),
('Fio de Sutura 3-0', 'Instrumental', 500, '2026-12-31', 'SuturePro', 'SUT30L12', 'Centro Cirúrgico'),
('Álcool 70%', 'Limpeza/Antis.', 200, '2027-10-01', 'QuimiClean', 'ALC70L09', 'Estoque'),
('Lâmina de Bisturi #10', 'Instrumental', 1000, '2027-08-10', 'BladeMaster', 'BIST10X03', 'Centro Cirúrgico'),
('Soro Fisiológico 500ml', 'Solução', 1200, '2027-04-10', 'HydroSol', 'SFISIOA47', 'Pronto-Socorro');

INSERT INTO Exame(tipo, resultado, data_hora, crm, cpf) VALUES
('Espirometria', 'Redução leve na Capacidade Vital Forçada (CVF). Padrão obstrutivo compatível com DPOC.', '2025-09-22 09:30:00', 'CE616263', '15919081325'),
('Raio-x', NULL, '2025-11-28 10:00:00', 'CE838182', '72219489760'),
('Eletrocardiograma', 'Ritmo sinusal regular. Sem alterações de repolarização ou arritmias. Exame dentro da normalidade.', '2023-04-10 11:30:00', 'CE123456', '95563215008'),
('Avaliação do marca passo', 'Bateria em bom estado. Programação do intervalo A-V ajustada de 150ms para 140ms para otimização hemodinâmica.', '2025-01-20 16:30:00', 'CE123456', '76129904827'),
('Exame neurológico', NULL, '2023-07-05 09:00:00', 'RJ234567', '43727104295'),
('Hemograma completo', 'Leucócitos e plaquetas abaixo do valor de referência (Leucopenia e Trombocitopenia). Confirma quadro viral.', '2023-11-11 13:00:00', 'PE678901', '61235916065'),
('Ultrassonografia abdominal', 'Órgãos abdominais sem alterações estruturais. Sem sinais de massa ou líquido livre.', '2023-04-27 10:00:00', 'PR789012', '31877804827'),
('Colonoscopia', NULL, '2024-07-08 14:00:00', 'PR789012', '88116107453'),
('Exame de estado mental', NULL, '2025-02-10 12:00:00', 'CE515253', '63685814508'),
('Raio-x', 'Ausência de fratura ou luxação. Edema de partes moles periarticular.', '2024-01-05 10:30:00', 'CE838182', '02868676723');

INSERT INTO Ficha_Anamnese(cpf, data, convenio, queixa_principal, sintomas, descricao, habitos_de_vida, procedimentos) VALUES
('15919081325', '2025-11-04', NULL, 'Tontura', 'Dor de cabeça, febre baixa, sonolência', 'Paciente estava trabalhando caiu e bateu a nuca', NULL, NULL),
('72219489760', '2025-08-21', NULL, 'Fraqueza', 'Palidez, palpitações, falta de ar', 'Paciente começou a sentir faz uma semana e os sintomas vêm se agravando', NULL, NULL),
('95563215008', '2025-05-30', NULL, 'Vômito', 'Dor de barriga, vômito, garganta inflamada', '', NULL, NULL),
('76129904827', '2025-01-29', NULL, 'Tosse', 'Garganta inflamada, febre', 'Paciente começou a sentir os sintomas após comer uma refeiçãi entregue', NULL, NULL),
('43727104295', '2025-03-12', NULL, 'Falta de Ar', 'Tosse, coriza excessiva', 'Paciente sentiu os sintomas com intensidade acima do normal após consumir um cigarro', 'Fuma', NULL),
('61235916065', '2025-06-04', NULL, 'Enjôo', 'Dor de barriga, diarréia', 'Paciente ficou enfermo pouco depois de sair de um restaurante', NULL, NULL),
('31877804827', '2025-12-19', NULL, 'Dor Abdominal', 'Dor extrema no abdômem', 'Paciente sentiu uma dor aguda de repente', NULL, NULL),
('88116107453', '2025-10-17', NULL, 'Lesão no pé', 'Dor ao andar', 'Paciente estava jogando futebo, caiu e começou a sentir dor após se levantar', NULL, NULL),
('63685814508', '2025-09-13', NULL, 'Dificuldade de dormir', 'Insônia, coriza excessiva', 'Paciente começõu a sentir os sintomas logo após o último fim de semana', NULL, NULL),
('02868676723', '2025-08-27', NULL, 'Lesão na mão direita', 'Dificuldade em fechar a mão, dor na mão ao exercer força', 'Paciente começou a sentir os sintomas após uma cirurgia em sua mão', NULL, 'Correção de fratura na mão direita');