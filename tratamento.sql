#Mapa de Dados

#Vendas em Potencial

#Client ID: ID único de cada cliente
#Area: área construída por ano, em metro quadrado. 
#Year: ano
#BRL_Potencial: estimativa de potencial máximo de vendas por cliente.

#Vendas

#Client ID: ID único de cada cliente
#Categoria: categorias de produto. 
#Subcategoria: indica as subcategorias de produto. São 10 ao todo. Cada subcategoria pertence a apenas uma categoria.
#Produto: produto específico sendo vendido para o cliente na transação específica.
#Year: ano
#Month: mês
#Cidade: cidade do cliente
#Valor: valor de vendas realizadas. 
#Volume: volume do produto vendido (pode ser kg ou litros).

#Criar tabelas finais no delta lake
#Delta Lake é uma camada de armazenamento que oferece confiabilidade, segurança e desempenho em seu data lake.
#Se houver erro neste comando depois de realizar o clone do cluster, execute os comandos acima para limpar o DBFS

create table tbvendas_final (Client_ID int, Categoria string, Subcategoria string, Produto string, Ano int, Mes int, Cidade string, Valor double, Volume double);
Create table tbpotencial_final (Client_ID int, Ano int, Area_Comercial double, Area_Hibrida double, Area_Residencial double, Area_Industrial double, ValorPotencial double);

#Inserindo dados a partir da tabela original
insert into tbvendas_final (Client_ID, Categoria , SubCategoria , Produto , Ano , Mes , Cidade , Valor , Volume)
select replace(Client_ID,'Client #','') ,Categoria,SubCategoria,Produto,Year,Month,Cidade,Valor,Volume from tbvendas where year in ('2020', '2021','2022')

insert into tbpotencial_final (Client_ID , Ano , Area_Comercial , Area_Hibrida , Area_Residencial , Area_Industrial , ValorPotencial)
select replace(Client_ID,'Client #',''),    Year, Area_Comercial, Area_Hibrida, Area_Residencial, Area_Industrial, BRL_Potencial from tbpotencial

#Validando dados nulos
Select *
from tbvendas_final 
where isnull(`Client_ID`) = true
or isnull(`Categoria`) = true
or isnull(`Subcategoria`) = true
or isnull(`Produto`) = true
or isnull(`Ano`) = true
or isnull(`Mes`) = true
or isnull(`Cidade`) = true
or isnull(`Valor`) = true
or isnull(`Volume`) = true

#Deletando dados nulos
delete from tbvendas_final 
where isnull(`Client_ID`) = true
or isnull(`Categoria`) = true
or isnull(`Subcategoria`) = true
or isnull(`Produto`) = true
or isnull(`Ano`) = true
or isnull(`Mes`) = true
or isnull(`Cidade`) = true
or isnull(`Valor`) = true
or isnull(`Volume`) = true

#Validando dados nulos
Select count(1)
from tbpotencial_final 
where isnull(`Client_ID`) = true
or isnull(`Ano`) = true
or isnull(`Area_Comercial`) = true
or isnull(`Area_Hibrida`) = true
or isnull(`Area_Residencial`) = true
or isnull(`Area_Industrial`) = true
or isnull(`ValorPotencial`) = true

#Validando subcategorias
select  subcategoria, count(1) as Qtde from tbvendas_final group by subcategoria

#Deletando subcategoria indevida
delete from tbvendas_final where subcategoria = 'Sub-Categoria 99'

#Validando vinculo de subcategoria a categoria
select count(distinct Categoria) as Qtde, subcategoria from tbvendas_final group by subcategoria having count(distinct Categoria) > 1

select distinct Categoria, Subcategoria from tbvendas_final where Subcategoria in ('Sub-Categoria 8','Sub-Categoria 7') order by 2

select Categoria, Subcategoria, count(1) from tbvendas_final where Categoria in ('XTZ250','XT660','CB750') group by Categoria, Subcategoria order by 1

#Deletendo vinculos indevidos
delete from tbvendas_final where categoria = 'XT660' and subcategoria= 'Sub-Categoria 8';
delete from tbvendas_final where categoria = 'XTZ250' and subcategoria= 'Sub-Categoria 7';
