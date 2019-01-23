
drop table age;
CREATE TABLE public.age (
	ageid int4 NOT NULL,
	age int4 NOT NULL
)
diststyle all
sortkey (ageid);

copy age from 's3://graphdb-poc/import/age.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;

drop table bodystyle;
CREATE TABLE public.bodystyle (
	bodystyleid int4 NOT NULL,
	odsid int4 NOT NULL,
	name varchar(1000) NOT NULL
) 
diststyle all
sortkey(bodystyleid);

copy bodystyle from 's3://graphdb-poc/import/bodyStyle.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;

drop table consumer;
CREATE TABLE public.consumer (
	consumerid int4 NOT NULL,
	publicconsumerid varchar(1000) NOT NULL,
	personpartyid int4 NOT NULL,
	age int4 NOT NULL,
	gender int4 NOT NULL
) 
--diststyle all
diststyle key distkey(consumerId)
sortkey(consumerid);

copy consumer from 's3://graphdb-poc/import/consumer.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;


drop table consumeraccount;
CREATE TABLE public.consumeraccount (
	consumeraccountid int4 NOT NULL,
	consumerid int4 NOT NULL
) 
diststyle key distkey(consumerId)
sortkey(consumerid);

copy consumeraccount from 's3://graphdb-poc/import/consumer-account.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;


drop table gender;
CREATE TABLE public.gender (
	genderid int4 NOT NULL,
	gender varchar(1000) NOT NULL
) 
diststyle all
sortkey (genderId);

copy gender from 's3://graphdb-poc/import/gender.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;


drop table impression;
CREATE TABLE public.impression (
	impressionscount int4 NOT NULL,
	makename varchar(1000) NOT NULL,
	odsmakeid int4 NOT NULL,
	modelname varchar(1000) NOT NULL,
	odsmodelid int4 NOT NULL,
	trimname varchar(1000),
	odstrimid int4,
	year varchar(1000) NOT NULL,
	odsyearid int4 NOT NULL,
	consumeraccountid int4 NOT NULL
) 
diststyle key distkey(consumerAccountId)
sortkey(consumerAccountId, odsmakeid, odsmodelid, odsyearid, odstrimid);



copy Impression from 's3://graphdb-poc/import/VDP-impressions.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;

select count(*) from impression;


drop table make;
CREATE TABLE public.make (
	makeid int4 NOT NULL,
	odsid int4 NOT NULL,
	name varchar(1000) NOT NULL
) 
diststyle all
sortkey (makeId);


copy Make from 's3://graphdb-poc/import/make.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;


drop table makemodel;
CREATE TABLE public.makemodel (
	makeid int4 NOT NULL,
	modelid int4 NOT NULL,
	odsmakeid int4 NOT NULL,
	odsmodelid int4 NOT NULL
) 
diststyle all
sortkey (makeId, modelId);

copy MakeModel from 's3://graphdb-poc/import/makeModel.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;

drop table makemodelyear;
CREATE TABLE public.makemodelyear (
	makeid int4 NOT NULL,
	modelid int4 NOT NULL,
	yearid int4 NOT NULL,
	odsmakeid int4 NOT NULL,
	odsmodelid int4 NOT NULL,
	odsyearid int4 NOT NULL
) 
diststyle all
sortkey (makeId, modelId, yearId);


copy MakeModelYear from 's3://graphdb-poc/import/makeModelYear.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;


drop table makemodelyeartrim;;
CREATE TABLE public.makemodelyeartrim (
	makeid int4 NOT NULL,
	modelid int4 NOT NULL,
	yearid int4 NOT NULL,
	trimid int4 NOT NULL,
	odsmakeid int4 NOT NULL,
	odsmodelid int4 NOT NULL,
	odsyearid int4 NOT NULL,
	odstrimid int4 NOT NULL
) 
diststyle all
sortkey (makeId, modelId, yearId, trimId);


