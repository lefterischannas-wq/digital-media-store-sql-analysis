-- 1. Artists with more than 10 albums using a View
CREATE VIEW ArtistAlbumCount AS
SELECT ArtistId, COUNT(AlbumId) AS AlbumCount
FROM ALBUM
GROUP BY ArtistId;

SELECT ARTIST.Name AS "Καλλιτέχνης/Συγκρότημα",
       ArtistAlbumCount.AlbumCount AS "Πλήθος Άλμπουμ"
FROM ARTIST
JOIN ArtistAlbumCount ON ARTIST.ArtistId = ArtistAlbumCount.ArtistId
WHERE ArtistAlbumCount.AlbumCount > 10
ORDER BY ArtistAlbumCount.AlbumCount DESC;

-- 2. Total size (MB) and total duration (hours) per media type
CREATE VIEW MediaTypeBytes AS
SELECT MediaTypeId, SUM(Bytes) AS TotalBytes
FROM TRACK
GROUP BY MediaTypeId;

CREATE VIEW MediaTypeDuration AS
SELECT MediaTypeId, SUM(Milliseconds) AS TotalMilliseconds
FROM TRACK
GROUP BY MediaTypeId;

SELECT MEDIATYPE.Name AS "Όνομα Τύπου Αποθήκευσης",
       ROUND(CAST(MediaTypeBytes.TotalBytes AS REAL) / 1048576, 1) AS "Πλήθος Mbytes",
       ROUND(CAST(MediaTypeDuration.TotalMilliseconds AS REAL) / 3600000, 1) AS "Συνολική Διάρκεια σε Ώρες"
FROM MEDIATYPE
JOIN MediaTypeBytes ON MEDIATYPE.MediaTypeId = MediaTypeBytes.MediaTypeId
JOIN MediaTypeDuration ON MEDIATYPE.MediaTypeId = MediaTypeDuration.MediaTypeId;

-- 3. Top-selling album by total sales value
CREATE VIEW TrackSalesValue AS
SELECT TrackId, SUM(UnitPrice * Quantity) AS TotalValue
FROM INVOICELINE
GROUP BY TrackId;

CREATE VIEW AlbumSalesValue AS
SELECT ALBUM.AlbumId, SUM(TrackSalesValue.TotalValue) AS TotalSalesValue
FROM ALBUM
JOIN TRACK ON ALBUM.AlbumId = TRACK.AlbumId
JOIN TrackSalesValue ON TRACK.TrackId = TrackSalesValue.TrackId
GROUP BY ALBUM.AlbumId;

SELECT ALBUM.Title AS "Τίτλος άλμπουμ", AlbumSalesValue.TotalSalesValue AS "Συνολική αξία"
FROM ALBUM
JOIN AlbumSalesValue ON ALBUM.AlbumId = AlbumSalesValue.AlbumId
WHERE AlbumSalesValue.TotalSalesValue = (SELECT MAX(TotalSalesValue) FROM AlbumSalesValue);
