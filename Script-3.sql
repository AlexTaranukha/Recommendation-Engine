CREATE TABLE Gender 
(
  genderId		INTEGER NOT NULL, 
  gender		VARCHAR(1000) NOT NULL
 );
CREATE UNIQUE INDEX Gender_genderId_IDX ON Gender(genderId);

CREATE TABLE Age 
(
  ageId		INTEGER NOT NULL, 
  age		VARCHAR(1000) NOT NULL
 );
CREATE UNIQUE INDEX Age_ageId_IDX ON Age(ageId);
 
CREATE TABLE ConsumerAccount 
(
  consumerAccountID		INTEGER NOT NULL, 
  consumerId			INTEGER NOT NULL
 );
 CREATE UNIQUE INDEX Consumer_consumerId_IDX ON Consumer(consumerId);
 
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
 
 CREATE INDEX Impression_consumreAccountId_IDX ON Impression(consumerAccountId);
 CREATE INDEX Impression_ODSMakeModelYearTrim_IDX ON Impression(odsMakeId, odsModelId, odsYearId, odsTrimId);
  
CREATE TABLE Consumer 
(
  consumerId     	INTEGER NOT NULL,
  publicConsumerId 	VARCHAR(1000) NOT NULL,
  personPartyID     VARCHAR(1000) NOT NULL,
  age     			INTEGER NOT NULL,
  gender  			INTEGER NOT NULL
);

CREATE UNIQUE INDEX Consumer_consumerId_IDX ON Consumer(consumerId);
 
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

CREATE UNIQUE INDEX MakeModelYearTrimBodystyle_IDX ON MakeModelYearTrimBodystyle(makeId, modelId, yearId, trimId, bodyStyleId);

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

CREATE UNIQUE INDEX MakeModelYearTrim_IDX ON MakeModelYearTrim(makeId, modelId, yearId, trimId);

CREATE UNIQUE INDEX MakeModelYearTrimBodystyle_IDX ON MakeModelYearTrimBodystyle(makeId, modelId, yearId, trimId, bodyStyleId);
CREATE UNIQUE INDEX ODSMakeModelYearTrimBodystyle_IDX ON MakeModelYearTrimBodystyle(odsMakeId, odsModelId, odsYearId, odsTrimId, odsBodystyleId);


CREATE TABLE MakeModelYear
(
  makeId     	INTEGER NOT NULL,
  modelId     	INTEGER NOT NULL,
  yearId     	INTEGER NOT NULL,
  odsMakeId     INTEGER NOT NULL,
  odsModelId    INTEGER NOT NULL,
  odsYearId    	INTEGER NOT NULL
);

CREATE UNIQUE INDEX MakeModelYear_IDX ON MakeModelYear(makeId, modelId, yearId);
CREATE UNIQUE INDEX ODSMakeModelYear_IDX ON MakeModelYear(odsMakeId, odsModelId, odsYearId);


CREATE TABLE MakeModel
(
  makeId     	INTEGER NOT NULL,
  modelId     	INTEGER NOT NULL,
  odsMakeId     INTEGER NOT NULL,
  odsModelId    INTEGER NOT NULL
);


CREATE UNIQUE INDEX MakeModel_IDX ON MakeModel(makeId, modelId);

CREATE TABLE BodyStyle
(
  bodyStyleId   INTEGER NOT NULL,
  odsId     	INTEGER NOT NULL,
  name			VARCHAR(1000) not NULL
);

CREATE UNIQUE INDEX Bodystyle_IDX ON BodyStyle(bodyStyleId);

CREATE UNIQUE INDEX Make_IDX ON Make(makeId);

CREATE TABLE Make
(
  makeId   		INTEGER NOT NULL,
  odsId     	INTEGER NOT NULL,
  name			VARCHAR(1000) not NULL
);
CREATE UNIQUE INDEX Model_IDX ON Model(modelId);

CREATE TABLE Model
(
  modelId   		INTEGER NOT NULL,
  odsId     	INTEGER NOT NULL,
  name			VARCHAR(1000) not NULL
);

CREATE TABLE Year
(
  yearId   		INTEGER NOT NULL,
  odsId     	INTEGER NOT NULL,
  name			VARCHAR(1000) not NULL
);

CREATE UNIQUE INDEX Year_IDX ON Year(yearId);

CREATE TABLE Trim
(
  trimId   		INTEGER NOT NULL,
  odsId     	INTEGER NOT NULL,
  name			VARCHAR(1000) not NULL
);

CREATE UNIQUE INDEX Trim_IDX ON Dev.Trim(trimId);

GRANT LOAD FROM S3 ON *.* TO master_user;