copy MakeModelYearTrim from 's3://graphdb-poc/import/makeModelYearTrim.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;


drop table makemodelyeartrimbodystyle;
CREATE TABLE public.makemodelyeartrimbodystyle (
	makeid int4 NOT NULL,
	modelid int4 NOT NULL,
	yearid int4 NOT NULL,
	trimid int4 NOT NULL,
	bodystyleid int4 NOT NULL,
	odsmakeid int4 NOT NULL,
	odsmodelid int4 NOT NULL,
	odsyearid int4 NOT NULL,
	odstrimid int4 NOT NULL,
	odsbodystyleid int4 NOT NULL
) 
diststyle all
sortkey (makeId, modelId, yearId, bodyStyleId);


copy MakeModelYearTrimBodystyle from 's3://graphdb-poc/import/makeModelYearTrimBodystyle.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;


drop table model;
CREATE TABLE public.model (
	modelid int4 NOT NULL,
	odsid int4 NOT NULL,
	name varchar(1000) NOT NULL
) 
diststyle all
sortkey (modelId);

copy Model from 's3://graphdb-poc/import/model.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;



drop table trim;
CREATE TABLE public.trim (
	trimid int4 NOT NULL,
	odsid int4 NOT NULL,
	name varchar(1000) NOT NULL
) 
diststyle all
sortkey (trimId);;


copy Trim from 's3://graphdb-poc/import/trim.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;

drop table year;
CREATE TABLE year (
	yearid int4 NOT NULL,
	odsid int4 NOT NULL,
	name varchar(1000) NOT NULL
) 
diststyle all
sortkey (yearId);;


copy Year from 's3://graphdb-poc/import/year.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;



Select top 1000 * from Make;

select count(*) from Make;

select * from stl_load_errors;

select top 1000 * from public.impressionload500;

select * from public.impressionload500 where consumeraccountid=150 and odsmakeid=20005 and odsmodelid=56067 and odstrimid=23139 and odsyearid=51683;

update public.impressionload500 set impressionscount=1 where consumeraccountid=150 and odsmakeid=20005 and odsmodelid=56067 and odstrimid=23139 and odsyearid=51683; 

select * from Make where odsid=20005;

select 
count(c.consumerId)
from ImpressionLoad300 i 
inner join Consumer c on i.consumeraccountid=c.consumerid
inner join MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid;
inner join Make mk on mmyt.makeid=mk.makeid
inner join Model md on mmyt.modelid=md.modelid
inner join Year y on mmyt.yearid=y.yearid;


select 
mkr.name,
mdr.name,
yr.name,
SUM(ir.impressionsCount)
from consumer c 
inner join impression i on i.consumeraccountid=c.consumerid
inner join makemodelyeartrimbodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid
inner join make mk on mmyt.makeid=mk.makeid
inner join model md on mmyt.modelid=md.modelid
inner join year y on mmyt.yearid=y.yearid
inner join impression ir on c.consumerid=ir.consumeraccountid
inner join makemodelyeartrimbodystyle mmytr on ir.odsmakeid=mmytr.odsmakeid 
and ir.odsmodelid=mmytr.odsmodelid 
and ir.odsyearid=mmytr.odsyearid 
and ir.odstrimid=mmytr.odstrimid
inner join make mkr on mmytr.makeid=mkr.makeid
inner join model mdr on mmytr.modelid=mdr.modelid
inner join year yr on mmytr.yearid=yr.yearid
where mk.name='BMW' and md.name='X5' and y.name=2017 and md.modelid<>mdr.modelid and y.name<=yr.name and mmytr.bodystyleid=mmyt.bodystyleid
group by 
mkr.name,
mdr.name,
yr.name
order by Sum(ir.impressionsCount) desc, mkr.name, mdr.name
limit 25
;



