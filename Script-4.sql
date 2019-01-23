
CREATE TABLE Gender 
(
  genderId		INTEGER NOT NULL, 
  gender		VARCHAR(1000) NOT NULL
 );
CREATE UNIQUE INDEX Gender_genderId_IDX ON dev.Gender(genderId);

ALTER TABLE "Dev"."Gender" RENAME TO gender ;
ALTER TABLE dev.makemodelyeartrimbodystyle RENAME COLUMN "yearId" TO yearId ;

CREATE TABLE Age 
(
  ageId		INTEGER NOT NULL, 
  age		VARCHAR(1000) NOT NULL
 );
CREATE UNIQUE INDEX Age_ageId_IDX ON Dev.Age(ageId);


CREATE TABLE ConsumerAccount 
(
  consumerAccountID		INTEGER NOT NULL, 
  consumerId			INTEGER NOT NULL
 );
 CREATE UNIQUE INDEX Consumer_consumerId_IDX ON Dev.Consumer(consumerId);
 
CREATE TABLE Impression 
(
  impressionsCount     	INTEGER NOT NULL,
  makeName 				VARCHAR(1000) NOT NULL,
  odsMakeId     		INTEGER NOT NULL,
  modelName 			VARCHAR(1000) NOT NULL,
  odsModelId     		INTEGER NOT NULL,
  trimName 				VARCHAR(1000)  NULL,
  odsTrimId     		INTEGER  NULL,
  year 					VARCHAR(1000) NOT NULL,
  odsYearId     		INTEGER NOT NULL,  
  consumerAccountId		INTEGER NOT NULL
  );
 
  ALTER TABLE "Dev"."Impression" RENAME TO impression ;
  
  CREATE INDEX Impression_consumreAccountId_IDX ON dev.Impression(consumeraccountid);
  CREATE INDEX Impression_ODSMakeModelYearTrim_IDX ON Dev.Impression(odsMakeId, odsModelId, odsYearId, odsTrimId);
 
  
CREATE TABLE Consumer 
(
  consumerId     	INTEGER NOT NULL,
  publicConsumerId 	VARCHAR(1000) NOT NULL,
  personPartyID     VARCHAR(1000) NOT NULL,
  age     			INTEGER NOT NULL,
  gender  			INTEGER NOT NULL
);

CREATE UNIQUE INDEX Consumer_consumerId_IDX ON Dev.Consumer(consumerId);
 
CREATE TABLE MakeModelYearTrimBodystyle 
(
  makeId     	INTEGER NOT NULL,
  modelId     	INTEGER NOT NULL,
  yearId     	INTEGER NOT NULL,
  trimId     	INTEGER NOT NULL,
  bodyStyleId  	INTEGER NOT NULL,
  odsMakeId     INTEGER NOT NULL,
  odsModelId    INTEGER NOT NULL,
  odsYearId    	INTEGER NOT NULL,
  odsTrimId     INTEGER NOT NULL,
  odsBodyStyleId INTEGER NOT NULL
);

 CREATE UNIQUE INDEX MakeModelYearTrimBodystyle_IDX ON Dev.MakeModelYearTrimBodystyle(makeId, modelId, yearId, trimId, bodyStyleId);
 CREATE UNIQUE INDEX OdsMakeModelYearTrimBodystyle_IDX ON Dev.MakeModelYearTrimBodystyle(odsmakeId, odsmodelId, odsYearId, odsTrimId, odsBodystyleId);

 
CREATE TABLE MakeModelYearTrim
(
  makeId     	INTEGER NOT NULL,
  modelId     	INTEGER NOT NULL,
  yearId     	INTEGER NOT NULL,
  trimId     	INTEGER NOT NULL,
  odsMakeId     INTEGER NOT NULL,
  odsModelId    INTEGER NOT NULL,
  odsYearId    	INTEGER NOT NULL,
  odsTrimId     INTEGER NOT NULL
);

CREATE UNIQUE INDEX MakeModelYearTrim_IDX ON Dev.MakeModelYearTrim(makeId, modelId, yearId, trimId);

CREATE UNIQUE INDEX OdsMakeModelYearTrim_IDX ON Dev.MakeModelYearTrim(odsmakeId, odsmodelId, odsyearId, odstrimId);

