use restaurante;

select produtos.id_produto, produtos.nome, produtos.descricao, info_produtos.ingredientes
from produtos
inner join info_produtos on produtos.id_produto = info_produtos.id_produto;

select p.id_pedido, p.quantidade, p.data_pedido, c.nome, c.email
from pedidos p
inner join clientes c on p.id_pedido = c.id_cliente;

select p.id_pedido, p.quantidade, p.data_pedido, c.nome, c.email, f.nome
from pedidos p
inner join clientes c on c.id_cliente = p.id_cliente
inner join funcionarios f on p.id_funcionario = f.id_funcionario;

select p.id_pedido, p.quantidade, p.data_pedido, c.nome, c.email, f.nome, pr.nome, pr.preco
from pedidos p
inner join clientes c on c.id_cliente = p.id_cliente
inner join funcionarios f on p.id_funcionario = f.id_funcionario
inner join produtos pr on p.id_produto = pr.id_produto;

select c.nome, p.status_pedido, p.id_pedido
from clientes c
inner join pedidos p on c.id_cliente = p.id_cliente
where p.status_pedido = 'Pendente'
order by id_pedido desc;

select c.nome, p.id_pedido
from clientes c
left join pedidos p on c.id_cliente = p.id_cliente
where p.id_pedido is null;

select nome,
	(select count(*) from pedidos where pedidos.id_cliente = clientes.id_cliente) as total_pedidos
    from clientes;
    
SELECT p.id_pedido, SUM(p.quantidade * pr.preco) as preco_total
FROM pedidos p
inner join produtos pr on p.id_produto = pr.id_produto
GROUP BY p.id_pedido;