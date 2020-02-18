/*	
	Damian Smugorzewski
	GR 3
	299263
*/

CREATE TRIGGER dbo.TR_wypozyczenie_insert ON Wypozyczenie FOR INSERT
AS
UPDATE Tytul 
	SET ile_dostepnych = ile_dostepnych - x.tot_per_tyt 
	FROM Tytul join (SELECT w.id_tyt, SUM(w.ilosc_wyp) AS tot_per_tyt 
						FROM INSERTED w
						GROUP BY w.id_tyt 
					) x ON (x.id_tyt = Tytul.id_tyt)
GO



CREATE TRIGGER dbo.TR_zwroty_insert ON Zwroty FOR INSERT
AS
UPDATE Tytul 
	SET ile_dostepnych = ile_dostepnych + x.tot_per_tyt 
	FROM Tytul join (SELECT w.id_tyt, SUM(w.ilosc_zwr) AS tot_per_tyt 
						FROM INSERTED w
						GROUP BY w.id_tyt 
					) x ON (x.id_tyt = Tytul.id_tyt)
GO


CREATE TRIGGER dbo.TR_tytul_zabezpieczenie ON Tytul FOR UPDATE
AS
	IF EXISTS (SELECT * FROM INSERTED 
	WHERE ile_dostepnych < 0)
	BEGIN 
	RAISERROR('Liczba dostepnych ksiazek mniejsza niz 0', 16, 3)
	ROLLBACK TRAN
	END

	IF EXISTS (SELECT * FROM INSERTED 
	WHERE ile_dostepnych > ile_kupiono)
	BEGIN 
	RAISERROR('Liczba dostepnych ksiazek wieksza niz liczba kupionych', 16, 3)
	ROLLBACK TRAN
	END
GO



/*
Zawartość tabeli Tytuły na początku
id_tyt      ile_kupiono ile_dostepnych opis
----------- ----------- -------------- ------------------------------------------------------------
1           12          12             X
2           10          10             Y
3           5           5              Z
4           4           4              A
5           7           7              B
6           8           8              C
7           9           9              D


	INSERT INTO Wypozyczenie(id_kli, id_tyt, ilosc_wyp ) 
	SELECT 1, 4, 2
	UNION ALL
	SELECT 1, 4, 1
	UNION ALL
	SELECT 2, 5, 3

Zawartość tabeli po wypożyczeniu
id_tyt      ile_kupiono ile_dostepnych opis
----------- ----------- -------------- ------------------------------------------------------------
1           12          12             X
2           10          10             Y
3           5           5              Z
4           4           1              A
5           7           4              B
6           8           8              C
7           9           9              D


	INSERT INTO Zwroty(id_kli, id_tyt, ilosc_zwr ) 
	SELECT 1, 4, 2
	UNION ALL
	SELECT 1, 4, 1
	UNION ALL
	SELECT 2, 5, 3

Po zwrocie:
id_tyt      ile_kupiono ile_dostepnych opis
	----------- ----------- -------------- ------------------------------------------------------------
1           12          12             X
2           10          10             Y
3           5           5              Z
4           4           4              A
5           7           7              B
6           8           8              C
7           9           9              D


Test zabezpieczenia:
Próba wypożyczenia zbyt dużej liczby książek wyświetla komunikat:
"Liczba dostepnych ksiazek mniejsza niz 0"
i anuluje transakcję.

Próba zwrotu zbyt dużej liczby książek wyświetla komunikat:
"Liczba dostepnych ksiazek wieksza niz liczba kupionych"
i anuluje transakcję.
*/