CREATE TABLE MakeModelYear
(
  makeId     	INTEGER NOT NULL,
  modelId     	INTEGER NOT NULL,
  yearId     	INTEGER NOT NULL,
  odsMakeId     INTEGER NOT NULL,
  odsModelId    INTEGER NOT NULL,
  odsYearId    	INTEGER NOT NULL
);

CREATE UNIQUE INDEX MakeModelYear_IDX ON Dev.MakeModelYear(makeId, modelId, yearId);

CREATE UNIQUE INDEX odsmakemodelyear_idx on Dev.MakeModelYear(odsmakeId, odsmodelId, odsyearId);

CREATE TABLE MakeModel
(
  makeId     	INTEGER NOT NULL,
  modelId     	INTEGER NOT NULL,
  odsMakeId     INTEGER NOT NULL,
  odsModelId    INTEGER NOT NULL
);


CREATE UNIQUE INDEX MakeModel_IDX ON Dev.MakeModel(makeId, modelId);

CREATE TABLE BodyStyle
(
  bodyStyleId   INTEGER NOT NULL,
  odsId     	INTEGER NOT NULL,
  name			VARCHAR(1000) not NULL
);

CREATE UNIQUE INDEX Bodystyle_IDX ON Dev.BodyStyle(bodyStyleId);

CREATE UNIQUE INDEX Make_IDX ON Dev.Make(makeId);

CREATE TABLE Make
(
  makeId   		INTEGER NOT NULL,
  odsId     	INTEGER NOT NULL,
  name			VARCHAR(1000) not NULL
);
CREATE UNIQUE INDEX Make_IDX ON Dev.Make(makeId, name);

CREATE TABLE Model
(
  modelId   		INTEGER NOT NULL,
  odsId     	INTEGER NOT NULL,
  name			VARCHAR(1000) not NULL
);

CREATE UNIQUE INDEX Model_IDX ON Dev.Model(modelId, name);

CREATE TABLE Year
(
  yearId   		INTEGER NOT NULL,
  odsId     	INTEGER NOT NULL,
  name			VARCHAR(1000) not NULL
);

CREATE UNIQUE INDEX Year_IDX ON Dev.Year(yearId, name);

CREATE TABLE Trim
(
  trimId   		INTEGER NOT NULL,
  odsId     	INTEGER NOT NULL,
  name			VARCHAR(1000) not NULL
);

CREATE UNIQUE INDEX Trim_IDX ON Dev.Trim(trimId);


copy Impression from 's3://graphdb-poc/import/VDP-impressions.csv' 
credentials 'aws_access_key_id=AKIAI2JJE32L2S7MQC3Q;aws_secret_access_key=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'
delimiter ','
REMOVEQUOTES
IGNOREHEADER as 1
maxerror 1000;

select * from dev.Impression;

copy Make from 's3://graphdb-poc/import/make.csv' with
delimiter ',';
header 1;


--explain (analyse, buffers, verbose)
select 
mkr.name,
mdr.name,
yr.name,
SUM(ir.impressionsCount)
from Dev.Impression i 
inner join Dev.Consumer c on i.consumeraccountid=c.consumerid
inner join Dev.MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid
inner join Dev.Make mk on mmyt.makeid=mk.makeid
inner join Dev.Model md on mmyt.modelid=md.modelid
inner join Dev.Year y on mmyt.yearid=y.yearid
inner join Dev.Impression ir on c.consumerid=ir.consumeraccountid
inner join Dev.MakeModelYearTrimBodystyle mmytr on ir.odsmakeid=mmytr.odsmakeid 
and ir.odsmodelid=mmytr.odsmodelid 
and ir.odsyearid=mmytr.odsyearid 
and ir.odstrimid=mmytr.odstrimid
inner join Dev.Make mkr on mmytr.makeid=mkr.makeid
inner join Dev.Model mdr on mmytr.modelid=mdr.modelid
inner join Dev.Year yr on mmytr.yearid=yr.yearid
where mk.name='BMW' and md.name='X5' and y.name='2016'  and md.modelid<>mdr.modelid and y.name<=yr.name and mmytr.bodystyleid=mmyt.bodystyleid
group by 
mkr.name,
mdr.name,
yr.name
order by Sum(ir.impressionsCount) desc, mkr.name, mdr.name
limit 25
;

SET enable_seqscan = on;


