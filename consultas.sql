/*
1.	Encontrar os autores que têm mais de um livro na biblioteca
*/
SELECT 
    autor.idautor, 
    autor.nome AS nome_autor, 
    (
        SELECT COUNT(*)
        FROM livro
        WHERE livro.autor_idautor = autor.idautor
    ) AS numero_de_livros
FROM autor
WHERE autor.idautor IN (
    SELECT livro.autor_idautor
    FROM livro
    GROUP BY livro.autor_idautor
    HAVING COUNT(*) > 1
);

/*
2.	Encontre todos os livros publicados antes de 2010.
*/

SELECT l.nome, l.dataPublicacao AS anoPublicacao, li.numeroPaginas, ld.formatoArquivo, ld.tamanho
FROM livro l
LEFT JOIN livroimpresso li ON l.idlivro = li.livro_idlivro
LEFT JOIN livrodigital ld ON l.idlivro = ld.livro_idlivro
WHERE YEAR(l.dataPublicacao) < 2010;

/*
3.	Conte quantos empréstimos foram feitos por cada cliente.
*/

SELECT nome, COUNT(*) as qtd_emp from cliente
INNER JOIN emprestimo ON emprestimo.cliente_matricula = cliente.matricula
GROUP BY cliente.nome
ORDER BY cliente.nome;


/*
4.	Liste todos os clientes que têm multas pendentes e o valor total das multas para cada um.
*/

SELECT nome, SUM(multa.valor) as valorMulta FROM cliente
INNER JOIN multa ON multa.cliente_matricula = cliente.matricula
WHERE multa.status != 1
GROUP BY cliente.nome;

/*
5.	Encontre os funcionários que têm um salário superior a R$500.
*/

SELECT f.nome, f.salario, f.tipoFuncionario
FROM funcionario f
WHERE f.salario > 500
  AND (f.salario, f.nome) IN (
    SELECT MAX(salario), nome
    FROM funcionario
    GROUP BY nome
  );

/*
6. Inserção de um novo livro usando Triggers
*/

DELIMITER //
CREATE TRIGGER validar_novo_livro
BEFORE INSERT ON livro
FOR EACH ROW
BEGIN
    -- Verifica se o nome do livro é fornecido
    IF NEW.nome IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O nome do livro é obrigatório.';
    END IF;

    -- Verifica se o gênero do livro é fornecido
    IF NEW.genero IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O gênero do livro é obrigatório.';
    END IF;

    -- Verifica se a data de publicação do livro é fornecida
    IF NEW.dataPublicacao IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A data de publicação do livro é obrigatória.';
    END IF;

    -- Verifica se o ID do autor do livro é fornecido
    IF NEW.autor_idautor IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O ID do autor do livro é obrigatório.';
    END IF;

    -- Verifica se a editora do livro é fornecida
    IF NEW.editora_ideditora IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A editora do livro é obrigatória.';
    END IF;
END;
//
DELIMITER ;

INSERT INTO livro (nome, genero, dataPublicacao, autor_idautor, editora_ideditora)
VALUES ('Craftsmanship limpo: disciplinas, padrões e ética', 'Tecnologia', '2023-01-15', '4', NULL);

/*
7 . UPDATE usando Transaction
*/

UPDATE livroimpresso SET qtdEmEstoque = qtdEmEstoque - 1 WHERE livro_idlivro = 4;

SELECT nome, livroimpresso.qtdEmEstoque FROM livro
INNER JOIN livroimpresso ON livro.idlivro = livroimpresso.livro_idlivro;

/*
8.	Encontre os livros mais emprestados.
*/

SELECT nome, COUNT(*) as qtd FROM emprestimo
INNER JOIN livro ON livro.idlivro = emprestimo.livro_idlivro
GROUP BY livro.nome;

/*
9.	Liste todas as reservas feitas por clientes.
*/

SELECT cliente.nome, reserva.cliente_matricula, livro.nome as livroNome, reserva.dataReserva FROM reserva
INNER JOIN cliente ON cliente.matricula = reserva.cliente_matricula
INNER JOIN livro ON livro.idlivro = reserva.livro_idlivro
GROUP BY cliente.nome, reserva.cliente_matricula, livro.nome, reserva.dataReserva;

/*
10.	Encontre os clientes que fizeram mais de 1 empréstimo.
*/

SELECT nome, COUNT(emprestimo.cliente_matricula) as qtd_reservas FROM cliente
INNER JOIN emprestimo ON emprestimo.cliente_matricula = cliente.matricula
GROUP BY cliente.nome
HAVING qtd_reservas > 1;