--explain
select 
mkr.name,
mdr.name,
yr.name,
SUM(ir.impressionsCount)
from consumer c 
inner join impression i on i.consumeraccountid=c.consumerid
inner join makemodelyeartrimbodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid
inner join make mk on mmyt.makeid=mk.makeid
inner join model md on mmyt.modelid=md.modelid
inner join year y on mmyt.yearid=y.yearid
inner join impression ir on c.consumerid=ir.consumeraccountid
inner join makemodelyeartrimbodystyle mmytr on ir.odsmakeid=mmytr.odsmakeid 
and ir.odsmodelid=mmytr.odsmodelid 
and ir.odsyearid=mmytr.odsyearid 
and ir.odstrimid=mmytr.odstrimid
inner join make mkr on mmytr.makeid=mkr.makeid
inner join model mdr on mmytr.modelid=mdr.modelid
inner join year yr on mmytr.yearid=yr.yearid
where mk.name='BMW' and md.name='X5' and y.name=2017  and md.modelid<>mdr.modelid and y.name<=yr.name and mmytr.bodystyleid=mmyt.bodystyleid
group by 
mkr.name,
mdr.name,
yr.name
order by Sum(ir.impressionsCount) desc, mkr.name, mdr.name
limit 25
;



--explain 
with cte (makeid, modelid, yearid, trimid, bodystyleid, 
			odsmakeid, odsmodelid, odsyearid, odstrimid, odsbodystyleid,
			makeName, modelName, yearName, consumerid, impressionscount) as (
	select 
		mmyt.makeid, mmyt.modelid, mmyt.yearid, mmyt.trimid, mmyt.bodystyleid, 
		mmyt.odsmakeid, mmyt.odsmodelid, mmyt.odsyearid, mmyt.odstrimid, mmyt.odsbodystyleid,
		mk.name as makename, md.name as modelname, y.name as yearname,
		i.consumeraccountid, i.impressionscount
	from
		Impression i
		inner join MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
			and i.odsmodelid=mmyt.odsmodelid 
			and i.odsyearid=mmyt.odsyearid 
			and i.odstrimid=mmyt.odstrimid
		inner join Make mk on mmyt.makeid=mk.makeid
		inner join Model md on mmyt.modelid=md.modelid
		inner join Year y on mmyt.yearid=y.yearid
	)
select 
	qr.makename,
	qr.modelname,
	qr.yearname,
	SUM(qr.impressionsCount)
from
	Consumer c 
	inner join cte q on q.consumerid=c.consumerid 
	inner join cte qr on qr.consumerid=c.consumerid
	where q.makename='Audi' and q.modelname='Q7' and q.yearname='2017'
	  		and q.modelid<>qr.modelid and q.yearname<=qr.yearname and q.bodystyleid=qr.bodystyleid
group by 
qr.makename,
qr.modelname,
qr.yearname
order by Sum(qr.impressionsCount) desc, qr.makename, qr.modelname
limit 25
;


--explain 
with cte (makeid, modelid, yearid, trimid, bodystyleid, 
			odsmakeid, odsmodelid, odsyearid, odstrimid, odsbodystyleid,
			makeName, modelName, yearName, consumerid, impressionscount) as (
	select 
		mmyt.makeid, mmyt.modelid, mmyt.yearid, mmyt.trimid, mmyt.bodystyleid, 
		mmyt.odsmakeid, mmyt.odsmodelid, mmyt.odsyearid, mmyt.odstrimid, mmyt.odsbodystyleid,
		mk.name as makename, md.name as modelname, y.name as yearname,
		i.consumeraccountid, i.impressionscount
	from
		Impression i
		inner join MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
			and i.odsmodelid=mmyt.odsmodelid 
			and i.odsyearid=mmyt.odsyearid 
			and i.odstrimid=mmyt.odstrimid
		inner join Make mk on mmyt.makeid=mk.makeid
		inner join Model md on mmyt.modelid=md.modelid
		inner join Year y on mmyt.yearid=y.yearid
	)
