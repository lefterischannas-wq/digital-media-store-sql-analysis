-- 1. Customers with missing phone number or postal code
SELECT FirstName AS Όνομα, LastName AS Επώνυμο, PostalCode AS ΤΚ, Phone AS Τηλέφωνο
FROM CUSTOMER
WHERE Phone IS NULL OR PostalCode IS NULL;

-- 2. All albums by AC/DC
SELECT Title AS "AC/DC Albums"
FROM ALBUM
WHERE ArtistId = (SELECT ArtistId FROM ARTIST WHERE Name = 'AC/DC');

-- 3. Artist and composer of the track 'Back to Black'
SELECT ARTIST.Name AS "Όνομα Καλλιτέχνη/Συγκροτήματος", TRACK.Composer AS "Όνομα Συνθέτη"
FROM TRACK
JOIN ALBUM ON TRACK.AlbumId = ALBUM.AlbumId
JOIN ARTIST ON ALBUM.ArtistId = ARTIST.ArtistId
WHERE TRACK.Name = 'Back to Black';

-- 4. Music genres associated with U2 tracks
SELECT DISTINCT GENRE.Name AS "Είδη Μουσικής U2"
FROM TRACK
JOIN GENRE ON TRACK.GenreId = GENRE.GenreId
JOIN ALBUM ON TRACK.AlbumId = ALBUM.AlbumId
JOIN ARTIST ON ALBUM.ArtistId = ARTIST.ArtistId
WHERE ARTIST.Name = 'U2';

-- 5. Average track duration (in minutes) for 'A Matter of Life and Death'
SELECT ROUND(AVG(Milliseconds) / 60000.0, 1) AS "ΜέσηΔιάρκεια (λεπτά)"
FROM TRACK
WHERE AlbumId = (SELECT AlbumId FROM ALBUM WHERE Title = 'A Matter of Life and Death');

-- 6. Ratio of tracks with a known composer
SELECT ROUND(COUNT(Composer) * 1.0 / COUNT(*), 2) AS "Ποσοστό Τραγουδιών Γνωστού Συνθέτη"
FROM TRACK;

-- 7. Longest track by Queen
SELECT TRACK.Name AS "Τίτλος Κοιματιού", TRACK.Milliseconds AS "Διάρκεια (milliseconds)"
FROM TRACK
JOIN ALBUM ON TRACK.AlbumId = ALBUM.AlbumId
JOIN ARTIST ON ALBUM.ArtistId = ARTIST.ArtistId
WHERE ARTIST.Name = 'Queen'
ORDER BY TRACK.Milliseconds DESC
LIMIT 1;

-- 8. Track count per non-empty playlist
SELECT PLAYLIST.Name AS "Λίστα Αναπαραγωγής", COUNT(PLAYLISTTRACK.TrackId) AS "Πλήθος Κοιματιών"
FROM PLAYLIST
JOIN PLAYLISTTRACK ON PLAYLIST.PlaylistId = PLAYLISTTRACK.PlaylistId
GROUP BY PLAYLIST.Name
ORDER BY PLAYLIST.Name ASC;

-- 9. Artists with more than 10 albums
SELECT ARTIST.Name AS "Καλλιτέχνης/Συγκρότημα", COUNT(ALBUM.AlbumId) AS "Πλήθος Άλμπουμ"
FROM ARTIST
JOIN ALBUM ON ARTIST.ArtistId = ALBUM.ArtistId
GROUP BY ARTIST.Name
HAVING COUNT(ALBUM.AlbumId) > 10
ORDER BY COUNT(ALBUM.AlbumId) DESC;

-- 10. Led Zeppelin albums with no tracks shorter than 4 minutes
SELECT ALBUM.Title AS "Long-Songs Led Zeppelin Albums"
FROM ALBUM
JOIN ARTIST ON ALBUM.ArtistId = ARTIST.ArtistId
WHERE ARTIST.Name = 'Led Zeppelin'
AND NOT EXISTS (
    SELECT 1
    FROM TRACK
    WHERE TRACK.AlbumId = ALBUM.AlbumId AND TRACK.Milliseconds < 240000
);

-- 11. Artists featured in both '90’s Music' and 'Heavy Metal Classic' playlists
SELECT DISTINCT ARTIST.Name AS "Όνομα Καλλιτέχνη/Συγκροτήματος"
FROM ARTIST
JOIN ALBUM ON ARTIST.ArtistId = ALBUM.ArtistId
JOIN TRACK ON ALBUM.AlbumId = TRACK.AlbumId
JOIN PLAYLISTTRACK ON TRACK.TrackId = PLAYLISTTRACK.TrackId
JOIN PLAYLIST ON PLAYLISTTRACK.PlaylistId = PLAYLIST.PlaylistId
WHERE PLAYLIST.Name IN ('90’s Music', 'Heavy Metal Classic')
GROUP BY ARTIST.Name
HAVING COUNT(DISTINCT PLAYLIST.Name) = 2;

-- 12. Album with the highest number of tracks
SELECT ALBUM.Title AS "Τίτλος Άλμπουμ", COUNT(TRACK.TrackId) AS "Μέγιστο Πλήθος Κοιματιών", ARTIST.Name AS "Όνομα Καλλιτέχνη/Συγκροτήματος"
FROM ALBUM
JOIN TRACK ON ALBUM.AlbumId = TRACK.AlbumId
JOIN ARTIST ON ALBUM.ArtistId = ARTIST.ArtistId
GROUP BY ALBUM.AlbumId
ORDER BY COUNT(TRACK.TrackId) DESC
LIMIT 1;
