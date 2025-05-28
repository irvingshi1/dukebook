/* 
 * Key:
 * (UD x0, ..., xn) - Undirected, which means order doesn't matter.
 */

-- The table of accounts.
CREATE TABLE Accounts (
	username TEXT NOT NULL,
	password TEXT NOT NULL,
	join_date DATE NOT NULL,
	thorium BOOL NOT NULL DEFAULT FALSE,
	posts INT NOT NULL,
	strikes INT NOT NULL DEFAULT 0,
	CONSTRAINT check_username CHECK (username != ""),
	CONSTRAINT check_password CHECK (password != ""),
	CONSTRAINT check_posts CHECK (posts >= 0),
	CONSTRAINT check_strikes CHECK (strikes >= 0 AND strikes <= 3)
);

-- Inserts accounts.
INSERT INTO Accounts (
	username,
	password,
	join_date,
	thorium,
	posts
) VALUES (
	"alice",
	"123456",
	"1991-6-3",
	TRUE,
	234112
);

INSERT INTO Accounts (
	username,
	password,
	join_date,
	thorium,
	posts
) VALUES (
	"bob",
	"qwerty",
	"1994-2-6",
	TRUE,
	234211
);

INSERT INTO Accounts (
	username,
	password,
	join_date,
	posts
) VALUES (
	"charlie",
	"123123",
	"1997-11-2",
	123131
);

INSERT INTO Accounts (
	username,
	password,
	join_date,
	posts
) VALUES (
	"david",
	"azerty",
	"2000-7-11",
	162342
);

INSERT INTO Accounts (
	username,
	password,
	join_date,
	posts,
	strikes
) VALUES (
	"kathy",
	"badperson",
	"2001-6-6",
	1231,
	2
);

INSERT INTO Accounts (
	username,
	password,
	join_date,
	thorium,
	posts
) VALUES (
	"eva",
	"123456",
	"2003-8-7",
	TRUE,
	323141
);

INSERT INTO Accounts (
	username,
	password,
	join_date,
	posts,
	strikes
) VALUES (
	"gary",
	"badperson",
	"2004-1-2",
	1232,
	1
);

-- The table of friends (UD friend0, friend1).
CREATE TABLE Friends (
	friend0 TEXT NOT NULL,
	friend1 TEXT NOT NULL
);

-- Inserts friends.
INSERT INTO Friends VALUES (
	"alice",
	"bob"
);

INSERT INTO Friends VALUES (
	"bob",
	"alice"
);

INSERT INTO Friends VALUES (
	"alice",
	"charlie"
);

INSERT INTO Friends VALUES (
	"charlie",
	"alice"
);

INSERT INTO Friends VALUES (
	"alice",
	"eva"
);

INSERT INTO Friends VALUES (
	"eva",
	"alice"
);

INSERT INTO Friends VALUES (
	"bob",
	"eva"
);

INSERT INTO Friends VALUES (
	"eva",
	"bob"
);

INSERT INTO Friends VALUES (
	"charlie",
	"david"
);

INSERT INTO Friends VALUES (
	"david",
	"charlie"
);

INSERT INTO Friends VALUES (
	"charlie",
	"eva"
);

INSERT INTO Friends VALUES (
	"eva",
	"charlie"
);

-- The table of blocks. Blocks and friends are mutually exclusive.
CREATE TABLE Blocks (
	blocker TEXT NOT NULL,
	blocked TEXT NOT NULL
);

-- Inserts blocks.
INSERT INTO Blocks VALUES (
	"alice",
	"kathy"
);

INSERT INTO Blocks VALUES (
	"bob",
	"gary"
);

INSERT INTO Blocks VALUES (
	"charlie",
	"gary"
);

INSERT INTO Blocks VALUES (
	"david",
	"gary"
);

INSERT INTO Blocks VALUES (
	"david",
	"kathy"
);

INSERT INTO Blocks VALUES (
	"eva",
	"kathy"
);

-- Displays the table of accounts.
SELECT * FROM Accounts;

-- Displays the table of friends.
SELECT * FROM Friends;

-- Displays the table of blocks.
SELECT * FROM Blocks;

-- Displays the table of Thorium accounts.
SELECT * FROM Accounts WHERE Accounts.thorium = TRUE;

-- Displays friends of Alice.
SELECT Accounts.* FROM Accounts INNER JOIN Friends
ON Accounts.username = Friends.friend0
OR Accounts.username = Friends.friend1
WHERE Accounts.username != "alice"
AND (Friends.friend0 = "alice"
OR Friends.friend1 = "alice");

-- Displays people who've blocked Kathy.
SELECT Accounts.* FROM Accounts INNER JOIN Blocks
ON Accounts.username = Blocks.blocker
WHERE Blocks.blocked = "kathy";

-- Displays people who've been banned.
SELECT * FROM Accounts
WHERE Accounts.strikes >= 3;

-- Displays people who've posted at least 100000 posts.
SELECT * FROM Accounts
WHERE Accounts.posts >= 100000;
