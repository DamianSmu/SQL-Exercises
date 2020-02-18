/* Damian Smugorzewski 299263 GR3 */


IF OBJECT_ID('etaty') IS NOT NULL
DROP TABLE etaty

IF OBJECT_ID('firmy') IS NOT NULL
DROP TABLE firmy

IF OBJECT_ID('osoby') IS NOT NULL
DROP TABLE osoby

IF OBJECT_ID('miasta') IS NOT NULL
DROP TABLE miasta

IF OBJECT_ID('woj') IS NOT NULL
DROP TABLE woj



create table [dbo].woj 
(	kod_woj 	char(3) 	not null 	
	constraint pk_woj primary key
,	nazwa 		varchar(30) 	not null
)

GO

insert into woj values ('MAZ', 'Mazowieckie')
insert into woj values ('POM', 'Pomorskie')
insert into woj values ('PKR', 'Podkarpackie')
insert into woj values ('M£P', 'Ma³opolskie')


create table [dbo].miasta 
(	id_miasta 	int 		not null identity 
	constraint pk_miasta primary key
,	kod_woj 	char(3) 	not null 
	constraint fk_miasta__woj foreign key 
	references woj(kod_woj)
,	nazwa 		varchar(30) 	not null
)

GO

DECLARE @id_wwa int
,	@id_wes int
,	@id_gda int
,	@id_sop	int
,	@id_gdy int
,	@id_mal int
,	@id_rad int
,	@id_oka int
,	@id_krk int
,	@id_wad int
,	@id_wie int
,	@id_ms	int
,	@id_jk	int
,	@id_jn	int
,	@id_kn	int
,	@id_br1 int
,	@id_br	int
,	@id_am	int
,	@id_mn	int
,	@id_ab	int
,	@id_ac	int
,	@id_ad	int
,	@id_ae	int
,	@id_bb	int
,	@id_bc	int
,	@id_ba	int


insert into miasta (kod_woj, nazwa) values ('MAZ', 'WESO£A')
SET @id_wes = SCOPE_IDENTITY()
insert into miasta (kod_woj, nazwa) values ('MAZ', 'WARSZAWA')
SET @id_wwa = SCOPE_IDENTITY()
insert into miasta (kod_woj, nazwa) values ('MAZ', 'RADOM')
SET @id_rad = SCOPE_IDENTITY()
insert into miasta (kod_woj, nazwa) values ('MAZ', 'OSTRO£ÊKA')

SET @id_oka = SCOPE_IDENTITY()
insert into miasta (kod_woj, nazwa) values ('POM', 'GDAÑSK')
SET @id_gda = SCOPE_IDENTITY()
insert into miasta (kod_woj, nazwa) values ('POM', 'SOPOT')
SET @id_sop = SCOPE_IDENTITY()
insert into miasta (kod_woj, nazwa) values ('POM', 'GDYNIA')
SET @id_gdy = SCOPE_IDENTITY()
insert into miasta (kod_woj, nazwa) values ('POM', 'MALBORK')
SET @id_mal = SCOPE_IDENTITY()

insert into miasta (kod_woj, nazwa) values ('M£P', 'KRAKÓW')
SET @id_krk = SCOPE_IDENTITY()
insert into miasta (kod_woj, nazwa) values ('M£P', 'WADOWICE')
SET @id_wad = SCOPE_IDENTITY()
insert into miasta (kod_woj, nazwa) values ('M£P', 'WIELICZKA')
SET @id_wie = SCOPE_IDENTITY()


create table [dbo].osoby 
(	id_osoby	int 		not null identity
	constraint pk_osoby primary key
,	id_miasta	int 		not null
	constraint fk_osoby__miasta foreign key
	references miasta(id_miasta)
,	imiê		varchar(20) 	not null
,	nazwisko	varchar(30) 	not null
,	imiê_i_nazwisko as convert(char(24),left(imiê,1)+'. ' + nazwisko)
)



insert into osoby (imiê, nazwisko, id_miasta) values ('Maciej', 'Stodolski', @id_wwa)
SET @id_ms = SCOPE_IDENTITY()

insert into osoby (imiê, nazwisko, id_miasta) values ('Jacek', 'Korytkowski', @id_wwa)
SET @id_jk = SCOPE_IDENTITY()

insert into osoby (imiê, nazwisko, id_miasta) values ('Mis', 'Nieznany', @id_wwa)
SET @id_mn = SCOPE_IDENTITY()

insert into osoby (imiê, nazwisko, id_miasta) values ('Król', 'Neptun', @id_wwa)
set @id_kn = SCOPE_IDENTITY()

insert into osoby (imiê, nazwisko, id_miasta) values ('Ju¿', 'Niepracuj¹cy', @id_wwa)
SET @id_jn = SCOPE_IDENTITY()



insert into osoby (imiê, nazwisko, id_miasta) values ('Jan', 'Kowalski', @id_oka)
SET @id_ab = SCOPE_IDENTITY()

insert into osoby (imiê, nazwisko, id_miasta) values ('Adam', 'Nowowski', @id_oka)
SET @id_ac = SCOPE_IDENTITY()

insert into osoby (imiê, nazwisko, id_miasta) values ('Bartosz', 'D¹browski', @id_oka)
SET @id_ad = SCOPE_IDENTITY()

insert into osoby (imiê, nazwisko, id_miasta) values ('Jakub', 'Gutowski', @id_oka)
SET @id_ae = SCOPE_IDENTITY()


insert into osoby (imiê, nazwisko, id_miasta) values ('Krzysztof', 'Nowak', @id_gda)
SET @id_ba = SCOPE_IDENTITY()

insert into osoby (imiê, nazwisko, id_miasta) values ('£ukasz', 'Wiœniewski', @id_gda)
SET @id_bb = SCOPE_IDENTITY()



