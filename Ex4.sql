/* Damian Smugorzewski 
**
**
** napisaæ procedurê która
** Jako parametr kod_woj oraz min_pensja
** w Podanym woj wyszuka osoby i liczby etatow
** tylko osob ktore nie maj¹ pensji mniejszej niz min_pensja
** procedura pokaze osobê z najwieksz¹ liczb¹ etatów
*/


CREATE PROCEDURE dbo.procedura (@kod_woj varchar(40), @min int )
AS

SELECT ow.id_osoby ,COUNT(ew.id_etatu) as ileet, SUM(ew.pensja) as sumapensji 
	INTO #A
	FROM etaty ew
	JOIN firmy fw ON (fw.nazwa_skr = ew.id_firmy)
	JOIN osoby ow ON (ew.id_osoby = ow.id_osoby)
	JOIN miasta mw ON (fw.id_miasta = mw.id_miasta)
	JOIN woj ww ON (mw.kod_woj = ww.kod_woj)
	WHERE ww.kod_woj = @kod_woj
	GROUP BY ow.id_osoby
	HAVING SUM(ew.pensja) >= @min

	
SELECT o.imiê_i_nazwisko, J.maxet as [ile etatów], A.sumapensji as [suma pensji] FROM #A A
	JOIN osoby o ON (A.id_osoby = o.id_osoby)
	JOIN (
	SELECT MAX(#A.ileet) as maxet FROM #A
		 ) J ON (A.ileet = J.maxet)	
GO

EXEC procedura @kod_woj = 'MAZ', @min = 30000