select 
	qr.makename,
	qr.modelname,
	qr.yearname,
	SUM(qr.impressionsCount)
from
	cte q
	inner join cte qr on qr.consumerid=q.consumerid
	where q.makename='BMW' and q.modelname='X5' and q.yearname=2017
	  		--and q.modelid<>qr.modelid 
	  		and q.yearname<=qr.yearname and q.bodystyleid=qr.bodystyleid
group by 
qr.makename,
qr.modelname,
qr.yearname
order by Sum(qr.impressionsCount) desc, qr.makename, qr.modelname
limit 25
;





select 
mkr.name,
mdr.name,
yr.name,
COUNT(ir.impressionsCount)
from impression i 
inner join consumer c on i.consumeraccountid=c.consumerid
inner join makemodelyeartrimbodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid
inner join make mk on mmyt.makeid=mk.makeid
inner join model md on mmyt.modelid=md.modelid
inner join year y on mmyt.yearid=y.yearid
inner join impression ir on c.consumerid=ir.consumeraccountid
inner join makemodelyeartrimbodystyle mmytr on ir.odsmakeid=mmytr.odsmakeid 
and ir.odsmodelid=mmytr.odsmodelid 
and ir.odsyearid=mmytr.odsyearid 
and ir.odstrimid=mmytr.odstrimid
inner join make mkr on mmytr.makeid=mkr.makeid
inner join model mdr on mmytr.modelid=mdr.modelid
inner join year yr on mmytr.yearid=yr.yearid
where mk.name='BMW' and md.name='X5' and y.name=2017  and md.modelid<>mdr.modelid and y.name<=yr.name and mmytr.bodystyleid=mmyt.bodystyleid
group by 
mkr.name,
mdr.name,
yr.name
order by COUNT(ir.impressionsCount) desc, mkr.name, mdr.name
limit 25
;

select 
sum(i.impressionsCount)
from Impression i 
inner join Consumer c on i.consumeraccountid=c.consumerid
inner join MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid;

select count(*) from impression;

select count(*) from consumer;

select count(*) from MakeModelYearTrimBodyStyle;

select count(*) from Make;

select count(*) from Model;

select count(*) from Year;

select count(*) from Trim;

select count(*) from BodyStyle;

select sum(impressionsCount) from impression;



--truncate table Year;

--delete from Year;


copy Year from 's3://graphdb-poc/import/year.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;


-- drop table year;

CREATE TABLE year (
	yearid int4 NOT NULL,
	odsid int4 NOT NULL,
	name varchar(1000) NOT NULL
) 
diststyle all;

select relname, reldiststyle, * from pg_class
where relowner != 1
order by relname;

select "table", encoded, diststyle, sortkey1, skew_sortkey1, skew_rows, stats_off
from svv_table_info
order by 1;

SELECT database, schema || '.' || "table" AS "table", stats_off 
FROM svv_table_info 
WHERE stats_off > 5 
ORDER BY 2;

SELECT COUNT(*) FROM (
SELECT DISTINCT query FROM stl_scan 
WHERE tbl = [table_id] AND type = 2 AND userid > 1
INTERSECT
(SELECT DISTINCT query FROM stl_hashjoin
UNION
SELECT DISTINCT query FROM stl_nestloop
UNION
SELECT DISTINCT query FROM stl_mergejoin));


-- reload impressions

insert into impression select * from impressionload60;

select count(*) from impressionload60;

select count(*) from impressionload120;

select count(*) from impressionload240;

--select * into impressionload240 from impressionload120;

select count(*) from impression;



analyze impression;

analyze impressionload60;

analyze impressionload120;

analyze impressionload240;

analyze makemodelyeartrimbodystyle;
analyze consumer;
analyze make;
analyze model;
analyze year;
analyze trim;
analyze bodystyle;


