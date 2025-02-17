use restaurante;

create view resumo_pedido as
select p.id_pedido as id_pedido,
	   p.quantidade as quantidade_pedido,
       p.data_pedido as data_pedido,
       c.nome as nome,
       c.email as email,
       f.nome as func_nome,
       pr.nome as prod_nome,
       pr.preco as prod_preco
from pedidos p
join clientes c on c.id_cliente = p.id_cliente
join funcionarios f on p.id_funcionario = f.id_funcionario
join produtos pr on p.id_produto = pr.id_produto;

select id_pedido, nome, sum(quantidade_pedido * prod_preco) as total_pedido
from resumo_pedido
group by id_pedido, nome;

alter view resumo_pedido as
select
    p.id_pedido as id_pedido,
    p.quantidade as quantidade_pedido,
    p.data_pedido as data_pedido,
    c.nome as nome,
    c.email as email,
    f.nome as func_nome,
    pr.nome as prod_nome,
    pr.preco as prod_preco,
    (p.quantidade * pr.preco) as total
from
    pedidos p
inner join
    clientes c on c.id_cliente = p.id_cliente
inner join
    funcionarios f on p.id_funcionario = f.id_funcionario
inner join
    produtos pr on p.id_produto = pr.id_produto;

select id_pedido, nome, sum(total) as total_adicionado
from resumo_pedido
group by id_pedido, nome;

explain
select id_pedido, nome, sum(total) as total_adicionado
from resumo_pedido
group by id_pedido, nome;

delimiter //
create function BuscaIngredientesProduto(id_produto_param int)
returns text
reads sql data
begin
    declare ingredientes_produto text;
    select group_concat(ingredientes separator ', ') into ingredientes_produto
    from info_produtos
    where id_produto = id_produto_param;
    if ingredientes_produto is null then
        return 'Ingredientes não encontrados para este produto.';
    end if;
    return ingredientes_produto;
end //
delimiter ;

select BuscaIngredientesProduto(10);

delimiter //
create function mediaPedido(id_pedido_param int)
returns varchar(255)
reads sql data
begin
    declare total_pedido decimal(10,2);
    declare media_pedidos decimal(10,2);
    declare mensagem varchar(255);

    select sum(total) into total_pedido
    from resumo_pedido
    where id_pedido = id_pedido_param
    group by id_pedido;
    
    select avg(total_pedido) into media_pedidos
    from (select sum(total) as total_pedido from resumo_pedido group by id_pedido) as subquery;

    if total_pedido is null then
        return 'Pedido não encontrado.';
    end if;
    
    if total_pedido > media_pedidos then
        set mensagem = 'O total do pedido está ACIMA da média dos pedidos.';
    elseif total_pedido < media_pedidos then
        set mensagem = 'O total do pedido está ABAIXO da média dos pedidos.';
    else
        set mensagem = 'O total do pedido é IGUAL à média dos pedidos.';
    end if;
    return mensagem;
end //
delimiter ;

select mediaPedido(5);
select mediaPedido(6);