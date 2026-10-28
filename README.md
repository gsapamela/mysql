LogExpress
Script 01 — Encomendas por status
Recursos: SELECT + WHERE
Visualizar encomendas em transporte.
USE logexpress;
SELECT id_encomenda, codigo_rastreamento, data_postagem, status_encomenda
FROM encomendas
WHERE status_encomenda = 'Em transporte';
Script 02 — Pesquisar clientes pelo nome
Recursos: LIKE + ORDER BY
Localizar clientes cujo nome contenha Silva.
SELECT id_cliente, nome, cpf_cnpj, contato
FROM clientes
WHERE nome LIKE '%Vivian%'
ORDER BY nome ASC;
Script 03 — Encomendas por período
Recursos: BETWEEN + ORDER BY
Listar encomendas postadas em outubro de 2026.
SELECT id_encomenda, codigo_rastreamento, data_postagem, status_encomenda
FROM encomendas
WHERE data_postagem BETWEEN '2026-10-01' AND '2026-10-31'
ORDER BY data_postagem;
Script 04 — Encomendas e clientes
Recursos: INNER JOIN
Identificar o cliente responsável por cada encomenda.
SELECT c.nome AS cliente, e.codigo_rastreamento, e.data_postagem,
       e.status_encomenda, e.endereco_destino
FROM encomendas e
INNER JOIN clientes c ON e.id_cliente = c.id_cliente
ORDER BY c.nome;
Script 05 — Rotas, motoristas e veículos
Recursos: Múltiplos INNER JOIN
Exibir os recursos e centros envolvidos em cada rota.
SELECT r.id_rota_viagem, m.nome AS motorista, v.placa AS veiculo,
       co.nome AS centro_origem, cd.nome AS centro_destino,
       r.data_saida, r.data_prevista_chegada, r.status_rota
FROM rota_viagens r
INNER JOIN motoristas m ON r.id_motorista = m.id_motorista
INNER JOIN veiculos v ON r.id_veiculo = v.id_veiculo
INNER JOIN centros_de_distribuicoes co ON r.id_origem = co.id_centro_distribuicao
INNER JOIN centros_de_distribuicoes cd ON r.id_destino = cd.id_centro_distribuicao
ORDER BY r.data_saida;
Script 06 — Contagem por status
Recursos: COUNT + GROUP BY
Contar quantas encomendas existem em cada situação.
SELECT status_encomenda, COUNT(*) AS quantidade_encomendas
FROM encomendas
GROUP BY status_encomenda
ORDER BY quantidade_encomendas DESC;
Script 07 — Rotas com mais de uma encomenda
Recursos: COUNT + GROUP BY + HAVING
Encontrar rotas com mais de uma encomenda associada.
SELECT r.id_rota_viagem, COUNT(er.id_encomenda) AS total_encomendas
FROM rota_viagens r
INNER JOIN encomenda_rota er ON r.id_rota_viagem = er.id_rota_viagem
GROUP BY r.id_rota_viagem
HAVING COUNT(er.id_encomenda) > 1
ORDER BY total_encomendas DESC;
Script 08 — Quantidade e média por cliente
Recursos: COUNT + AVG + LEFT JOIN
Calcular o total de encomendas por cliente e a média geral.
SELECT c.id_cliente, c.nome,
       COUNT(e.id_encomenda) AS total_encomendas,
       (SELECT AVG(total_por_cliente)
        FROM (SELECT COUNT(e2.id_encomenda) AS total_por_cliente
              FROM clientes c2
              LEFT JOIN encomendas e2 ON c2.id_cliente = e2.id_cliente
              GROUP BY c2.id_cliente) AS resumo
       ) AS media_encomendas_por_cliente
FROM clientes c
LEFT JOIN encomendas e ON c.id_cliente = e.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY total_encomendas DESC;
Script 09 — Atualizar status
Recursos: UPDATE
Alterar o status de ENC001 para Entregue.
UPDATE encomendas
SET status_encomenda = 'Entregue'
WHERE id_encomenda = 'ENC002';

SELECT id_encomenda, codigo_rastreamento, status_encomenda
FROM encomendas
WHERE id_encomenda = 'ENC002';
Atenção: este script altera os dados do banco. Execute somente quando desejar demonstrar a operação.
Script 10 — Excluir histórico
Recursos: DELETE
Demonstrar exclusão específica de CLI006.

DELETE FROM clientes
WHERE id_cliente = 'CLI006';

Atenção: este script altera os dados do banco. Execute somente quando desejar demonstrar a operação.


Tabelas Criadas

CREATE TABLE Clientes (
id_cliente varchar (255) primary key NOT NULL,
nome varchar (255) NOT NULL,
cpf_cnpj varchar (20) NOT NULL UNIQUE,
contato varchar (20) NOT NULL,
email varchar (255) NOT NULL
);