drop table impressionload60;
CREATE TABLE public.impressionload60 (
	impressionscount int4 NOT NULL,
	makename varchar(1000) NOT NULL,
	odsmakeid int4 NOT NULL,
	modelname varchar(1000) NOT NULL,
	odsmodelid int4 NOT NULL,
	trimname varchar(1000),
	odstrimid int4,
	year varchar(1000) NOT NULL,
	odsyearid int4 NOT NULL,
	consumeraccountid int4 NOT NULL
) 
diststyle even
sortkey(consumerAccountId, odsmakeid, odsmodelid, odsyearid, odstrimid);



drop table impressionload120;
CREATE TABLE public.impressionload120 (
	impressionscount int4 NOT NULL,
	makename varchar(1000) NOT NULL,
	odsmakeid int4 NOT NULL,
	modelname varchar(1000) NOT NULL,
	odsmodelid int4 NOT NULL,
	trimname varchar(1000),
	odstrimid int4,
	year varchar(1000) NOT NULL,
	odsyearid int4 NOT NULL,
	consumeraccountid int4 NOT NULL
) 
diststyle key distkey(consumerAccountId)
sortkey(consumerAccountId, odsmakeid, odsmodelid, odsyearid, odstrimid);



drop table impressionload240;
CREATE TABLE public.impressionload240 (
	impressionscount int4 NOT NULL,
	makename varchar(1000) NOT NULL,
	odsmakeid int4 NOT NULL,
	modelname varchar(1000) NOT NULL,
	odsmodelid int4 NOT NULL,
	trimname varchar(1000),
	odstrimid int4,
	year varchar(1000) NOT NULL,
	odsyearid int4 NOT NULL,
	consumeraccountid int4 NOT NULL
) 
diststyle key distkey(consumerAccountId)
sortkey(consumerAccountId, odsmakeid, odsmodelid, odsyearid, odstrimid);


select count(*) from public.impressionload300;

CREATE TABLE public.impressionLoad300 (
	impressionscount int4 NOT NULL,
	makename varchar(1000) NOT NULL,
	odsmakeid int4 NOT NULL,
	modelname varchar(1000) NOT NULL,
	odsmodelid int4 NOT NULL,
	trimname varchar(1000),
	odstrimid int4,
	year varchar(1000) NOT NULL,
	odsyearid int4 NOT NULL,
	consumeraccountid int4 NOT NULL
) 
diststyle key distkey(consumerAccountId)
sortkey(consumerAccountId, odsmakeid, odsmodelid, odsyearid, odstrimid);

insert into public.impressionload300 select * from public.impression;


drop table public.impressionLoad500;


CREATE TABLE public.impressionLoad500 (
	impressionscount int4 NOT NULL,
	makename varchar(1000) NOT NULL,
	odsmakeid int4 NOT NULL,
	modelname varchar(1000) NOT NULL,
	odsmodelid int4 NOT NULL,
	trimname varchar(1000),
	odstrimid int4,
	year varchar(1000) NOT NULL,
	odsyearid int4 NOT NULL,
	consumeraccountid int4 NOT NULL
) 
diststyle key distkey(consumerAccountId)
sortkey(consumerAccountId, odsmakeid, odsmodelid, odsyearid, odstrimid);

  
  insert into public.impressionload500 select * from public.impression;
  insert into public.impressionload500 select * from public.impression;
  insert into public.impressionload500 select * from public.impression;
  insert into public.impressionload500 select * from public.impression;
  insert into public.impressionload500 select * from public.impression;
  insert into public.impressionload500 select * from public.impression;
  insert into public.impressionload500 select * from public.impression;
  insert into public.impressionload500 select * from public.impression;
  insert into public.impressionload500 select * from public.impression;
  insert into public.impressionload500 select * from public.impression;

select count(*) from public.impressionload500;

