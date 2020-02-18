/* ALTER TABLE osoby ADD data_ur datetime NULL*/

UPDATE osoby SET data_ur = CONVERT(datetime, '19851108',112 /*YYYYMMDD*/)
WHERE id_osoby = 1

UPDATE osoby SET data_ur = CONVERT(datetime, '19890306',112 /*YYYYMMDD*/)
WHERE id_osoby = 2

UPDATE osoby SET data_ur = CONVERT(datetime, '19700108',112 /*YYYYMMDD*/)
WHERE id_osoby = 3

UPDATE osoby SET data_ur = CONVERT(datetime, '19440805',112 /*YYYYMMDD*/)
WHERE id_osoby = 4

UPDATE osoby SET data_ur = CONVERT(datetime, '19990806',112 /*YYYYMMDD*/)
WHERE id_osoby = 5

UPDATE osoby SET data_ur = CONVERT(datetime, '19751120',112 /*YYYYMMDD*/)
WHERE id_osoby = 6

UPDATE osoby SET data_ur = CONVERT(datetime, '19950203',112 /*YYYYMMDD*/)
WHERE id_osoby = 7

UPDATE osoby SET data_ur = CONVERT(datetime, '19890504',112 /*YYYYMMDD*/)
WHERE id_osoby = 8

UPDATE osoby SET data_ur = CONVERT(datetime, '19740606',112 /*YYYYMMDD*/)
WHERE id_osoby = 9

UPDATE osoby SET data_ur = CONVERT(datetime, '20010405',112 /*YYYYMMDD*/)
WHERE id_osoby = 10

UPDATE osoby SET data_ur = CONVERT(datetime, '20050607',112 /*YYYYMMDD*/)
WHERE id_osoby = 11


Select * from osoby


alter table osoby drop column wiek

ALTER TABLE osoby ADD wiek AS datediff(yy, data_ur, getdate())
select o.imiê, o.nazwisko, CONVERT(char(10),o.data_ur,103) AS data_ur_f, o.wiek from osoby o where o.wiek is not null







SELECT osoby.imiê, osoby.nazwisko, osoby.wiek, miasta.nazwa AS miasto FROM osoby
JOIN miasta ON (miasta.id_miasta = osoby.id_miasta)
JOIN (SELECT MIN(x.wiek) minwiek from osoby x) M on (M.minwiek = osoby.wiek)





SELECT o.imiê_i_nazwisko, e.pensja, e.stanowisko, e.do, mz.nazwa as miastozamieszkania, mp.nazwa as miastopracy FROM osoby o
JOIN etaty e ON (o.id_osoby = e.id_osoby)
JOIN firmy f ON (f.nazwa_skr = e.id_firmy)
JOIN miasta mp ON (f.id_miasta = mp.id_miasta)
JOIN miasta mz ON (mz.id_miasta = o.id_miasta)
JOIN (
SELECT MIN(ew.pensja) as minp FROM etaty ew 
JOIN firmy f ON (ew.id_firmy = f.nazwa_skr)
WHERE ew.do is null AND f.id_miasta = 2
) J ON (e.pensja = J.minp)
WHERE e.do is null AND f.id_miasta = 2








