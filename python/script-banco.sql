
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
  habitos_de_vida VARCHAR NOT NULL,
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

