Exercícios:
1- Listar consultas realizadas após 02/02/2026.
  SELECT *
  FROM   consulta
  WHERE  status = 'realizada' and data > '02/02/2026';

2- Listar consultas com valor entre 250 e 350.
  SELECT data,hora,valor
  FROM   consulta
  WHERE  valor between 250 and 350;

3- Buscar pacientes cujo nome começa com M.
    SELECT nome
    FROM   paciente
    WHERE  nome like 'M%' or nome like 'm%';
    --ou
    --WHERE  UPPER(nome) like 'M%'
   
4-Listar procedimentos que contenham a palavra "Joelho".
  SELECT nome_procd
  FROM   procedimento
  WHERE  nome_procd like '%Joelho%';

5- Listar pagamentos feitos entre 01/02/2026 e 03/02/2026.
  SELECT   *
  FROM    pagamento
  WHERE   data_pagto >= '01/02/2026' and
          data_pagto <= '03/02/2026';

  SELECT count(*),avg(valor),max(valor),min(valor),sum(valor)
  FROM   consulta;

6- Listar a soma dos pagamentos do ano de 2026.
  SELECT sum(valor_pagto)
  FROM   pagamento
  --WHERE  data_pagto >= '01/01/2026' and 
  --       data_pagto <= current_date
  -- ou       
  WHERE  extract (year from data_pagto) = 2026      ;     

7- Listar quantas consultas foram realizadas no mês de 
fevereiro, independente do ano
  SELECT count(*) 
  FROM   consulta
  WHERE  extract (month from data) = 02 and
         status = 'realizada';

8-Listar os pacientes e m?dicos de cada uma das consultas
  SELECT paciente.nome, medico.nome
  FROM   paciente INNER JOIN consulta ON 
         paciente.id_paciente  = consulta.id_paciente
         INNER JOIN medico ON  
          medico.id_medico = consulta.id_medico;
          
9-Listar consultas realidas (status = 'realizada')
-- paciente, data e valor
  SELECT paciente.nome, consulta.data, consulta.valor
  FROM   paciente INNER JOIN consulta ON paciente.id_paciente = consulta.id_paciente
  WHERE lower(consulta.status) = 'realizada';
      --transforma tudo em minusculo
      
10-Listar procedimentos realizados com nome do paiente
-- nome do paciente e do procedimento
  SELECT procedimento.id_procedimento, procedimento.nome_procd, paciente.nome
  FROM procedimento INNER JOIN consulta ON procedimento.id_consulta = consulta.id_consulta
  INNER JOIN paciente ON consulta.id_paciente = paciente.id_paciente;

11-Listar pagamentos com nome do paciente
-- id o valor do pagto
  SELECT pagamento.valor_pagto, paciente.nome
  FROM pagamento INNER JOIN consulta ON pagamento.id_consulta = consulta.id_consulta
  INNER JOIN paciente ON consulta.id_paciente = paciente.id_paciente;
  
12-Listar médico e sua especialidade, Liste 'todas' as especialidades
  SELECT m.nome, e.nome
  FROM medico m INNER JOIN medico_especialidade me ON me.id_medico = m.id_medico
  RIGHT JOIN especialidade e ON e.id_especialidade = me.id_especialidade;
  
13-Total pago por paiente (mostrar apenas quem pagou mais de 400)
  SELECT pa.nome, sum(p.valor_pagto), count(p.id_pagamento)
  FROM paciente pa INNER JOIN consulta c ON c.id_paciente = pa.id_paciente
  INNER JOIN pagamento p ON p.id_consulta = c.id_consulta
  group by pa.nome
  HAVING SUM(p.valor_pagto) > 400;
  
14-Quantidade de consultas por médico (mostrar apenas quem realizou mais de 1 consulta)
  SELECT count(id_consulta), m.nome
  FROM consulta INNER JOIN medico m ON consulta.id_medico = m.id_medico
  group by m.nome
  HAVING count(consulta.id_consulta) > 1;
  
15-Faturamento total por médico (mostrar acima de 300)
  SELECT sum(pg.valor_pagto), m.nome
  FROM medico m INNER JOIN consulta c ON c.id_medico = m.id_medico
  INNER JOIN pagamento pg ON pg.id_consulta = c.id_consulta
  group by m.nome
  HAVING sum(pg.valor_pagto) > 300;
  
  ---EXEMPLO PL/SQL
  --Bloco anônimo
  DECLARE -- seção declaração
    varNome VARCHAR2(25);
  BEGIN -- seção executavel
    varNome := 'UPF';
    DBMS_OUTPUT.PUT_LINE('Resultado => ' || varNome);
    EXCEPTION -- seção de exeções
      WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Temos um problema ');
  END;
  
  SET SERVEROUTPUT ON; -- ligar o funcionamento do comando DBMS
  SET SERVEROUTPUT OFF; -- Desligar o funcionamento do comando DBMS
  





