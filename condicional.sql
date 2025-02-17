use restaurante;

select * from pedidos
where id_funcionario = 4 and status_pedido = 'Pendente';

select * from pedidos
where not status_pedido = 'Concluído';

select * from pedidos
where id_produto in(1, 2, 3, 5, 7, 8);

select * from clientes
where nome like 'C%' limit 2;

select * from info_produtos
where ingredientes like '%Frango%' or ingredientes like '%Carne%';

select nome, preco from produtos
where preco between 20 and 30;

select id_pedido, status_pedido, nullif(status_pedido, 'NULL') from pedidos;

select * from pedidos
where status_pedido is null;

select id_pedido, status_pedido, ifnull(status_pedido, 'Cancelado') from pedidos;

select nome, cargo, salario,
if(salario > 3000, 'Acima da média', 'Abaixo da média') as media_salario from funcionarios;