--explain 
with cte (makeid, modelid, yearid, trimid, bodystyleid, 
			odsmakeid, odsmodelid, odsyearid, odstrimid, odsbodystyleid,
			makeName, modelName, yearName, consumerid) as (
	select 
		mmyt.makeid, mmyt.modelid, mmyt.yearid, mmyt.trimid, mmyt.bodystyleid, 
		mmyt.odsmakeid, mmyt.odsmodelid, mmyt.odsyearid, mmyt.odstrimid, mmyt.odsbodystyleid,
		mk.name as makename, md.name as modelname, y.name as yearname,
		i.consumeraccountid, i.impressionscount
	from
	Dev.impressionload300 i
	inner join Dev.MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
	and i.odsmodelid=mmyt.odsmodelid 
	and i.odsyearid=mmyt.odsyearid 
	and i.odstrimid=mmyt.odstrimid
	inner join Dev.Make mk on mmyt.makeid=mk.makeid
	inner join Dev.Model md on mmyt.modelid=md.modelid
	inner join Dev.Year y on mmyt.yearid=y.yearid
	)
select 
qr.makename,
qr.modelname,
qr.yearname,
SUM(qr.impressionsCount)
from
Dev.Consumer c 
inner join cte q on q.consumerid=c.consumerid 
inner join cte qr on qr.consumerid=c.consumerid
where q.makename='BMW' and q.modelname='X5' and q.yearname='2016'
  		and q.modelid<>qr.modelid and q.yearname<=qr.yearname and q.bodystyleid=qr.bodystyleid
group by 
qr.makename,
qr.modelname,
qr.yearname
order by Sum(qr.impressionsCount) desc, qr.makename, qr.modelname
limit 25
;


with cte (makeid, modelid, yearid, trimid, bodystyleid, 
			odsmakeid, odsmodelid, odsyearid, odstrimid, odsbodystyleid,
			makeName, modelName, yearName) as (
	select 
		mmyt.makeid, mmyt.modelid, mmyt.yearid, mmyt.trimid, mmyt.bodystyleid, 
		mmyt.odsmakeid, mmyt.odsmodelid, mmyt.odsyearid, mmyt.odstrimid, mmyt.odsbodystyleid,
		mk.name as makename, md.name as modelname, y.name as yearname
	from
	Dev.MakeModelYearTrimBodystyle mmyt  
	inner join Dev.Make mk on mmyt.makeid=mk.makeid
	inner join Dev.Model md on mmyt.modelid=md.modelid
	inner join Dev.Year y on mmyt.yearid=y.yearid
	)
select 
SUM(i.impressionsCount)
from cte q
inner join Dev.Impression i on i.odsmakeid=q.odsmakeid 
	and i.odsmodelid=q.odsmodelid 
	and i.odsyearid=q.odsyearid 
	and i.odstrimid=q.odstrimid
inner join Dev.consumer c on c.consumerid=i.consumeraccountid
inner join Dev.Impression ir on c.consumerid=ir.consumeraccountid
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

	
	
select 
mkr.name,
mdr.name,
yr.name,
COUNT(ir.impressionsCount)
from Dev.Impression i 
inner join Dev.Consumer c on i.consumeraccountid=c.consumerid
inner join Dev.MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid
inner join Dev.Make mk on mmyt.makeid=mk.makeid
inner join Dev.Model md on mmyt.modelid=md.modelid
inner join Dev.Year y on mmyt.yearid=y.yearid
inner join Dev.Impression ir on c.consumerid=ir.consumeraccountid
inner join Dev.MakeModelYearTrimBodystyle mmytr on ir.odsmakeid=mmytr.odsmakeid 
and ir.odsmodelid=mmytr.odsmodelid 
and ir.odsyearid=mmytr.odsyearid 
and ir.odstrimid=mmytr.odstrimid
inner join Dev.Make mkr on mmytr.makeid=mkr.makeid
inner join Dev.Model mdr on mmytr.modelid=mdr.modelid
inner join Dev.Year yr on mmytr.yearid=yr.yearid
where mk.name='BMW' and md.name='X5' and y.name='2016'  and md.modelid<>mdr.modelid and y.name<=yr.name and mmytr.bodystyleid=mmyt.bodystyleid
group by 
mkr.name,
mdr.name,
yr.name
order by COUNT(ir.impressionsCount) desc, mkr.name, mdr.name
limit 25
;

select 
count(c.consumerId)
from Dev.Impression i 
--inner join Dev.Consumer c on i.consumeraccountid=c.consumerid
inner join Dev.MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid;

