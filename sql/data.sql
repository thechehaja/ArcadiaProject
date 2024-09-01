USE ArcadiaDB

INSERT INTO Players(Username, Email, PasswordHash, RegistrationDate, TotalPlayTime, PlayerLevel, ExperiencePoints, CurrencyBalance)
VALUES 
('ShadowHunter', 'shadow.hunter@gmail.com', 'hashedpassword123', '2024-01-15', 3200, 15, 18000, 150.50),
('ArcaneWizard', 'arcane.wizard@yahoo.com', 'hashedpassword456', '2024-02-10', 5400, 20, 22000, 300.00),
('IronGiant', 'iron.giant@hotmail.com', 'hashedpassword789', '2024-03-05', 4200, 18, 21000, 250.75),
('CrimsonKnight', 'crimson.knight@outlook.com', 'hashedpassword321', '2024-04-12', 2100, 12, 12000, 100.00),
('MysticRogue', 'mystic.rogue@gmail.com', 'hashedpassword654', '2024-05-20', 1900, 10, 10500, 75.25);

INSERT INTO Games (GameName, GameMode, GameDescription, ReleaseDate, Developer, Genre)
VALUES 
('War of Shadows', 'Multiplayer', 'An epic battle between the forces of light and darkness.', '2024-06-01', 'DarkMatter Studios', 'Action'),
('Mystic Quests', 'Single Player', 'Embark on a mystical journey to save the realm.', '2024-03-15', 'Arcane Creations', 'Adventure'),
('Steel Titans', 'Multiplayer', 'Command your army of steel titans in this futuristic warfare game.', '2024-08-20', 'IronForge Entertainment', 'Strategy'),
('Crimson Fury', 'Multiplayer', 'Fast-paced combat in a post-apocalyptic world.', '2024-07-05', 'RedPhoenix Games', 'Shooter'),
('Rogue’s Gambit', 'Single Player', 'A stealth-based game where cunning and strategy rule.', '2024-04-25', 'ShadowFox Studios', 'Stealth');

INSERT INTO Matches (GameID, MatchStartTime, MatchEndTime, WinnerPlayerID, Map, MatchDuration)
VALUES 
(1, '2024-09-01 14:30:00', '2024-09-01 15:00:00', 1, 'Shadow Valley', 30),
(1, '2024-09-01 16:00:00', '2024-09-01 16:40:00', 2, 'Dark Forest', 40),
(2, '2024-09-02 13:00:00', '2024-09-02 14:00:00', NULL, 'Mystic Falls', 60),
(3, '2024-09-03 10:00:00', '2024-09-03 10:50:00', 3, 'Titan Plains', 50),
(4, '2024-09-04 17:00:00', '2024-09-04 17:30:00', 4, 'Wasteland Arena', 30);

INSERT INTO PlayerMatchStats (MatchID, PlayerID, Kills, Deaths, Assists, Score, PerformanceRating)
VALUES 
(1, 1, 15, 3, 5, 200, 8.5),
(1, 2, 12, 4, 6, 180, 7.8),
(2, 1, 20, 2, 10, 300, 9.2),
(2, 3, 18, 5, 8, 250, 8.0),
(3, 2, 22, 1, 12, 350, 9.5),
(4, 3, 16, 4, 7, 230, 8.3),
(5, 4, 10, 6, 3, 150, 7.0);

INSERT INTO Items (ItemName, ItemType, ItemDescription, ItemValue, Rarity, CreationDate)
VALUES 
('Shadow Blade', 'Weapon', 'A powerful blade forged in the shadows, grants +10 attack.', 500.00, 'Epic', '2024-06-01'),
('Mystic Staff', 'Weapon', 'A staff imbued with magical powers, grants +15 magic.', 600.00, 'Legendary', '2024-06-05'),
('Iron Shield', 'Armor', 'A shield made of iron, provides +20 defense.', 300.00, 'Rare', '2024-06-10'),
('Crimson Armor', 'Armor', 'Red armor that increases health by +50.', 700.00, 'Epic', '2024-06-15'),
('Rogue’s Dagger', 'Weapon', 'A dagger that deals critical damage, +5 stealth.', 400.00, 'Epic', '2024-06-20');

INSERT INTO PlayerInventory (PlayerID, ItemID, Quantity, AcquisitionDate)
VALUES 
(1, 1, 1, '2024-06-01'),
(2, 2, 1, '2024-06-10'),
(3, 3, 1, '2024-06-15'),
(4, 4, 1, '2024-06-20'),
(5, 5, 2, '2024-06-25');

INSERT INTO Assets (GameID, AssetName, AssetType, AssetVersion, CreatedDate, ModifiedDate, FileSize, FilePath)
VALUES 
(1, 'Shadow Warrior Model', '3D Model', 'v1.0', '2024-01-01', '2024-05-01', 15000, '/assets/models/shadow_warrior_v1.0.obj'),
(2, 'Mystic Forest Map', 'Environment', 'v2.3', '2024-02-01', '2024-06-01', 25000, '/assets/maps/mystic_forest_v2.3.map'),
(3, 'Steel Titan Animation', 'Animation', 'v3.2', '2024-03-01', '2024-07-01', 30000, '/assets/animations/steel_titan_v3.2.anim'),
(4, 'Crimson Fury Soundtrack', 'Audio', 'v1.5', '2024-04-01', '2024-08-01', 5000, '/assets/audio/crimson_fury_v1.5.ogg'),
(5, 'Rogue’s Lair Texture', 'Texture', 'v4.0', '2024-05-01', '2024-09-01', 8000, '/assets/textures/rogues_lair_v4.0.jpg');