create table [dbo].firmy 
(	nazwa_skr	char(3) 	not null
	constraint pk_firmy primary key
,	id_miasta	int 		not null
	constraint fk_firmy__miasta foreign key
	references miasta(id_miasta)
,	nazwa		varchar(60) 	not null
,	kod_pocztowy	char(6)		not null
,	ulica		varchar(60)	not null
)


insert into firmy 
(	nazwa_skr
,	nazwa
,	id_miasta
,	kod_pocztowy
,	ulica
) values 
(	'HP'
, 	'Hewlett Packard'
,	@id_wwa
,	'00-000'
,	'Szturmowa 2a'
)

insert into firmy 
(	nazwa_skr
,	nazwa
,	id_miasta
,	kod_pocztowy
,	ulica
) values 
(	'PW'
,	'Politechnika Warszawska'
,	@id_wwa
,	'00-000'
,	'Pl. Politechniki 1'
)

insert into firmy 
(	nazwa_skr
,	nazwa
,	id_miasta
,	kod_pocztowy
,	ulica
) values 
(	'F£P'
,	'Fabryka £odzi Podwodnych'
,	@id_wwa
,	'00-000'
,	'Na dnie 4'
)

insert into firmy 
(	nazwa_skr
,	nazwa
,	id_miasta
,	kod_pocztowy
,	ulica
) values 
(	'UW'
,	'Uniwersytet Warszawski'
,	@id_wwa
,	'00-000'
,	'Tu i tam 6'
)

insert into firmy 
(	nazwa_skr
,	nazwa
,	id_miasta
,	kod_pocztowy
,	ulica
) values 
(	'NN'
,	'Inna S.A.'
,	@id_gda
,	'00-000'
,	'Gdzieœ 2'
)

create table [dbo].etaty 
(	id_osoby 	int 		not null 
	constraint fk_etaty__osoby 
	foreign key references osoby(id_osoby)
,	id_firmy 	char(3) 	not null 
	constraint fk_etaty__firmy 
	foreign key references firmy(nazwa_skr)
,	stanowisko	varchar(60)	not null
,	pensja 		money 		not null
,	od 		datetime 	not null
,	do 		datetime 	null
,	id_etatu 	int 		not null identity 
	constraint pk_etaty primary key
	)
	
	insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	do
,	stanowisko
) values 
(	@id_ms
,	'PW'
,	600
,	convert(datetime,'19940101',112)
,	convert(datetime,'19980101',112)
,	'Doktorant'
)

insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	do
,	stanowisko
) values 
(	@id_ms
,	'PW'
,	1600
,	convert(datetime,'19980102',112)
,	convert(datetime,'20000101',112)
,	'Asystent'
)

insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	stanowisko
) values 
(	@id_ms
,	'PW'
,	3200
,	convert(datetime,'20000102',112)
,	'Adjunkt'
)

insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	stanowisko
) values 
(	@id_ms
,	'PW'
,	2200
,	convert(datetime,'19990101',112)
,	'Sprz¹tacz'
)

insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	stanowisko
) values 
(	@id_ms
,	'HP'
,	20000
,	convert(datetime,'20000101',112)
,	'Konsultant'
)

insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	stanowisko
) values 
(	@id_jk
,	'PW'
,	3200
,	convert(datetime,'20011110',112)
,	'Adjunkt'
)


insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	stanowisko
,	do
) values 
(	@id_jk
,	'PW'
,	4200
,	convert(datetime,'20040922',112)
,	'Magazynier'
,	convert(datetime,'20041022',112)
)

insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	stanowisko
,	do
) values 
(	@id_jk
,	'HP'
,	50000
,	convert(datetime,'20000101',112)
,	'Dyrektor'
,	convert(datetime,'20021021',112)
)

insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	stanowisko
,	do
) values 
(	@id_jk
,	'F£P'
,	6200
,	convert(datetime,'20040922',112)
,	'Kierownik'
,	convert(datetime,'20041022',112)
)

insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	stanowisko
) values 
(	@id_kn
,	'F£P'
,	65200
,	convert(datetime,'20041023',112)
,	'Prezes'
)

insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	stanowisko
,	do
) values 
(	@id_kn
,	'NN'
,	65200
,	convert(datetime,'20181023',112)
,	'Pracownik'
,	convert(datetime,'20190108',112)
)

insert into etaty 
(	id_osoby
,	id_firmy
,	pensja
,	od
,	stanowisko
) values 
(	@id_kn
,	'NN'
,	3520
,	convert(datetime,'20081023',112)
,	'Web developer'
)


/*
SELECT * FROM osoby
SELECT * FROM firmy
SELECT * FROM etaty

SELECT e.pensja, e.id_firmy, o.imiê_i_nazwisko, m.*, w.nazwa AS [nazwa woj]
FROM miasta m, woj w, osoby o, etaty e
WHERE
(w.kod_woj = m.kod_woj)
AND (o.id_miasta = m.id_miasta)
AND (e.id_osoby = o.id_osoby)

SELECT e.pensja, e.id_firmy, o.imiê_i_nazwisko, mo.nazwa AS [mia os]
, wo.nazwa AS [woj os], f.nazwa AS nazwa_fi, mf.nazwa as [miasto fi]
FROM miasta mo, woj wo , osoby o, etaty e
, firmy f, miasta mf , woj wf
WHERE
(wo.kod_woj = mo.kod_woj)
AND (o.id_miasta = mo.id_miasta)
AND (e.id_osoby = o.id_osoby
)AND (e.id_firmy = f.nazwa_skr
AND (f.id_miasta = mf.id_miasta)
AND (mf.kod_woj = wf.kod_woj)
*/