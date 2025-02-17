use restaurante;

select sum(id_pedido) as quantidade_pedidos from pedidos;

select count(distinct id_cliente) as total_clientes_unicos from pedidos;

select round(avg(preco),2) as media_preco from produtos;

select min(preco) from produtos;
select max(preco) from produtos;

select nome, preco, row_number() over (order by preco desc) as ranking_preço from produtos limit 5;

select categoria, round(avg(preco),2) as media_preco from produtos group by categoria;

select fornecedor, count(*) as quantidade_produtos from info_produtos group by fornecedor;

select fornecedor, count(id_produto) as quantidade_produtos from info_produtos group by fornecedor having count(id_produto) > 1;

select id_cliente, count(id_pedido) as quantidade_pedidos from pedidos group by id_cliente having count(id_pedido) = 1;