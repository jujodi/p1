CREATE TABLE Location(
    loc_id VARCHAR2(100), city VARCHAR2(100), state VARCHAR2(100), country VARCHAR2(100),
    PRIMARY KEY (loc_id),
    UNIQUE(city, state, country));

CREATE SEQUENCE loc_sequence
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER loc_trigger
    BEFORE INSERT ON Location
    REFERENCING NEW AS NEW
    FOR EACH ROW
    BEGIN
        SELECT loc_sequence.nextval INTO :NEW.loc_id FROM DUAL;
    END;
.
RUN;

CREATE TABLE Users(
    userid VARCHAR2(100), first VARCHAR2(100),
    last VARCHAR2(100), yob NUMBER(38), mob NUMBER(38), dob NUMBER(38), gender VARCHAR(100),
    home_loc_id VARCHAR2(100), current_loc_id VARCHAR2(100),
    PRIMARY KEY (userid),
    FOREIGN KEY (home_loc_id) REFERENCES Location,
    FOREIGN KEY (current_loc_id) REFERENCES Location);

CREATE TABLE Event(
    event_id VARCHAR2(100), loc_id VARCHAR2(100) NOT NULL,
    host_id VARCHAR2(100) NOT NULL, creator_id VARCHAR2(100) NOT NULL,
    ename VARCHAR2(100), tagline VARCHAR2(1000), description VARCHAR2(4000), 
    etype VARCHAR2(100), stype VARCHAR2(100), stime TIMESTAMP(6), etime TIMESTAMP(6),
    PRIMARY KEY (event_id),
    FOREIGN KEY (loc_id) REFERENCES Location,
    FOREIGN KEY (host_id) REFERENCES Users,
    FOREIGN KEY (creator_id) REFERENCES Users);

CREATE TABLE Participant(
    event_id VARCHAR2(100), userid VARCHAR2(100), status VARCHAR2(100),
    PRIMARY KEY (event_id, userid),
    FOREIGN KEY (event_id) REFERENCES Event,
    FOREIGN KEY (userid) REFERENCES Users);

CREATE TABLE Photo(
    photo_id VARCHAR2(100), album_id VARCHAR2(100) NOT NULL,
    modified TIMESTAMP(6), created TIMESTAMP(6), link VARCHAR2(2000), caption VARCHAR2(2000),
    PRIMARY KEY (photo_id));

CREATE TABLE Album(
    album_id VARCHAR2(100), userid VARCHAR2(100) NOT NULL,
    cover_photo_id VARCHAR2(100) NOT NULL, name VARCHAR2(100),
    created TIMESTAMP(6), modified TIMESTAMP(6),
    link VARCHAR2(2000), visibility VARCHAR2(100),
    PRIMARY KEY (album_id),
    FOREIGN KEY (userid) REFERENCES Users,
    UNIQUE (cover_photo_id) );

ALTER TABLE Photo ADD CONSTRAINT photo_ref_album
    FOREIGN KEY (album_id) REFERENCES Album
    INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Album ADD CONSTRAINT album_ref_photo
    FOREIGN KEY (cover_photo_id) REFERENCES Photo
    INITIALLY DEFERRED DEFERRABLE;

CREATE TABLE Tag(
    tag_id VARCHAR2(100), x NUMBER, y NUMBER, time_created TIMESTAMP(6),
    PRIMARY KEY (tag_id));

CREATE TABLE Has(
    userid VARCHAR2(100), tag_id VARCHAR2(100), photo_id VARCHAR2(100),
    PRIMARY KEY (userid, photo_id),
    FOREIGN KEY (userid) REFERENCES Users,
    FOREIGN KEY (tag_id) REFERENCES Tag,
    FOREIGN KEY (photo_id) REFERENCES Photo);

CREATE TABLE Friends(
    uid1 VARCHAR2(100), uid2 VARCHAR2(100),
    PRIMARY KEY (uid1, uid2),
    FOREIGN KEY (uid1) REFERENCES Users,
    FOREIGN KEY (uid2) REFERENCES Users);
    
CREATE TABLE School(
    sid VARCHAR2(100), name VARCHAR2(100),
    PRIMARY KEY (sid) );

CREATE SEQUENCE school_sequence
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER school_trigger
    BEFORE INSERT ON School
    REFERENCING NEW AS NEW
    FOR EACH ROW
    BEGIN
        SELECT school_sequence.nextval INTO :NEW.sid FROM DUAL;
    END;
.
RUN;

CREATE TABLE Attended(
    sid VARCHAR2(100), userid VARCHAR2(100),
    year NUMBER(38), conc CHAR(100), degree VARCHAR2(100),
    FOREIGN KEY (sid) REFERENCES School,
    FOREIGN KEY (userid) REFERENCES Users);


