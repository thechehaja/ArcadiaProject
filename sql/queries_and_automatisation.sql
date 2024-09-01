USE ArcadiaDB

-- 1.0.0 Basic Queries

-- 1.0.1 Retrieve All Players

SELECT * FROM Players

-- 1.0.2 Retrieve All Games

SELECT * FROM Games

-- 1.0.3 Retrieve All Matches

SELECT * FROM Matches

-- 1.0.4 Retrieve Players with Specific Experience Points

SELECT Username, PlayerLevel, ExperiencePoints
FROM Players
WHERE ExperiencePoints >= 20000;

-- 1.0.5 Retrieve All Items in the Game

SELECT * FROM Items

-- 2.0.0 Complex Queries

-- 2.0.1 Top 3 Players by Experience Points

SELECT TOP 3 Username, PlayerLevel, ExperiencePoints
FROM Players
ORDER BY ExperiencePoints DESC;

-- 2.0.2 Find All Matches Played by a Specific Player

SELECT *
FROM Matches M
JOIN Games G ON M.GameID = G.GameID
JOIN PlayerMatchStats P ON M.MatchID = P.MatchID
WHERE P.PlayerID = 1; -- Replace 1 with the specific PlayerID

-- 2.0.3 Generate Leaderboard for a Specific Game

SELECT P.Username, SUM(S.Score) AS TotalScore
FROM PlayerMatchStats S
JOIN Players P ON S.PlayerID = P.PlayerID
JOIN Matches M ON S.MatchID = M.MatchID
WHERE M.GameID = 1 -- Replace 1 with the specific GameID
GROUP BY P.Username
ORDER BY TotalScore DESC;

-- 2.0.4 Retrieve All Items Owned by a Specific Player

SELECT I.ItemName, I.ItemType, PI.Quantity, I.ItemValue
FROM PlayerInventory PI
JOIN Items I ON PI.ItemID = I.ItemID
WHERE PI.PlayerID = 1; -- Replace 1 with the specific PlayerID

-- 2.0.5 Calculate Total Playtime for All Players

SELECT SUM(TotalPlayTime) AS TotalPlayTimeAcrossAllPlayers
FROM Players;

-- 3.0.0 Stored Procedures

-- 3.0.1 Stored Procedure to Insert a New Match

GO
CREATE PROCEDURE AddNewMatch
	@GameID INT,
	@MatchStartTime DATETIME,
	@MatchEndTime DATETIME,
	@WinnerPlayerID INT,
	@Map VARCHAR(100),
	@MatchDuration INT
AS
BEGIN
	INSERT INTO Matches(GameID, MatchStartTime, MatchEndTime, WinnerPlayerID, Map, MatchDuration)
	VALUES (@GameID, @MatchStartTime, @MatchEndTime, @WinnerPlayerID, @Map, @MatchDuration);
END;

EXEC AddNewMatch 1, '2024-09-10 14:30:00', '2024-09-10 15:00:00', 2, 'Shadow Isles', 30;

-- 3.0.2 Stored Procedure to Award an Achievement to a Player

GO
CREATE PROCEDURE AwardAchievement
	@PlayerID INT,
	@AchievementID INT
AS
BEGIN
	INSERT INTO PlayerAchievements(PlayerID, AchievementID, DateEarned)
	VALUES (@PlayerID, @AchievementID, GETDATE());
END;

EXEC AwardAchievement 1, 2;

-- 3.0.3 Stored Procedure to Add a New Player

GO
CREATE PROCEDURE AddNewPlayer
	@Username VARCHAR(50),
	@Email VARCHAR(100),
	@PasswordHash VARCHAR(255)
AS
BEGIN
	INSERT INTO Players(Username, Email, PasswordHash, RegistrationDate, TotalPlayTime, PlayerLevel, ExperiencePoints, CurrencyBalance)
	VALUES (@Username, @Email, @PasswordHash, GETDATE(), 0, 1, 0, 0.00);
END;

EXEC AddNewPlayer 'DragonBorn', 'dragonborn@gmail.com', 'passwordhash245';

-- 3.0.4 Stored Procedure to Update Player's Level and Experience

GO
CREATE PROCEDURE UpdatePlayerLevelAndExperience
	@PlayerID INT,
	@NewLevel INT,
	@NewExperiencePoints INT
AS
BEGIN
	UPDATE Players
	SET PlayerLevel = @NewLevel, ExperiencePoints = @NewExperiencePoints
	WHERE PlayerID = @PlayerID;
END;

EXEC UpdatePlayerLevelAndExperience 1, 1, 0;

-- 3.0.5 Stored Procedure to Process a Transaction

GO
CREATE PROCEDURE ProcessTransaction
	@PlayerID INT,
	@ItemID INT,
	@Amount DECIMAL (10, 2),
	@CurrencyType VARCHAR(10)
AS
BEGIN
	DECLARE @CurrentBalance DECIMAL (10, 2);

	-- Get the current balance of the player
	SELECT @CurrentBalance = CurrencyBalance
	FROM Players
	WHERE PlayerID = @PlayerID;

	-- Check if the player has enough balance
	IF @CurrentBalance >= @Amount
	BEGIN
		-- Deduct the amount from the player's balance
		UPDATE Players
		SET CurrencyBalance = CurrencyBalance - @Amount
		WHERE PlayerID = @PlayerID;

		-- Log the transaction
		INSERT INTO Transactions (PlayerID, ItemID, TransactionType, Amount, CurrencyType, TransactionDate)
		VALUES (@PlayerID, @ItemID, 'Purchase', @Amount, @CurrencyType, GETDATE());

		-- Add the item to the player's inventory
		INSERT INTO PlayerInventory (PlayerID, ItemID, Quantity, AcquisitionDate)
		VALUES (@PlayerID, @ItemID, 1, GETDATE());
	END
	ELSE
	BEGIN
		RAISERROR('Insufficient funds', 16, 1);
	END
