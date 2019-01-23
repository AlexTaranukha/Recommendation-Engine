explain
select 
count(i.impressionsCount)
from Dev.Impression i 
--inner join Dev.Consumer c on i.consumeraccountid=c.consumerid
inner join Dev.MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
and i.odsmodelid=mmyt.odsmodelid 
and i.odsyearid=mmyt.odsyearid 
and i.odstrimid=mmyt.odstrimid
inner join Dev.Make mk on mmyt.makeid=mk.makeid
inner join Dev.Model md on mmyt.modelid=md.modelid
inner join Dev.Year y on mmyt.yearid=y.yearid
where mk.name='BMW' and md.name='X5' and y.name='2016'
;

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
	Dev.Impression i
	inner join Dev.MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
	and i.odsmodelid=mmyt.odsmodelid 
	and i.odsyearid=mmyt.odsyearid 
	and i.odstrimid=mmyt.odstrimid
	inner join Dev.Make mk on mmyt.makeid=mk.makeid
	inner join Dev.Model md on mmyt.modelid=md.modelid
	inner join Dev.Year y on mmyt.yearid=y.yearid
	)
select 
SUM(qr.impressionsCount)
from cte qr
where  qr.makename='BMW' and qr.modelname='X5' and qr.yearname='2016';

explain
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
from cte qr
inner join Dev.Impression i on i.odsmakeid=qr.odsmakeid and i.odsmodelid=qr.odsmodelid 
	and i.odsyearid=qr.odsyearid 
	and i.odstrimid=qr.odstrimid
where  qr.makename='BMW' and qr.modelname='X5' and qr.yearname='2016';


	select 
		mmyt.makeid, mmyt.modelid, mmyt.yearid, mmyt.trimid, mmyt.bodystyleid, 
		mmyt.odsmakeid, mmyt.odsmodelid, mmyt.odsyearid, mmyt.odstrimid, mmyt.odsbodystyleid,
		mk.name as makename, md.name as modelname, y.name as yearname,
		c.consumerid
	from
	Dev.Consumer c 
	inner join Dev.Impression i on i.consumeraccountid=c.consumerid
	inner join Dev.MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
	and i.odsmodelid=mmyt.odsmodelid 
	and i.odsyearid=mmyt.odsyearid 
	and i.odstrimid=mmyt.odstrimid
	inner join Dev.Make mk on mmyt.makeid=mk.makeid
	inner join Dev.Model md on mmyt.modelid=md.modelid
	inner join Dev.Year y on mmyt.yearid=y.yearid

	select 
		mmyt.makeid, mmyt.modelid, mmyt.yearid, mmyt.trimid, mmyt.bodystyleid, 
		mmyt.odsmakeid, mmyt.odsmodelid, mmyt.odsyearid, mmyt.odstrimid, mmyt.odsbodystyleid,
		mk.name as makename, md.name as modelname, y.name as yearname,
		c.consumerid
	from
	Dev.Consumer c 
	inner join Dev.Impression i on i.consumeraccountid=c.consumerid
	inner join Dev.MakeModelYearTrimBodystyle mmyt on i.odsmakeid=mmyt.odsmakeid 
	and i.odsmodelid=mmyt.odsmodelid 
	and i.odsyearid=mmyt.odsyearid 
	and i.odstrimid=mmyt.odstrimid
	inner join Dev.Make mk on mmyt.makeid=mk.makeid
	inner join Dev.Model md on mmyt.modelid=md.modelid
	inner join Dev.Year y on mmyt.yearid=y.yearid
	where mk.name='BMW' and md.name='X5' and y.name='2016';