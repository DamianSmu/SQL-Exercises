/* --------------- 1 -----------------*/

SELECT wojp.nazwa as wojpracy, wojz.nazwa as wojzamieszkania INTO #A
FROM osoby o
JOIN miasta mz  ON (mz.id_miasta = o.id_miasta)
JOIN woj wojz ON (wojz.kod_woj = mz.kod_woj)
JOIN etaty e ON (e.id_osoby = o.id_osoby)
JOIN firmy f ON (e.id_firmy = f.nazwa_skr)
JOIN miasta mp ON (mp.id_miasta = f.id_miasta)
JOIN woj wojp ON (wojp.kod_woj = mp.kod_woj)
WHERE e.pensja BETWEEN 1000 AND 20000 AND NOT (wojp.kod_woj = wojz.kod_woj)


SELECT DISTINCT * FROM #A


/* --------------- 2 -----------------*/

SELECT e.id_osoby, COUNT(*) as ileet INTO #B
FROM etaty e
GROUP BY e.id_osoby


SELECT o.imiê_i_nazwisko, B.ileet FROM osoby o
JOIN #B B ON (B.id_osoby = o.id_osoby)
WHERE B.ileet = (SELECT MAX(B.ileet) FROM #B B)


/* --------------- 3 -----------------*/

SELECT o.imiê_i_nazwisko FROM osoby o
WHERE NOT EXISTS (	SELECT * FROM etaty ew
					JOIN firmy fw ON (fw.nazwa_skr = ew.id_firmy)
					WHERE o.id_osoby = ew.id_osoby AND fw.nazwa LIKE '$Politechnika%')
					
	
	
		
		
