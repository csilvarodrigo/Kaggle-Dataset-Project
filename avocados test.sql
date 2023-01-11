
use bancodeteste;
create table abacate (
id int not null auto_increment,
Num varchar (5) not null,
Date_ref date not null,
AveragePrice decimal (10,2) not null,
TotalVolume decimal (10,2) not null,
Plu4046 decimal (10,2) not null,
Plu4225 decimal (10,2) not null,
Plu4770 decimal (10,2) not null,
TotalBags decimal (10,2) not null,
SmallBags decimal (10,2) not null,
LargeBags decimal (10,2) not null,
XLargeBags decimal (10,2) not null,
TypeAvocado varchar (80) not null,
YearAvocado varchar (80) not null,
Region varchar (80) not null,
primary key (id)
);
select * from abacate;


load data infile 'C:/Program Files/MySQL/avocado.csv'
into table abacate
fields terminated by ','
lines terminated by '\n'
ignore 1 rows (Num, Date_ref, AveragePrice, TotalVolume, Plu4046, Plu4225, Plu4770, TotalBags, SmallBags, LargeBags, XLargeBags, TypeAvocado, YearAvocado,  Region);

alter table abacate
drop column Num;

select * from abacate
limit 70;

select distinct Region from abacate;

-- media

select avg (AveragePrice)
from abacate
where YearAvocado = 2016 and Region = "NewYork";

-- selecionando colunas

select AveragePrice, TypeAvocado, YearAvocado, Region from abacate
limit 200;

select distinct TypeAvocado from abacate;

select avg(AveragePrice)
from abacate
where TypeAvocado = "conventional";

select avg(AveragePrice)
from abacate
where TypeAvocado = "organic";

-- arredondando a media com 2 casas decimais

select round(avg(AveragePrice), 2)
from abacate
where TypeAvocado = "organic";

# agregando funçoes - media por ano

select YearAvocado,
	round (avg(AveragePrice), 2)
from abacate
group by YearAvocado
order by YearAvocado;

-- agregando funçoes - media por ano e tipo de abacate= convencional
select YearAvocado,
	round (avg(AveragePrice), 2)
from abacate
where TypeAvocado = "conventional" 
group by YearAvocado
order by YearAvocado;

-- agregando funçoes - media por ano e tipo de abacate
select YearAvocado, TypeAvocado,
	round(avg(AveragePrice),2)
from abacate
group by 1,2;