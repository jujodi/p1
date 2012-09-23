CREATE TABLE Tag(
    tid INTEGER, x INTEGER, y INTEGER, time_created DATE,
    PRIMARY KEY (tid));

CREATE TABLE Location(
    lid INTEGER, city CHAR(50), state CHAR(40), country CHAR(40),
    PRIMARY KEY (lid) );

CREATE TABLE Users(
    userid INTEGER, first CHAR(30),
    last CHAR(30), yob INTEGER, mob INTEGER, dob DATE, gender char(6),
    lid INTEGER, cid INTEGER,
    PRIMARY KEY (userid),
    FOREIGN KEY (lid) REFERENCES Location,
    FOREIGN KEY (cid) REFERENCES Location);

CREATE TABLE Event(
    eid INTEGER, lid INTEGER NOT NULL, hid INTEGER NOT NULL, cid INTEGER NOT NULL,
    ename CHAR(50), tagline CHAR(150), description CHAR(140), 
    etype CHAR(30), stype CHAR(30), stime DATE, etime DATE,
    PRIMARY KEY (eid),
    FOREIGN KEY (lid) REFERENCES Location,
    FOREIGN KEY (hid) REFERENCES Users,
    FOREIGN KEY (cid) REFERENCES Users);

CREATE TABLE Participant(
    eid INTEGER, userid INTEGER, status char(30),
    PRIMARY KEY (eid, userid),
    FOREIGN KEY (eid) REFERENCES Event,
    FOREIGN KEY (userid) REFERENCES Users);

CREATE TABLE Photo(
    pid INTEGER,
    modified DATE, created DATE, link CHAR(50), caption CHAR(50),
    PRIMARY KEY (pid));

CREATE TABLE Album(
    aid INTEGER, userid INTEGER NOT NULL, cpid INTEGER NOT NULL,
    name CHAR(50), created DATE, modified DATE, link CHAR(50), visibility CHAR(20),
    PRIMARY KEY (aid),
    FOREIGN KEY (userid) REFERENCES Users,
    FOREIGN KEY (cpid) REFERENCES Photo,
    UNIQUE (cpid));

CREATE TABLE Photo_Album(
    pid INTEGER, aid INTEGER NOT NULL,
    PRIMARY KEY (pid),
    FOREIGN KEY (aid) REFERENCES Album,
    FOREIGN KEY (pid) REFERENCES Photo);

CREATE TABLE Has(
    userid INTEGER, tid INTEGER, pid INTEGER,
    PRIMARY KEY (userid, pid),
    FOREIGN KEY (userid) REFERENCES Users,
    FOREIGN KEY (tid) REFERENCES Tag,
    FOREIGN KEY (pid) REFERENCES Photo);

CREATE TABLE Friends(
    uid1 INTEGER, uid2 INTEGER,
    PRIMARY KEY (uid1, uid2),
    FOREIGN KEY (uid1) REFERENCES Users,
    FOREIGN KEY (uid2) REFERENCES Users);
    
CREATE TABLE School(
    sid INTEGER, name CHAR(50),
    PRIMARY KEY (sid) );

CREATE TABLE Attended(
    sid INTEGER, userid INTEGER,
    year INTEGER, conc CHAR(30), degree CHAR(30),
    FOREIGN KEY (sid) REFERENCES School,
    FOREIGN KEY (userid) REFERENCES Users);