select 
sum(i.impressionsCount)
from Dev.Impression i 
-- inner join Dev.Consumer c on i.consumeraccountid=c.consumerid
inner join Dev.MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid
where mk.name='BMW' and md.name='X5' and y.name='2016'
;

explain

select count(*) from dev.impression;

select sum(impressionsCount) from dev.impression;

analyze dev.Impression;
analyze dev.consumer;
analyze dev.makemodelyeartrimbodystyle;
analyze dev.make;
analyze dev.model;
analyze dev.year;
analyze dev.trim;

VACUUM FULL ANALYZE dev.impression;

SELECT relname, seq_scan-idx_scan AS too_much_seq, 
CASE WHEN seq_scan-idx_scan>0 THEN 'Missing Index?' 
ELSE 'OK' END, pg_relation_size(relname::regclass) AS rel_size, 
seq_scan, idx_scan 
FROM pg_stat_all_tables 
WHERE schemaname='public' 
AND pg_relation_size(relname::regclass)>80000 
ORDER BY too_much_seq DESC;


SELECT indexrelid::regclass as index, relid::regclass as table, 'DROP INDEX ' || indexrelid::regclass || ';' as drop_statement 
FROM pg_stat_user_indexes 
JOIN pg_index 
USING (indexrelid) 
WHERE idx_scan = 0 AND indisunique is false;

SELECT * FROM pg_stat_statements ORDER BY total_time DESC;


-- reload impressions

select * into dev.impressionLoad120 from dev.impression;

select count(*) from dev.impressionload;

select count(*) from  dev.impressionload120;

insert into dev.impression select * from dev.impressionload;

select count(*) from dev.impression;

CLUSTER TABLE dev.impression USING index_list_id;
ANALYZE dev.impression;

CREATE TABLE dev.ImpressionLoad300
(
  impressionsCount     	INTEGER NOT NULL,
  makeName 				VARCHAR(1000) NOT NULL,
  odsMakeId     		INTEGER NOT NULL,
  modelName 			VARCHAR(1000) NOT NULL,
  odsModelId     		INTEGER NOT NULL,
  trimName 				VARCHAR(1000)  NULL,
  odsTrimId     		INTEGER  NULL,
  year 					VARCHAR(1000) NOT NULL,
  odsYearId     		INTEGER NOT NULL,  
  consumerAccountId		INTEGER NOT NULL
  );

  
  insert into dev.Impressionload300 select * from dev.impression;
  
  select count(*) from dev.ImpressionLoad300;
  
  select count(*) from dev.ImpressionLoad500;

  
  CREATE INDEX ImpressionLoad300_consumreAccountId_IDX ON dev.ImpressionLoad300(consumeraccountid);
  CREATE INDEX ImpressionLoad300_ODSMakeModelYearTrim_IDX ON Dev.ImpressionLoad300(odsMakeId, odsModelId, odsYearId, odsTrimId);


CREATE TABLE dev.ImpressionLoad500
(
  impressionsCount     	INTEGER NOT NULL,
  makeName 				VARCHAR(1000) NOT NULL,
  odsMakeId     		INTEGER NOT NULL,
  modelName 			VARCHAR(1000) NOT NULL,
  odsModelId     		INTEGER NOT NULL,
  trimName 				VARCHAR(1000)  NULL,
  odsTrimId     		INTEGER  NULL,
  year 					VARCHAR(1000) NOT NULL,
  odsYearId     		INTEGER NOT NULL,  
  consumerAccountId		INTEGER NOT NULL
  );

  
  insert into dev.impressionload500 select * from dev.impression;
  insert into dev.impressionload500 select * from dev.impression;
  insert into dev.impressionload500 select * from dev.impression;
  insert into dev.impressionload500 select * from dev.impression;
  insert into dev.impressionload500 select * from dev.impression;
  insert into dev.impressionload500 select * from dev.impression;
  insert into dev.impressionload500 select * from dev.impression;
  insert into dev.impressionload500 select * from dev.impression;
  insert into dev.impressionload500 select * from dev.impression;
  insert into dev.impressionload500 select * from dev.impression;

  
  CREATE INDEX ImpressionLoad500_consumreAccountId_IDX ON dev.ImpressionLoad500(consumeraccountid);
  CREATE INDEX ImpressionLoad500_ODSMakeModelYearTrim_IDX ON Dev.ImpressionLoad500(odsMakeId, odsModelId, odsYearId, odsTrimId);

