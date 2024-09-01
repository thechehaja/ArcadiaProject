-- Create the ArcadiaDB database
CREATE DATABASE ArcadiaDB;
GO

-- Switch to the ArcadiaDB database
USE ArcadiaDB;

-- Table: Players
-- Stores player information and progress
CREATE TABLE Players (
    PlayerID INT CONSTRAINT PK_Players PRIMARY KEY IDENTITY(1, 1),
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    RegistrationDate DATETIME NOT NULL DEFAULT GETDATE(),
    LastLoginDate DATETIME NULL,
    ProfilePicture VARBINARY(MAX) NULL,
    TotalPlayTime INT NOT NULL DEFAULT 0,
    PlayerLevel INT NOT NULL DEFAULT 1,
    ExperiencePoints INT NOT NULL DEFAULT 0,
    CurrencyBalance DECIMAL(10, 2) NOT NULL DEFAULT 0.00
);

-- Table: Games
-- Stores game details including name, mode, and genre
CREATE TABLE Games (
    GameID INT CONSTRAINT PK_Games PRIMARY KEY IDENTITY(1, 1),
    GameName VARCHAR(100) NOT NULL UNIQUE,
    GameMode VARCHAR(50) NOT NULL,
    GameDescription VARCHAR(MAX) NULL,
    ReleaseDate DATETIME NOT NULL DEFAULT GETDATE(),
    Developer VARCHAR(100) NOT NULL,
    Genre VARCHAR(50) NOT NULL
);

-- Table: Matches
-- Tracks individual game matches
CREATE TABLE Matches (
    MatchID INT CONSTRAINT PK_Matches PRIMARY KEY IDENTITY(1, 1),
    GameID INT CONSTRAINT FK_Matches_Games FOREIGN KEY REFERENCES Games(GameID) NOT NULL,
    MatchStartTime DATETIME NOT NULL,
    MatchEndTime DATETIME NULL,
    WinnerPlayerID INT CONSTRAINT FK_Matches_Players FOREIGN KEY REFERENCES Players(PlayerID),
    Map VARCHAR(100) NOT NULL,
    MatchDuration INT NOT NULL DEFAULT 0
);

-- Table: PlayerMatchStats
-- Stores player statistics for each match
CREATE TABLE PlayerMatchStats (
    StatsID INT CONSTRAINT PK_PlayerMatchStats PRIMARY KEY IDENTITY(1, 1),
    MatchID INT CONSTRAINT FK_PlayerMatchStats_Matches FOREIGN KEY REFERENCES Matches(MatchID) NOT NULL,
    PlayerID INT CONSTRAINT FK_PlayerMatchStats_Players FOREIGN KEY REFERENCES Players(PlayerID) NOT NULL,
    Kills INT NOT NULL DEFAULT 0,
    Deaths INT NOT NULL DEFAULT 0,
    Assists INT NOT NULL DEFAULT 0,
    Score INT NOT NULL DEFAULT 0,
    PerformanceRating DECIMAL(10, 2) NULL
);

-- Table: Items
-- Defines items available in the game
CREATE TABLE Items (
    ItemID INT CONSTRAINT PK_Items PRIMARY KEY IDENTITY(1, 1),
    ItemName VARCHAR(100) NOT NULL UNIQUE,
    ItemType VARCHAR(50) NOT NULL,
    ItemDescription VARCHAR(MAX) NULL,
    ItemValue DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    Rarity VARCHAR(50) NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE()
);

-- Table: PlayerInventory
-- Manages players' item inventories
CREATE TABLE PlayerInventory (
    InventoryID INT CONSTRAINT PK_PlayerInventory PRIMARY KEY IDENTITY(1, 1),
    PlayerID INT CONSTRAINT FK_PlayerInventory_Players FOREIGN KEY REFERENCES Players(PlayerID) NOT NULL,
    ItemID INT CONSTRAINT FK_PlayerInventory_Items FOREIGN KEY REFERENCES Items(ItemID) NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    AcquisitionDate DATETIME NOT NULL DEFAULT GETDATE()
);

-- Table: Assets
-- Stores game assets such as models and textures
CREATE TABLE Assets (
    AssetID INT CONSTRAINT PK_Assets PRIMARY KEY IDENTITY(1, 1),
    GameID INT CONSTRAINT FK_Assets_Games FOREIGN KEY REFERENCES Games(GameID) NOT NULL,
    AssetName VARCHAR(100) NOT NULL UNIQUE,
    AssetType VARCHAR(50) NOT NULL,
    AssetVersion VARCHAR(50) NOT NULL,
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
    ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
    FileSize INT NOT NULL,
    FilePath VARCHAR(255) NOT NULL
);

-- Table: PlayerSessions
-- Tracks player session data
CREATE TABLE PlayerSessions (
    PlayerSessionID INT CONSTRAINT PK_PlayerSessions PRIMARY KEY IDENTITY(1, 1),
    PlayerID INT CONSTRAINT FK_PlayerSessions_Players FOREIGN KEY REFERENCES Players(PlayerID) NOT NULL,
    SessionStartTime DATETIME NOT NULL DEFAULT GETDATE(),
    SessionEndTime DATETIME NULL,
    Duration INT NOT NULL DEFAULT 0,
    SessionIP VARCHAR(50) NOT NULL
);

