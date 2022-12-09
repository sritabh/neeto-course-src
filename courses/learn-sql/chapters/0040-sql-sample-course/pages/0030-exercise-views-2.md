Write a set of SQL statements to:

1. Create a VIEW `booksVolumeSeries` that contains these two columns: `name`, `nextVolumeId`. The data should be the name and the nextVolumeId for all the books where nextVolumeId is present.

2. Use the VIEW `booksVolumeSeries` in combination with `books` to get the name of the book and the name of the next volume for all the books that have a next volume. The headers should be set as `bookName` and `nextVolumeName` respectively.

<codeblock language="sql" dbName="students2-v1.db" type="exercise" testMode="fixedInput" checkForViews="booksVolumeSeries">
<code>

</code>

<hints>
<hint>
CREATE VIEW booksVolumeSeries AS
SELECT name,
       nextVolumeId
FROM   books
WHERE  nextVolumeId IS NOT NULL;

SELECT booksVolumeSeries.name as bookName,
       books.id as nextVolumeId
FROM   booksVolumeSeries JOIN books
ON     booksVolumeSeries.nextVolumeId = books.id;
</hint>
</hints>

<solution>
CREATE VIEW booksVolumeSeries AS
SELECT name,
       nextVolumeId
FROM   books
WHERE  nextVolumeId IS NOT NULL;

SELECT booksVolumeSeries.name as bookName,
       books.name as nextVolumeName
FROM   booksVolumeSeries JOIN books
ON     booksVolumeSeries.nextVolumeId = books.id;
</solution>
</codeblock>