/*
--explain 
with cte (makeid, modelid, yearid, trimid, bodystyleid, 
			odsmakeid, odsmodelid, odsyearid, odstrimid, odsbodystyleid,
			makeName, modelName, yearName, consumerid) as (
	select 
		mmyt.makeid, mmyt.modelid, mmyt.yearid, mmyt.trimid, mmyt.bodystyleid, 
		mmyt.odsmakeid, mmyt.odsmodelid, mmyt.odsyearid, mmyt.odstrimid, mmyt.odsbodystyleid,
		mk.name as makename, md.name as modelname, y.name as yearname,
		c.consumerid
	from
	Consumer c 
	inner join Impression i on i.consumeraccountid=c.consumerid
	inner join MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
	and i.odsmodelid=mmyt.odsmodelid 
	and i.odsyearid=mmyt.odsyearid 
	and i.odstrimid=mmyt.odstrimid
	inner join Make mk on mmyt.makeid=mk.makeid
	inner join Model md on mmyt.modelid=md.modelid
	inner join Year y on mmyt.yearid=y.yearid
	where mk.name='BMW' and md.name='X5' and y.name='2016'
	)
select 
mkr.name,
mdr.name,
yr.name,
SUM(ir.impressionsCount)
from 
cte q 
inner join Impression ir on q.consumerid=ir.consumeraccountid
inner join MakeModelYearTrimBodystyle mmytr on ir.odsmakeid=mmytr.odsmakeid 
and ir.odsmodelid=mmytr.odsmodelid 
and ir.odsyearid=mmytr.odsyearid 
and ir.odstrimid=mmytr.odstrimid
inner join Make mkr on mmytr.makeid=mkr.makeid
inner join Model mdr on mmytr.modelid=mdr.modelid
inner join Year yr on mmytr.yearid=yr.yearid
where  q.modelid<>mdr.modelid and q.yearname<=yr.name and q.bodystyleid=mmytr.bodystyleid
group by 
mkr.name,
mdr.name,
yr.name
order by Sum(ir.impressionsCount) desc, mkr.name, mdr.name
limit 25
;
*/


/*
with cte (makeid, modelid, yearid, trimid, bodystyleid, 
			odsmakeid, odsmodelid, odsyearid, odstrimid, odsbodystyleid,
			makeName, modelName, yearName) as (
	select 
		mmyt.makeid, mmyt.modelid, mmyt.yearid, mmyt.trimid, mmyt.bodystyleid, 
		mmyt.odsmakeid, mmyt.odsmodelid, mmyt.odsyearid, mmyt.odstrimid, mmyt.odsbodystyleid,
		mk.name as makename, md.name as modelname, y.name as yearname
	from
	MakeModelYearTrimBodystyle mmyt  
	inner join Make mk on mmyt.makeid=mk.makeid
	inner join Model md on mmyt.modelid=md.modelid
	inner join Year y on mmyt.yearid=y.yearid
	)
select 
qr.makename,
qr.modelname,
qr.yearname,
SUM(ir.impressionsCount)
from cte q
inner join Impression i on i.odsmakeid=q.odsmakeid 
	and i.odsmodelid=q.odsmodelid 
	and i.odsyearid=q.odsyearid 
	and i.odstrimid=q.odstrimid
inner join consumer c on c.consumerid=i.consumeraccountid
inner join Impression ir on c.consumerid=ir.consumeraccountid
inner join cte qr on ir.odsmakeid=qr.odsmakeid 
	and ir.odsmodelid=qr.odsmodelid 
	and ir.odsyearid=qr.odsyearid 
	and ir.odstrimid=qr.odstrimid
where q.makename='BMW' and q.modelname='X5' and q.yearname='2016'
  		and q.modelid<>qr.modelid and q.yearname<=qr.yearname and q.bodystyleid=qr.bodystyleid
group by 
qr.makename,
qr.modelname,
qr.yearname
order by Sum(ir.impressionsCount) desc, qr.makename, qr.modelname
limit 25
;
*/
