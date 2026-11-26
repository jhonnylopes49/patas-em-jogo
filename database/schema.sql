-- Patas em Jogo - schema.sql
-- ONG de adocao de animais que organiza campeonatos de video game beneficentes
SET NAMES utf8mb4;
DROP DATABASE IF EXISTS patas_em_jogo;
CREATE DATABASE patas_em_jogo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE patas_em_jogo;

-- voluntarios que usam o sistema (login)
CREATE TABLE usuario (
  id_usuario  INT AUTO_INCREMENT PRIMARY KEY,
  nome        VARCHAR(150) NOT NULL,
  email       VARCHAR(100) NOT NULL UNIQUE,
  senha_hash  VARCHAR(255) NOT NULL,
  perfil      ENUM('admin', 'voluntario') NOT NULL DEFAULT 'voluntario',
  criado_em   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- animais do abrigo
CREATE TABLE animal (
  id_animal     INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(80) NOT NULL,
  especie       ENUM('cachorro', 'gato', 'outro') NOT NULL,
  sexo          ENUM('M', 'F') NOT NULL,
  porte         ENUM('pequeno', 'medio', 'grande') NOT NULL,
  idade_meses   INT CHECK (idade_meses >= 0),
  castrado      BOOLEAN NOT NULL DEFAULT FALSE,
  descricao     TEXT,
  status        ENUM('disponivel', 'em_processo', 'adotado') NOT NULL DEFAULT 'disponivel',
  data_entrada  DATE NOT NULL
);

-- pessoas interessadas em adotar
-- LGPD: so nome e contato, sem CPF nem endereco completo
CREATE TABLE adotante (
  id_adotante    INT AUTO_INCREMENT PRIMARY KEY,
  nome           VARCHAR(150) NOT NULL,
  email          VARCHAR(100) NOT NULL UNIQUE,
  telefone       VARCHAR(20),
  cidade         VARCHAR(100) NOT NULL,
  data_cadastro  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- pedido de adocao (liga adotante e animal)
CREATE TABLE pedido_adocao (
  id_pedido    INT AUTO_INCREMENT PRIMARY KEY,
  id_adotante  INT NOT NULL,
  id_animal    INT NOT NULL,
  data_pedido  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status       ENUM('em_analise', 'aprovado', 'recusado') NOT NULL DEFAULT 'em_analise',
  observacao   VARCHAR(255),
  UNIQUE (id_adotante, id_animal),
  FOREIGN KEY (id_adotante) REFERENCES adotante (id_adotante) ON DELETE CASCADE,
  FOREIGN KEY (id_animal) REFERENCES animal (id_animal) ON DELETE CASCADE
);

-- campeonatos beneficentes de video game
CREATE TABLE campeonato (
  id_campeonato    INT AUTO_INCREMENT PRIMARY KEY,
  nome             VARCHAR(150) NOT NULL,
  jogo             VARCHAR(100) NOT NULL,
  plataforma       ENUM('PC', 'PlayStation', 'Xbox', 'Nintendo Switch', 'Mobile') NOT NULL,
  data_evento      DATE NOT NULL,
  cidade           VARCHAR(100) NOT NULL,
  vagas            INT NOT NULL CHECK (vagas > 0),
  valor_inscricao  DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (valor_inscricao >= 0)
);

-- jogadores que participam dos campeonatos
CREATE TABLE jogador (
  id_jogador     INT AUTO_INCREMENT PRIMARY KEY,
  nome           VARCHAR(150) NOT NULL,
  nickname       VARCHAR(50) NOT NULL UNIQUE,
  email          VARCHAR(100) NOT NULL UNIQUE,
  data_cadastro  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- inscricao: N:N entre jogador e campeonato
-- a inscricao pode ser paga em dinheiro ou com racao
CREATE TABLE inscricao (
  id_campeonato    INT NOT NULL,
  id_jogador       INT NOT NULL,
  data_inscricao   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  forma_pagamento  ENUM('dinheiro', 'racao') NOT NULL,
  colocacao        INT CHECK (colocacao > 0),
  PRIMARY KEY (id_campeonato, id_jogador),
  FOREIGN KEY (id_campeonato) REFERENCES campeonato (id_campeonato) ON DELETE CASCADE,
  FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador) ON DELETE CASCADE
);

-- doacoes recebidas (podem vir de um campeonato ou avulsas)
CREATE TABLE doacao (
  id_doacao      INT AUTO_INCREMENT PRIMARY KEY,
  id_campeonato  INT,
  nome_doador    VARCHAR(150),
  tipo           ENUM('dinheiro', 'racao', 'medicamento', 'outro') NOT NULL,
  valor          DECIMAL(10,2) CHECK (valor > 0),
  quantidade_kg  DECIMAL(6,2) CHECK (quantidade_kg > 0),
  descricao      VARCHAR(255),
  data_doacao    DATE NOT NULL,
  CHECK (tipo <> 'dinheiro' OR valor IS NOT NULL),
  FOREIGN KEY (id_campeonato) REFERENCES campeonato (id_campeonato) ON DELETE SET NULL
);