-- Table: PlayerMatchEvents
-- Logs events that occur during matches
CREATE TABLE PlayerMatchEvents (
    PlayerMatchEventID INT CONSTRAINT PK_PlayerMatchEvents PRIMARY KEY IDENTITY(1, 1),
    EventName VARCHAR(100) NOT NULL,
    EventType VARCHAR(50) NOT NULL,
    PlayerID INT CONSTRAINT FK_PlayerMatchEvents_Players FOREIGN KEY REFERENCES Players(PlayerID) NULL,
    MatchID INT CONSTRAINT FK_PlayerMatchEvents_Matches FOREIGN KEY REFERENCES Matches(MatchID) NULL,
    EventTimestamp DATETIME NOT NULL DEFAULT GETDATE(),
    Details VARCHAR(MAX) NULL
);

-- Table: Achievements
-- Defines achievements that players can earn
CREATE TABLE Achievements (
    AchievementID INT CONSTRAINT PK_Achievements PRIMARY KEY IDENTITY(1, 1),
    AchievementName VARCHAR(100) NOT NULL,
    AchievementDescription VARCHAR(MAX) NULL,
    Criteria VARCHAR(MAX) NOT NULL,
    Reward VARCHAR(100) NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE()
);

-- Table: PlayerAchievements
-- Tracks the achievements earned by players
CREATE TABLE PlayerAchievements (
    PlayerAchievementID INT CONSTRAINT PK_PlayerAchievements PRIMARY KEY IDENTITY(1, 1),
    PlayerID INT CONSTRAINT FK_PlayerAchievements_Players FOREIGN KEY REFERENCES Players(PlayerID) NOT NULL,
    AchievementID INT CONSTRAINT FK_PlayerAchievements_Achievements FOREIGN KEY REFERENCES Achievements(AchievementID) NOT NULL,
    DateEarned DATETIME NOT NULL DEFAULT GETDATE()
);

-- Table: Transactions
-- Logs player transactions within the game
CREATE TABLE Transactions (
    TransactionID INT CONSTRAINT PK_Transactions PRIMARY KEY IDENTITY(1, 1),
    PlayerID INT CONSTRAINT FK_Transactions_Players FOREIGN KEY REFERENCES Players(PlayerID) NOT NULL,
    ItemID INT CONSTRAINT FK_Transactions_Items FOREIGN KEY REFERENCES Items(ItemID) NULL,
    TransactionType VARCHAR(50) NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    CurrencyType VARCHAR(10) NOT NULL,
    TransactionDate DATETIME NOT NULL DEFAULT GETDATE()
);

-- Table: ChatMessages
-- Stores in-game chat messages between players
CREATE TABLE ChatMessages (
    MessageID INT CONSTRAINT PK_ChatMessages PRIMARY KEY IDENTITY(1, 1),
    SenderPlayerID INT CONSTRAINT FK_ChatMessages_SenderPlayer FOREIGN KEY REFERENCES Players(PlayerID) NOT NULL,
    ReceiverPlayerID INT CONSTRAINT FK_ChatMessages_ReceiverPlayer FOREIGN KEY REFERENCES Players(PlayerID) NULL,
    MatchID INT CONSTRAINT FK_ChatMessages_Matches FOREIGN KEY REFERENCES Matches(MatchID) NULL,
    MessageContent VARCHAR(MAX) NOT NULL,
    MessageTimestamp DATETIME NOT NULL DEFAULT GETDATE()
);

-- Table: Friendships
-- Tracks friendships between players
CREATE TABLE Friendships (
    FriendshipID INT CONSTRAINT PK_Friendships PRIMARY KEY IDENTITY(1, 1),
    PlayerID1 INT CONSTRAINT FK_Friendships_Player1 FOREIGN KEY REFERENCES Players(PlayerID) NOT NULL,
    PlayerID2 INT CONSTRAINT FK_Friendships_Player2 FOREIGN KEY REFERENCES Players(PlayerID) NOT NULL,
    FriendshipDate DATETIME NOT NULL DEFAULT GETDATE()
);

-- Table: ErrorsAndLogs
-- Logs errors and important events in the system
CREATE TABLE ErrorsAndLogs (
    LogID INT CONSTRAINT PK_ErrorsAndLogs PRIMARY KEY IDENTITY(1, 1),
    LogType VARCHAR(50) NOT NULL,
    LogMessage VARCHAR(MAX) NOT NULL,
    PlayerID INT CONSTRAINT FK_ErrorsAndLogs_Player FOREIGN KEY REFERENCES Players(PlayerID) NULL,
    LogTimestamp DATETIME NOT NULL DEFAULT GETDATE(),
    Details VARCHAR(MAX) NULL
);