END;

EXEC ProcessTransaction 1, 2, 600.00, 'Gold';

EXEC ProcessTransaction 1, 2, 100.00, 'Gold';

-- 3.0.6 Stored Procedure to Add a New Game

GO 
CREATE PROCEDURE AddNewGame
	@GameName VARCHAR(100),
	@GameMode VARCHAR(50),
	@GameDescription VARCHAR(MAX),
	@Developer VARCHAR(100),
	@Genre VARCHAR(50)
AS
BEGIN
	INSERT INTO Games (GameName, GameMode, GameDescription, ReleaseDate, Developer, Genre)
	VALUES (@GameName, @GameMode, @GameDescription, GETDATE(), @Developer, @Genre);
END;

EXEC AddNewGame 'The Dragon Quest', 'Singe Player', 'A challenging quest to defeat a dragon.', 'ArcadiaDev', 'Adventure'; 

-- 3.0.7 Stored Procedure to Log an Error

GO
CREATE PROCEDURE LogError
	@LogMessage VARCHAR(MAX),
	@PlayerID INT = NULL,
	@Details VARCHAR(MAX) = NULL
AS
BEGIN
	INSERT INTO ErrorsAndLogs (LogType, LogMessage, PlayerID, LogTimestamp, Details)
	VALUES ('Error', @LogMessage, @PlayerID, GETDATE(), @Details);
END;

EXEC LogError 'Failed to load game assets', 1, 'AssetID: 123';

-- 4.0.0 Functions

-- 4.0.1 Function to Calculate Player's Total Score Across All Matches

GO
CREATE FUNCTION GetPlayerTotalScore (@PlayerID INT)
RETURNS INT
AS
BEGIN
	DECLARE @TotalScore INT;
	SELECT @TotalScore = SUM(Score)
	FROM PlayerMatchStats
	WHERE PlayerID = @PlayerID
	RETURN ISNULL(@TotalScore, 0);
END;

GO
SELECT dbo.GetPlayerTotalScore(2);

-- 4.0.2 Function to Get Total Currency for a Player

GO 
CREATE FUNCTION GetPlayerCurrencyBalance (@PlayerID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
	DECLARE @Balance DECIMAL(10, 2);
	SELECT @Balance = CurrencyBalance
	FROM Players
	WHERE PlayerID = @PlayerID;
	RETURN ISNULL(@Balance, 0.00);
END;

GO
SELECT dbo.GetPlayerCurrencyBalance(1);

-- 4.0.3 Function to Calculate Total Playtime for a Player

GO
CREATE FUNCTION CalculateTotalPlaytime (@PlayerID INT)
RETURNS INT
AS
BEGIN
	DECLARE @TotalPlaytime INT;
	SELECT @TotalPlaytime = SUM(Duration)
	FROM PlayerSessions
	WHERE PlayerID = @PlayerID;
	RETURN ISNULL(@TotalPlaytime, 0);
END;

GO
SELECT dbo.CalculateTotalPlaytime(1);

-- 4.0.4 Function to Get Player's Level by Username

GO
CREATE FUNCTION GetPlayerLevelByUsername (@Username VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @PlayerLevel INT;
	SELECT @PlayerLevel = PlayerLevel
	FROM Players
	WHERE Username = @Username
	RETURN ISNULL(@PlayerLevel, 0);
END;

GO
SELECT dbo.GetPlayerLevelByUsername('DragonBorn')

-- 4.0.5 Function to Get Total Score for a Match

GO
CREATE FUNCTION GetTotalScoreForMatch (@MatchID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalScore INT;
    SELECT @TotalScore = SUM(Score)
    FROM PlayerMatchStats
    WHERE MatchID = @MatchID;
    RETURN ISNULL(@TotalScore, 0);
END;

GO
SELECT dbo.GetTotalScoreForMatch(1);

-- 4.0.6 Function to Get the Most Recent Achievement Earned by a Player

GO
CREATE FUNCTION GetMostRecentAchievement (@PlayerID INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @AchievementName VARCHAR(100);
    SELECT TOP 1 @AchievementName = A.AchievementName
    FROM PlayerAchievements PA
    JOIN Achievements A ON PA.AchievementID = A.AchievementID
    WHERE PA.PlayerID = @PlayerID
    ORDER BY PA.DateEarned DESC;
    RETURN ISNULL(@AchievementName, 'No Achievements Earned');
END;

GO
SELECT dbo.GetMostRecentAchievement(1);

-- 5.0.0 Triggers

-- 5.0.1 Trigger to Automatically Update LastLoginDate

GO
CREATE TRIGGER trg_UpdateLastLoginDate
ON PlayerSessions
AFTER INSERT
AS
BEGIN
	DECLARE @PlayerID INT, @LastLogin DATETIME;

	SELECT @PlayerID = inserted.PlayerID, @LastLogin = inserted.SessionStartTime
	FROM inserted;

	UPDATE Players
	SET LastLoginDate = @LastLogin
	WHERE PlayerID = @PlayerID;
END;