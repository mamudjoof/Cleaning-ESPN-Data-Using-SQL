----Select the Data 
Select *
From  [dbo].[ESPNN]

---- Rename Multiple colunms in a list

EXEC sp_rename 'dbo.ESPNN.Mat', 'Matches Played', 'COLUMN';

EXEC sp_rename 'ESPNN.NO', 'NotOuts', 'COLUMN'
EXEC sp_rename 'ESPNN.HS', 'HighestInsScored', 'Column'
EXEC sp_rename 'ESPNN.BF', 'BallsFaced', 'Column'
EXEC sp_rename 'ESPNN.SR', 'BattlingStrikeRate', 'Column'
EXEC sp_rename 'ESPNN.F1', 'Player', 'Column'

--Replacing '-', NULL to 0

UPDATE [dbo].[ESPNN]
SET BallsFaced = REPLACE(BallsFaced, '-', '0')


UPDATE [dbo].[ESPNN]
SET HighestInsScored=ISNULL(HighestInsScored, 0) 


---SPLIT the SPAN into Start year and Ending Year

Select 
PARSENAME(REPLACE(Span, '-', '.'), 2) AS Start_Year,
PARSENAME(REPLACE(Span, '-', '.'), 1) AS End_Year
From [dbo].[ESPNN]

ALTER TABLE [dbo].[ESPNN]
ADD Start_Year int

ALTER TABLE [dbo].[ESPNN]
ADD End_Year int


UPDATE [dbo].[ESPNN]
SET Start_Year = PARSENAME(REPLACE(Span, '-', '.'), 2)

UPDATE [dbo].[ESPNN]
SET End_Year = PARSENAME(REPLACE(Span, '-', '.'), 1)


--Split the conutry Code from the name

Select 
PARSENAME(REPLACE(Player, '(', '.'), 1) AS Country,
PARSENAME(REPLACE(Player, '(', '.'), 2) AS Player_Name
From [dbo].[ESPNN]

ALTER TABLE [dbo].[ESPNN]
ADD Country nvarchar(255)


UPDATE [dbo].[ESPNN]
Set Country = PARSENAME(REPLACE(Player, '(', '.'), 1)


ALTER TABLE [dbo].[ESPNN]
ADD Player_Name nvarchar(255)

UPDATE [dbo].[ESPNN]
Set Player_Name = PARSENAME(REPLACE(Player, '(', '.'), 2)

ALTER TABLE [dbo].[ESPNN]
Drop column Player_Name


UPDATE [dbo].[ESPNN]
Set Player=Player_Name


UPDATE [dbo].[ESPNN]
set Country = REPLACE(Country, ')', ' ')


UPDATE [dbo].[ESPNN]
set BallsFaced = REPLACE(BallsFaced, '+', ' ')


--Drop the Unnecessary Colunms
ALTER TABLE [dbo].[ESPNN]
drop column  Span, [100], [50], [0], [4s], [6s]


EXEC sp_rename '[dbo].[ESPNN].Player', 'Player_Name', 'Column'


---CHECK IF THERE IS ANY DUPLICATES AND REMOVE THEM

SELECT Player_Name, COUNT(*) AS DuplicateCount
FROM [dbo].[ESPNN]
GROUP BY Player_Name
HAVING COUNT(*) > 1;

SELECT *
FROM [dbo].[ESPNN]


SELECT *
FROM [dbo].[ESPNN]
Where Player_Name = 'A Flower' OR Player_Name =  'AB de Villiers'


WITH rownumcte AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Player_Name, [Matches Played],Inns, NotOuts,
		Runs, HighestInsScored,Ave, BallsFaced, BattlingStrikeRate, Start_Year, End_Year, Country
                           ORDER BY (SELECT NULL)) AS rownum
    FROM [dbo].[ESPNN]
)
DELETE
FROM rownumcte
WHERE rownum > 1;


---Now since the dataset is clean we can runs for Calculations

--QUESTION ONE
-- Construct a Column of Career_Length 

Select End_Year-Start_Year AS Career_Length
From [dbo].[ESPNN]

ALTER TABLE [dbo].[ESPNN]
ADD Career_Length int


UPDATE [dbo].[ESPNN]
SET Career_Length = End_Year-Start_Year


----QUESTION TWO
----WHAT IS THE AVERAGE CAREER_LENGTH

SELECT AVG(CAST(Career_Length as float))  AS Avg_Career_Length
FROM  [dbo].[ESPNN]



---QUESTION THREE
---WHAT IS THE AVERAGE BATTLINGSTRIKERATE WHO PLAYED OVER 10 YEARS

SELECT AVG(BattlingStrikeRate)  AS Avg_BattlingStrikeRate
FROM  [dbo].[ESPNN]
WHERE Career_Length > 10


---QUESTION FOUR
---FIND THE NUMBER OF CRICKERS WHO PLAYED BEFORE 1960

SELECT COUNT(Player_Name) PlayedBefore1960
FROM [dbo].[ESPNN]
WHERE Start_Year < 1960


---QUESTION FIVE
---MAX HIGHEST INNS SCORED BY COUNTRY

SELECT Country, MAX(Inns) HigestScored
FROM [dbo].[ESPNN]
GROUP BY Country
ORDER BY HigestScored DESC

SELECT *
FROM [dbo].[ESPNN]





EXEC sp_help ESPN