INSERT INTO PlayerSessions (PlayerID, SessionStartTime, SessionEndTime, Duration, SessionIP)
VALUES 
(1, '2024-09-01 14:30:00', '2024-09-01 15:30:00', 60, '192.168.1.2'),
(2, '2024-09-02 16:00:00', '2024-09-02 17:00:00', 60, '192.168.1.3'),
(3, '2024-09-03 13:00:00', '2024-09-03 14:00:00', 60, '192.168.1.4'),
(4, '2024-09-04 11:00:00', '2024-09-04 12:00:00', 60, '192.168.1.5'),
(5, '2024-09-05 10:00:00', '2024-09-05 11:00:00', 60, '192.168.1.6');

INSERT INTO PlayerMatchEvents (EventName, EventType, PlayerID, MatchID, EventTimestamp, Details)
VALUES 
('Shadow Strike', 'Attack', 1, 1, '2024-09-01 14:45:00', 'ShadowHunter used Shadow Strike and dealt 150 damage.'),
('Mystic Barrier', 'Defense', 2, 2, '2024-09-01 16:10:00', 'ArcaneWizard cast Mystic Barrier to block incoming attacks.'),
('Titan Smash', 'Attack', 3, 4, '2024-09-03 10:20:00', 'IronGiant unleashed Titan Smash, dealing 300 damage.'),
('Crimson Fury', 'Attack', 4, 5, '2024-09-04 17:10:00', 'CrimsonKnight used Crimson Fury, causing a massive explosion.'),
('Rogue Ambush', 'Stealth', 5, 3, '2024-09-02 13:30:00', 'MysticRogue performed a stealth attack, dealing critical damage.');

INSERT INTO Achievements (AchievementName, AchievementDescription, Criteria, Reward, CreationDate)
VALUES 
('Shadow Master', 'Awarded for achieving 10 wins in War of Shadows.', '10 wins in War of Shadows', 'Shadow Blade', '2024-01-01'),
('Mystic Defender', 'Awarded for casting 100 Mystic Barriers.', 'Cast 100 Mystic Barriers', 'Mystic Staff', '2024-02-01'),
('Titan Commander', 'Awarded for leading 5 victorious battles in Steel Titans.', '5 victories in Steel Titans', 'Iron Shield', '2024-03-01'),
('Crimson Warrior', 'Awarded for defeating 50 enemies in Crimson Fury.', '50 kills in Crimson Fury', 'Crimson Armor', '2024-04-01'),
('Rogue’s Shadow', 'Awarded for completing 10 stealth missions in Rogue’s Gambit.', '10 stealth missions in Rogue’s Gambit', 'Rogue’s Dagger', '2024-05-01');

INSERT INTO PlayerAchievements (PlayerID, AchievementID, DateEarned)
VALUES 
(1, 1, '2024-09-01'),
(2, 2, '2024-09-02'),
(3, 3, '2024-09-03'),
(4, 4, '2024-09-04'),
(5, 5, '2024-09-05');

INSERT INTO Transactions (PlayerID, ItemID, TransactionType, Amount, CurrencyType, TransactionDate)
VALUES 
(1, 1, 'Purchase', 500.00, 'Gold', '2024-09-01'),
(2, 2, 'Purchase', 600.00, 'Gold', '2024-09-02'),
(3, 3, 'Purchase', 300.00, 'Gold', '2024-09-03'),
(4, 4, 'Purchase', 700.00, 'Gold', '2024-09-04'),
(5, 5, 'Purchase', 400.00, 'Gold', '2024-09-05');

INSERT INTO ChatMessages (SenderPlayerID, ReceiverPlayerID, MatchID, MessageContent, MessageTimestamp)
VALUES 
(1, 2, 1, 'Great match! You almost had me there.', '2024-09-01 15:05:00'),
(2, 1, 2, 'Your barrier was tough to break!', '2024-09-02 16:45:00'),
(3, 4, 3, 'Let’s team up for the next battle.', '2024-09-03 10:55:00'),
(4, 5, 4, 'Watch out for my next move!', '2024-09-04 17:35:00'),
(5, 3, 5, 'That was a close one!', '2024-09-05 11:05:00');

INSERT INTO Friendships (PlayerID1, PlayerID2, FriendshipDate)
VALUES 
(1, 2, '2024-06-01'),
(3, 4, '2024-06-05'),
(2, 5, '2024-06-10'),
(1, 4, '2024-06-15'),
(3, 5, '2024-06-20');

INSERT INTO ErrorsAndLogs (LogType, LogMessage, PlayerID, LogTimestamp, Details)
VALUES 
('Error', 'Failed to load player profile.', 1, '2024-09-01 14:32:00', 'Timeout error while loading profile.'),
('Warning', 'High latency detected.', 2, '2024-09-02 16:02:00', 'Player experienced latency of 300ms.'),
('Info', 'Match started successfully.', 3, '2024-09-03 10:02:00', 'Player joined the match at Titan Plains.'),
('Error', 'Transaction failed.', 4, '2024-09-04 17:02:00', 'Insufficient funds for purchase.'),
('Info', 'Friendship request sent.', 5, '2024-09-05 11:02:00', 'Player sent a friendship request to MysticRogue.');
