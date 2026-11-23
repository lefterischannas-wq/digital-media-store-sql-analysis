-- 1. Delete empty playlists
DELETE FROM PLAYLIST
WHERE PlaylistId NOT IN (SELECT DISTINCT PlaylistId FROM PLAYLISTTRACK);

-- 2. Apply 50% discount to unsold 'Rock and Roll' tracks
UPDATE TRACK
SET UnitPrice = UnitPrice * 0.5
WHERE GenreId = (SELECT GenreId FROM GENRE WHERE Name = 'Rock and Roll')
AND TrackId NOT IN (SELECT DISTINCT TrackId FROM INVOICELINE);

-- 3. Add and populate TrackCount column in GENRE
ALTER TABLE GENRE ADD COLUMN TrackCount INTEGER;

UPDATE GENRE
SET TrackCount = (SELECT COUNT(*) FROM TRACK WHERE TRACK.GenreId = GENRE.GenreId);

-- 4. Create and populate U2ALBUMDATA table
CREATE TABLE U2ALBUMDATA (
    AlbumId INTEGER PRIMARY KEY,
    Title TEXT,
    Duration REAL
);

INSERT INTO U2ALBUMDATA (AlbumId, Title)
SELECT ALBUM.AlbumId, ALBUM.Title
FROM ALBUM
JOIN ARTIST ON ALBUM.ArtistId = ARTIST.ArtistId
WHERE ARTIST.Name = 'U2';

UPDATE U2ALBUMDATA
SET Duration = (
    SELECT ROUND(CAST(SUM(TRACK.Milliseconds) AS REAL) / 60000.0, 1)
    FROM TRACK
    WHERE TRACK.AlbumId = U2ALBUMDATA.AlbumId
);

-- 5. Delete invoices with Total > 20 while enforcing foreign key constraints
PRAGMA foreign_keys = ON;

DELETE FROM INVOICELINE
WHERE InvoiceId IN (SELECT InvoiceId FROM INVOICE WHERE Total > 20);

DELETE FROM INVOICE
WHERE Total > 20;
