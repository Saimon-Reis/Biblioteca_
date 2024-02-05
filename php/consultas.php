<?php

if (isset($_GET["consulta1"])){
    consulta1();
}

if (isset($_GET["consulta2"])){
    consulta2();
}

if (isset($_GET["consulta3"])){
    consulta3();
}

if (isset($_GET["consulta4"])){
    consulta4();
}

if (isset($_GET["consulta5"])){
    consulta5();
}

if (isset($_GET["consulta6"])){
    include("./link.php");

    try{
        $sql ="INSERT INTO livro (nome, genero, dataPublicacao, autor_idautor, editora_ideditora)
        VALUES ('Livro teste', 'Tecnologia', '2023-02-15', '4', NULL)";

        if (mysqli_query($conn, $sql)) {
            // echo "Ok";
            consulta6();
        }
        }catch (mysqli_sql_exception $e){
                echo ('
                <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Erro</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                            <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>A editora do livro é obrigatória.</p>
                        </div>
                    </div>
                </div>
            </div>
                ');
    }
    mysqli_close($conn);
}

if (isset($_GET["consulta7"])){
    include("./link.php");

    try{
        $sql ="UPDATE livroimpresso SET qtdEmEstoque = qtdEmEstoque - 1 WHERE livro_idlivro = 4";
        
        if (mysqli_query($conn, $sql)) {
            // echo "Ok";
            mysqli_commit($conn);
            consulta7();
        } else {
            // Reverter a transação se uma das consultas falhar
            mysqli_rollback($conn);
            echo ('
                <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">7 . UPDATE usando Transaction</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                            <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>Erro na transação. Revertendo..."</p>
                        </div>
                    </div>
                </div>
            </div>
                ');
            }
        }catch (mysqli_sql_exception $e){
            mysqli_rollback($conn);
            echo ('
                <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">7 . UPDATE usando Transaction</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                            <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>Erro na transação. Revertendo..."</p>
                        </div>
                    </div>
                </div>
            </div>
            ');
    }
    mysqli_close($conn);
}

if (isset($_GET["consulta8"])){
    consulta8();
}

if (isset($_GET["consulta9"])){
    consulta9();
}

if (isset($_GET["consulta10"])){
    consulta10();
}

function consulta1(){
    include("./link.php");

    $sql = "SELECT 
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
    HAVING COUNT(*) > 1)";
    $result = mysqli_query($conn, $sql);

    echo ('
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">1. Encontrar os autores que têm mais de um livro na biblioteca</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <p>SELECT 
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
                );</p>
                    
                    <br>
                    
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nome</th>
                                <th scope="col">Quantidade de livros</th>
                            </tr>
                        </thead>
    ');

    if (mysqli_num_rows($result) > 0) {
        // output data of each row
        while($row = mysqli_fetch_assoc($result)) {
            $nome = $row["nome_autor"];
            $qtd_livros = $row["numero_de_livros"];
            echo ("
                <tbody>
                    <tr>
                        <td>$nome</td>
                        <td>$qtd_livros</td>
                    </tr>
                </tbody>"
            );
        }
    }
    
    mysqli_close($conn);
    echo ("</table>");
    echo ("
                </div>
            </div>
        </div>
    </div>
    ");
}

//Adicionar livros com pub antes de 2000 no banco
function consulta2(){
    include("./link.php");

    $sql = "SELECT l.nome, l.dataPublicacao AS anoPublicacao, li.numeroPaginas, ld.formatoArquivo, ld.tamanho
            FROM livro l
            LEFT JOIN livroimpresso li ON l.idlivro = li.livro_idlivro
            LEFT JOIN livrodigital ld ON l.idlivro = ld.livro_idlivro
            WHERE YEAR(l.dataPublicacao) < 2010";
    $result = mysqli_query($conn, $sql);

    echo ('
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">2. Encontre todos os livros publicados antes de 2010.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <p>SELECT l.nome, l.dataPublicacao AS anoPublicacao, li.numeroPaginas, ld.formatoArquivo, ld.tamanho
                        FROM livro l
                        LEFT JOIN livroimpresso li ON l.idlivro = li.livro_idlivro
                        LEFT JOIN livrodigital ld ON l.idlivro = ld.livro_idlivro
                        WHERE YEAR(l.dataPublicacao) < 2010;
                    </p>
                    
                    <br>
                    
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nome</th>
                                <th scope="col">Número de páginas</th>
                                <th scope="col">Formato</th>
                                <th scope="col">Tamanho</th>
                                <th scope="col">Data publicação</th>
                            </tr>
                        </thead>
    ');

    if (mysqli_num_rows($result) > 0) {
        // output data of each row
        while($row = mysqli_fetch_assoc($result)) {
            $nome = $row["nome"];
            $numPag = $row["numeroPaginas"];
            $formato = $row["formatoArquivo"];
            $tamanho = $row["tamanho"];
            $dataPubli = $row["anoPublicacao"];
            echo ("
                <tbody>
                    <tr>
                        <td>$nome</td>
                        <td>$numPag</td>
                        <td>$formato</td>
                        <td>$tamanho</td>
                        <td>$dataPubli</td>
                    </tr>
                </tbody>"
            );
        }
    }
    
    mysqli_close($conn);
    echo ("</table>");
    echo ("
                </div>
            </div>
        </div>
    </div>
    ");
}

function consulta3(){
    include("./link.php");

    $sql = "SELECT nome, COUNT(*) as qtd_emp from cliente
    INNER JOIN emprestimo ON emprestimo.cliente_matricula = cliente.matricula
    GROUP BY cliente.nome
    ORDER BY cliente.nome";
    $result = mysqli_query($conn, $sql);

    echo ('
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">3. Conte quantos empréstimos foram feitos por cada cliente.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <p>SELECT nome, COUNT(*) as qtd_emp from cliente
                    INNER JOIN emprestimo ON emprestimo.cliente_matricula = cliente.matricula
                    GROUP BY cliente.nome
                    ORDER BY cliente.nome;</p>
                    
                    <br>
                    
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nome</th>
                                <th scope="col">Quantidade de empréstimos</th>
                            </tr>
                        </thead>
    ');

    if (mysqli_num_rows($result) > 0) {
        // output data of each row
        while($row = mysqli_fetch_assoc($result)) {
            $nome = $row["nome"];
            $qtd_emp = $row["qtd_emp"];
            echo ("
                <tbody>
                    <tr>
                        <td>$nome</td>
                        <td>$qtd_emp</td>
                    </tr>
                </tbody>"
            );
        }
    }
    
    mysqli_close($conn);
    echo ("</table>");
    echo ("
                </div>
            </div>
        </div>
    </div>
    ");
}

function consulta4(){
    include("./link.php");

    $sql = "SELECT nome, SUM(multa.valor) as valorMulta FROM cliente
    INNER JOIN multa ON multa.cliente_matricula = cliente.matricula
    WHERE multa.status != 1
    GROUP BY cliente.nome";
    $result = mysqli_query($conn, $sql);

    echo ('
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">4. Liste todos os clientes que têm multas pendentes e o valor total das multas para cada um.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <p>SELECT nome, SUM(multa.valor) as valorMulta FROM cliente
                    INNER JOIN multa ON multa.cliente_matricula = cliente.matricula
                    WHERE multa.status != 1
                    GROUP BY cliente.nome;</p>
                    
                    <br>
                    
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nome</th>
                                <th scope="col">Valor da multa</th>
                            </tr>
                        </thead>
    ');

    if (mysqli_num_rows($result) > 0) {
        // output data of each row
        while($row = mysqli_fetch_assoc($result)) {
            $nome = $row["nome"];
            $valorMulta = $row["valorMulta"];
            echo ("
                <tbody>
                    <tr>
                        <td>$nome</td>
                        <td>R$$valorMulta</td>
                    </tr>
                </tbody>"
            );
        }
    }
    
    mysqli_close($conn);
    echo ("</table>");
    echo ("
                </div>
            </div>
        </div>
    </div>
    ");
}

function consulta5(){
    include("./link.php");

    $sql ="SELECT f.nome, f.salario, f.tipoFuncionario
    FROM funcionario f
    WHERE f.salario > 500
      AND (f.salario, f.nome) IN (
        SELECT MAX(salario), nome
        FROM funcionario
        GROUP BY nome
      )";
    $result = mysqli_query($conn, $sql);

    echo ('
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">5. Encontre os funcionários que têm um salário superior a R$500.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <p>SELECT f.nome, f.salario, f.tipoFuncionario
                    FROM funcionario f
                    WHERE f.salario > 500
                      AND (f.salario, f.nome) IN (
                        SELECT MAX(salario), nome
                        FROM funcionario
                        GROUP BY nome
                      );</p>
                    
                    <br>
                    
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nome</th>
                                <th scope="col">Salario</th>
                                <th scope="col">Cargo</th>
                            </tr>
                        </thead>
    ');

    if (mysqli_num_rows($result) > 0) {
        // output data of each row
        while($row = mysqli_fetch_assoc($result)) {
            $nome = $row["nome"];
            $salario = $row["salario"];
            $cargo = $row["tipoFuncionario"];

            if ($cargo == 1){
                $cargo = "Bibliotecário";
            }else{
                $cargo = "Bolsista";
            }

            echo ("
                <tbody>
                    <tr>
                        <td>$nome</td>
                        <td>R$$salario</td>
                        <td>$cargo</td>
                    </tr>
                </tbody>"
            );
        }
    }
    
    mysqli_close($conn);
    echo ("</table>");
    echo ("
                </div>
            </div>
        </div>
    </div>
    ");
}

function consulta6(){
    include("./link.php");

    $sql2 ="SELECT * FROM livro";
    $result2 = mysqli_query($conn, $sql2);

    echo ('
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">6. Inserção de um novo livro usando Triggers</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <img src="../assets/code.png">
                    
                    <br>
                    
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nome</th>
                                <th scope="col">Gênero</th>
                                <th scope="col">Data Publicação</th>
                            </tr>
                        </thead>
    ');

    if (mysqli_num_rows($result2) > 0) {
        // output data of each row
        while($row2 = mysqli_fetch_assoc($result2)) {
            $nome = $row2["nome"];
            $genero = $row2["genero"];
            $data = $row2["dataPublicacao"];

            echo ("
                <tbody>
                    <tr>
                        <td>$nome</td>
                        <td>$genero</td>
                        <td>$data</td>
                    </tr>
                </tbody>"
            );
        }
    }
    
    mysqli_close($conn);
    echo ("</table>");
    echo ("
                </div>
            </div>
        </div>
    </div>
    ");
}
function consulta7(){
    include("./link.php");

    $sql2 ="SELECT nome, livroimpresso.qtdEmEstoque as qtd FROM livro
    INNER JOIN livroimpresso ON livro.idlivro = livroimpresso.livro_idlivro";
    $result2 = mysqli_query($conn, $sql2);

    echo ('
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">7 . UPDATE usando Transaction</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <p>
                    SELECT nome, livroimpresso.qtdEmEstoque as qtd FROM livro
                    INNER JOIN livroimpresso ON livro.idlivro = livroimpresso.livro_idlivro;
                    </p>
                    
                    <br>
                    
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nome</th>
                                <th scope="col">Quantidade em estoque</th>
                            </tr>
                        </thead>
    ');

    if (mysqli_num_rows($result2) > 0) {
        // output data of each row
        while($row2 = mysqli_fetch_assoc($result2)) {
            $nome = $row2["nome"];
            $qtd = $row2["qtd"];

            echo ("
                <tbody>
                    <tr>
                        <td>$nome</td>
                        <td>$qtd</td>
                    </tr>
                </tbody>"
            );
        }
    }
    
    mysqli_close($conn);
    echo ("</table>");
    echo ("
                </div>
            </div>
        </div>
    </div>
    ");
}
function consulta8(){
    include("./link.php");

    $sql = "SELECT nome, COUNT(*) as qtd FROM emprestimo
    INNER JOIN livro ON livro.idlivro = emprestimo.livro_idlivro
    GROUP BY livro.nome";
    $result = mysqli_query($conn, $sql);

    echo ('
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">8. Encontre os livros mais emprestados.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <p>SELECT nome, COUNT(*) as qtd FROM emprestimo
                    INNER JOIN livro ON livro.idlivro = emprestimo.livro_idlivro
                    GROUP BY livro.nome;</p>
                    
                    <br>
                    
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nome do livro</th>
                                <th scope="col">Quantidade de empréstimos</th>
                            </tr>
                        </thead>
    ');

    if (mysqli_num_rows($result) > 0) {
        // output data of each row
        while($row = mysqli_fetch_assoc($result)) {
            $nome = $row["nome"];
            $qtd = $row["qtd"];

            echo ("
                <tbody>
                    <tr>
                        <td>$nome</td>
                        <td>$qtd</td>
                    </tr>
                </tbody>"
            );
        }
    }
    
    mysqli_close($conn);
    echo ("</table>");
    echo ("
                </div>
            </div>
        </div>
    </div>
    ");
}
function consulta9(){
    include("./link.php");

    $sql = "SELECT cliente.nome, reserva.cliente_matricula, livro.nome as livroNome, reserva.dataReserva FROM reserva
    INNER JOIN cliente ON cliente.matricula = reserva.cliente_matricula
    INNER JOIN livro ON livro.idlivro = reserva.livro_idlivro
    GROUP BY cliente.nome, reserva.cliente_matricula, livro.nome, reserva.dataReserva";
    $result = mysqli_query($conn, $sql);

    echo ('
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">9. Liste todas as reservas feitas por clientes.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <p>SELECT cliente.nome, reserva.cliente_matricula, livro.nome as livroNome, reserva.dataReserva FROM reserva
                    INNER JOIN cliente ON cliente.matricula = reserva.cliente_matricula
                    INNER JOIN livro ON livro.idlivro = reserva.livro_idlivro
                    GROUP BY cliente.nome, reserva.cliente_matricula, livro.nome, reserva.dataReserva;</p>
                    
                    <br>
                    
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nome</th>
                                <th scope="col">Matrícula</th>
                                <th scope="col">Livro</th>
                                <th scope="col">Data</th>
                            </tr>
                        </thead>
    ');

    if (mysqli_num_rows($result) > 0) {
        // output data of each row
        while($row = mysqli_fetch_assoc($result)) {
            $nome = $row["nome"];
            $matricula = $row["cliente_matricula"];
            $livro = $row["livroNome"];
            $data = $row["dataReserva"];

            echo ("
                <tbody>
                    <tr>
                        <td>$nome</td>
                        <td>$matricula</td>
                        <td>$livro</td>
                        <td>$data</td>
                    </tr>
                </tbody>"
            );
        }
    }
    
    mysqli_close($conn);
    echo ("</table>");
    echo ("
                </div>
            </div>
        </div>
    </div>
    ");
}

function consulta10(){
    include("./link.php");

    $sql = "SELECT nome, COUNT(emprestimo.cliente_matricula) as qtd_reservas FROM cliente
    INNER JOIN emprestimo ON emprestimo.cliente_matricula = cliente.matricula
    GROUP BY cliente.nome
    HAVING qtd_reservas > 1";
    $result = mysqli_query($conn, $sql);

    echo ('
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">10. Encontre os clientes que fizeram mais de 1 empréstimo.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <p>SELECT nome, COUNT(emprestimo.cliente_matricula) as qtd_reservas FROM cliente
                    INNER JOIN emprestimo ON emprestimo.cliente_matricula = cliente.matricula
                    GROUP BY cliente.nome
                    HAVING qtd_reservas > 5;</p>
                    
                    <br>
                    
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nome</th>
                                <th scope="col">Quantidade de empréstimos</th>
                            </tr>
                        </thead>
    ');

    if (mysqli_num_rows($result) > 0) {
        // output data of each row
        while($row = mysqli_fetch_assoc($result)) {
            $nome = $row["nome"];
            $qtd_reservas = $row["qtd_reservas"];

            echo ("
                <tbody>
                    <tr>
                        <td>$nome</td>
                        <td>$qtd_reservas</td>
                    </tr>
                </tbody>"
            );
        }
    }
    
    mysqli_close($conn);
    echo ("</table>");
    echo ("
                </div>
            </div>
        </div>
    </div>
    ");
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="../style.css">
    <title>Document</title>
</head>

<body>

    <div class="form-div">
        <h1>BIBLIOTECA</h1>
        <form class="formulario" method="GET">
            <input type="submit" name="consulta1" value="Consulta 1 (SUB)">
            <input type="submit" name="consulta2" value="Consulta 2">
            <input type="submit" name="consulta3" value="Consulta 3">
            <input type="submit" name="consulta4" value="Consulta 4">
            <input type="submit" name="consulta5" value="Consulta 5 (SUB)">
            <input type="submit" name="consulta6" value="Consulta 6 (TRIG)">
            <input type="submit" name="consulta7" value="Consulta 7 (TRAN)">
            <input type="submit" name="consulta8" value="Consulta 8">
            <input type="submit" name="consulta9" value="Consulta 9">
            <input type="submit" name="consulta10" value="Consulta 10">
        </form>
    <div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        
    <script>
        $('#modalExemplo').modal('show');
    </script>

</body>
</html>