-- SQL Error [1871] [HY000]: S3 API returned error: Both aurora_load_from_s3_role and aws_default_s3_role are not specified, please see documentation for more details
--  java.sql.SQLException: S3 API returned error: Both aurora_load_from_s3_role and aws_default_s3_role are not specified, please see documentation for more details


load data from S3 's3://graphdb-poc/import/VDP-impressions.csv'
into table Impression
fields terminated by ','
enclosed by '"'
ignore 1 lines;


select count(*) from Impression;


select 
mkr.name,
mdr.name,
yr.name,
SUM(ir.impressionsCount)
from Consumer c 
inner join Impression i on i.consumeraccountid=c.consumerid
inner join MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid
inner join Make mk on mmyt.makeid=mk.makeid
inner join Model md on mmyt.modelid=md.modelid
inner join Year y on mmyt.yearid=y.yearid
inner join Impression ir on c.consumerid=ir.consumeraccountid
inner join MakeModelYearTrimBodystyle mmytr on ir.odsmakeid=mmytr.odsmakeid 
and ir.odsmodelid=mmytr.odsmodelid 
and ir.odsyearid=mmytr.odsyearid 
and ir.odstrimid=mmytr.odstrimid
inner join Make mkr on mmytr.makeid=mkr.makeid
inner join Model mdr on mmytr.modelid=mdr.modelid
inner join Year yr on mmytr.yearid=yr.yearid
where mk.name='BMW' and md.name='X5' and y.name='2016'  and md.modelid<>mdr.modelid and y.name<=yr.name and mmytr.bodystyleid=mmyt.bodystyleid
group by 
mkr.name,
mdr.name,
yr.name
order by Sum(ir.impressionsCount) desc, mkr.name, mdr.name
limit 25
;

explain extended
select 
mkr.name,
mdr.name,
yr.name,
SUM(ir.impressionsCount)
from Impression i 
inner join Consumer c on i.consumeraccountid=c.consumerid
inner join MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid
inner join Make mk on mmyt.makeid=mk.makeid
inner join Model md on mmyt.modelid=md.modelid
inner join Year y on mmyt.yearid=y.yearid
inner join Impression ir on c.consumerid=ir.consumeraccountid
inner join MakeModelYearTrimBodystyle mmytr on ir.odsmakeid=mmytr.odsmakeid 
and ir.odsmodelid=mmytr.odsmodelid 
and ir.odsyearid=mmytr.odsyearid 
and ir.odstrimid=mmytr.odstrimid
inner join Make mkr on mmytr.makeid=mkr.makeid
inner join Model mdr on mmytr.modelid=mdr.modelid
inner join Year yr on mmytr.yearid=yr.yearid
where mk.name='BMW' and md.name='X5' and y.name='2016'  and md.modelid<>mdr.modelid and y.name<=yr.name and mmytr.bodystyleid=mmyt.bodystyleid
group by 
mkr.name,
mdr.name,
yr.name
order by Sum(ir.impressionsCount) desc, mkr.name, mdr.name
limit 25
;


select 
mkr.name,
mdr.name,
yr.name,
COUNT(ir.impressionsCount)
from Impression i 
inner join Consumer c on i.consumeraccountid=c.consumerid
inner join MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid
inner join Make mk on mmyt.makeid=mk.makeid
inner join Model md on mmyt.modelid=md.modelid
inner join Year y on mmyt.yearid=y.yearid
inner join Impression ir on c.consumerid=ir.consumeraccountid
inner join MakeModelYearTrimBodystyle mmytr on ir.odsmakeid=mmytr.odsmakeid 
and ir.odsmodelid=mmytr.odsmodelid 
and ir.odsyearid=mmytr.odsyearid 
and ir.odstrimid=mmytr.odstrimid
inner join Make mkr on mmytr.makeid=mkr.makeid
inner join Model mdr on mmytr.modelid=mdr.modelid
inner join Year yr on mmytr.yearid=yr.yearid
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
from Impression i 
inner join Consumer c on i.consumeraccountid=c.consumerid
inner join MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid;


select 
sum(i.impressionsCount)
from Dev.Impression i 
inner join Dev.Consumer c on i.consumeraccountid=c.consumerid
inner join Dev.MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid;


explain

select count(*) from Impression;

select count(*) from Dev.Consumer;

select count(*) from MakeModelYearTrimBodystyle;

select count(*) from Make;

select count(*) from Model;

select count(*) from Year;

select count(*) from Trim;

select count(*) from BodyStyle;

select sum(impressionsCount) from Dev.Impression;

select * into dev.impressionLoad120 from dev.impression;

select count(*) from dev.impressionload;

insert into dev.impression select * from dev.impressionload;



-- reload impressions

select * into ImpressionLoad120 from Impression;

select count(*) from Dev.ImpressionLoad;

insert into Dev.Impression select * from Dev.ImpressionLoad;

select count(*) from Dev.Impression;



