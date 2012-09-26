INSERT INTO Location (city, state, country)
    SELECT DISTINCT
        HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY
    FROM PUBLIC_USER_INFORMATION
    UNION
    SELECT DISTINCT
        CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY
    FROM PUBLIC_USER_INFORMATION
    UNION
    SELECT DISTINCT
        EVENT_CITY, EVENT_STATE, EVENT_COUNTRY
    FROM PUBLIC_EVENT_INFORMATION;

INSERT INTO Users (userid, first, last, yob, mob, dob, gender)
    SELECT DISTINCT
        user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender
    FROM public_user_information; 

UPDATE users
    SET home_loc_id = (
        SELECT DISTINCT loc_id
        FROM location l, public_user_information pui
        WHERE (pui.user_id = users.userid AND
            l.city = pui.hometown_city AND
            l.state = pui.hometown_state AND
            l.country = pui.hometown_country));

UPDATE users
    SET current_loc_id = (
        SELECT DISTINCT loc_id
        FROM location l, public_user_information pui
        WHERE (pui.user_id = users.userid AND
            l.city = pui.current_city AND
            l.state = pui.current_state AND
            l.country = pui.current_country));

INSERT INTO event (event_id, host_id, creator_id, loc_id)
    SELECT DISTINCT
        event_id, event_host, event_creator_id, loc_id
    FROM public_event_information pei, location l
    WHERE pei.event_city = l.city
    AND pei.event_state = l.state
    AND pei.event_country = l.country;