CREATE TABLE encomendas (
id_encomenda varchar (255) primary key NOT NULL,
id_cliente varchar (255) NOT NULL,
codigo_rastreamento varchar (255) NOT NULL UNIQUE,
data_postagem date NOT NULL,
status_encomenda varchar (255) NOT NULL DEFAULT "POSTADA",
endereco_origem varchar (255) NOT NULL ,
endereco_destino varchar (255) NOT NULL,
foreign key (id_cliente) references clientes(id_cliente)
);

CREATE TABLE centros_de_distribuicoes (
id_centro_distribuicao VARCHAR (255) PRIMARY KEY,
nome VARCHAR (255) NOT NULL,
endereco VARCHAR (255) NOT NULL,
cidade VARCHAR (255) NOT NULL,
estado VARCHAR (255) NOT NULL,
contato varchar (255) NOT NULL
);

CREATE TABLE Historico_Rastreamento (
id_historico_rastreamento VARCHAR (255) PRIMARY KEY,
data_hora DATETIME NOT NULL,
status_encomenda VARCHAR (255) NOT NULL,
id_centro_distribuicao VARCHAR (255) NOT NULL,
id_encomenda VARCHAR (255) NOT NULL,
FOREIGN KEY (id_centro_distribuicao) REFERENCES centros_de_distribuicoes(id_centro_distribuicao),
FOREIGN KEY (id_encomenda) REFERENCES encomendas(id_encomenda)
);

CREATE TABLE veiculos (
id_veiculo varchar (255) primary key NOT NULL,
placa varchar (255) NOT NULL UNIQUE,
status_veiculo varchar (255) NOT NULL
);

CREATE TABLE motoristas (
id_motorista varchar (255) primary key NOT NULL,
nome varchar (255) NOT NULL,
numero_cnh varchar (255) NOT NULL UNIQUE,
contato varchar (255) NOT NULL,
observacao varchar (255) NOT NULL
);

CREATE TABLE rota_viagens (
id_rota_viagem VARCHAR (255) PRIMARY KEY,
data_prevista_chegada DATE NOT NULL,
data_saida DATE NOT NULL,
status_rota VARCHAR (255) NOT NULL,
id_veiculo VARCHAR (255) NOT NULL,
id_motorista VARCHAR (255) NOT NULL,
id_origem VARCHAR (255) NOT NULL,
id_destino VARCHAR (255) NOT NULL,
FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo),
FOREIGN KEY (id_motorista) REFERENCES motoristas(id_motorista),
FOREIGN KEY (id_origem) REFERENCES centros_de_distribuicoes(id_centro_distribuicao),
FOREIGN KEY (id_destino) REFERENCES centros_de_distribuicoes(id_centro_distribuicao)
);

CREATE TABLE encomenda_rota (
id_encomenda VARCHAR(255) NOT NULL,
id_rota_viagem VARCHAR(255) NOT NULL,
PRIMARY KEY (id_encomenda, id_rota_viagem),CONSTRAINT fk_encomenda_rota_encomendas
FOREIGN KEY (id_encomenda) REFERENCES encomendas(id_encomenda),
CONSTRAINT fk_encomenda_rota_viagens FOREIGN KEY (id_rota_viagem) REFERENCES rota_viagens(id_rota_viagem)
);



Script SQL — CREATE VIEW

USE logexpress;

CREATE OR REPLACE VIEW vw_dashboard_logistico AS
SELECT
    e.id_encomenda,
    e.codigo_rastreamento,
    c.nome AS nome_cliente,
    e.data_postagem,
    e.status_encomenda,
    e.endereco_origem,
    e.endereco_destino,
    COUNT(h.id_historico_rastreamento) AS total_movimentacoes,
    MAX(h.data_hora) AS ultima_movimentacao
FROM encomendas e

INNER JOIN clientes c
    ON e.id_cliente = c.id_cliente

LEFT JOIN historico_rastreamento h
    ON e.id_encomenda = h.id_encomenda

GROUP BY
    e.id_encomenda,
    e.codigo_rastreamento,
    c.nome,
    e.data_postagem,
    e.status_encomenda,
    e.endereco_origem,
    e.endereco_destino;

Depois de criar a View, execute:
USE logexpress;

SELECT * FROM vw_dashboard_logistico;

O que essa View faz ?
A View vw_dashboard_logistico é para simular um relatório gerencial do sistema LogExpress. Ela reúne informações de clientes, encomendas e histórico de rastreamento em uma única consulta. Com isso, é possível acompanhar o status das entregas, identificar a quantidade de movimentações de cada encomenda e verificar a data da última atualização, facilitando a análise e o acompanhamento da operação logística.
