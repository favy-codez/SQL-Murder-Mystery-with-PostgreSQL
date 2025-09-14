/*
A crime has taken place and the detective needs your help. The detective gave you the crime scene 
report, but you somehow lost it. You vaguely remember that the crime was a murder that occured 
sometime on Jan 15 2018 and that it took place in SQL City. Start by retreiving the corresponding 
crime scene report from the police department's database
*/

SELECT * FROM crime_scene_report;

/* 
You vaguely remember that the crime was a murder that occured sometime on Jan 15 2018 and that 
it took place in SQL City 
*/

SELECT * FROM crime_scene_report
WHERE Date = 20180115 AND City = 'SQL City';

SELECT * FROM crime_scene_report
WHERE Date = 20180115 AND City = 'SQL City' AND crime_type = 'murder';

/*
Security fotage shows that they were 2 witnesses
The first witness lives at the last house on "Northwestern Dr". 
While the second witness named Annabell lives somewhere on "Franklin Ave".
*/

SELECT * FROM Person

-- Find Witness 1 - The first witness lives at the last house on "Northwestern Dr". 
SELECT * FROM Person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC;

/* RESULT
Morty Schapiro is our first witness -  id- 14887, license_id - 118009, address_number - 4919
address_street_name - Northwestern Dr, ssn - 111564949
*/

-- Find Witness 2 - The second witness named Anabel lives somewhere on "Franklin Ave".
SELECT * FROM Person
WHERE name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave';

/* RESULT
Annabel Miller is our second witness -  id- 16371, license_id - 490173, address_number - 103
address_street_name - Franklin Ave, ssn - 318771143
*/

-- Find the interview scripts of the 2 witnesses
SELECT * FROM interview
WHERE person_id IN (14887, 16371);
/*
Morty said : I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The 
membership number on the bag started with "48Z". Only gold members have those bags. The man got 
into a car with a plate that included "H42W".

Anabell said : I saw the murder happen, and I recognized the killer from my gym when I was working 
out last week on January the 9th.
*/

-- Find suspects whose membership id has 48Z in it and whose membership_status is gold
SELECT * FROM get_fit_now_member
WHERE id LIKE '%48Z%' AND membership_status = 'gold';

/*
Suspect 1 : Joe Germuska with id 48Z7A, person_id = 28819, membership_start_date = 20160305
membership_status = gold

Suspect 2 : Jeremy Bowers with id 48Z55, person_id = 67318, membership_start_date = 20160101
membership_status = gold
*/

-- Narrow down the search by finding out which of the suspects checked in on 2018-01-09
SELECT * FROM get_fit_now_check_in
WHERE check_in_date = 20180109
AND membership_id IN ('48Z7A', '48Z55');
-- Both suspects checked in on 2018-01-09

/*
According to our witness 1 - Morty Schapiro the suspect is a man and got into a car with 
a plate number that included H42W
*/

SELECT * FROM drivers_license
WHERE gender = 'male' AND plate_number LIKE '%H42W%';

/*
It appears both suspects in the gym on the 9th, hence a good work around will be to query out the
details based off of the license number, to do that we could join the 2 tables- persons table and 
license table 
*/
CREATE TABLE license_and_person_table AS (SELECT dl.age, dl.height, dl.hair_color, dl.gender, 
	dl.plate_number, dl.car_make, dl.car_model, p.name, p.ssn, p.address_street_name, p.id
FROM drivers_license AS dl
LEFT JOIN person AS p
ON dl.id = p.license_id);

SELECT * FROM license_and_person_table;

SELECT p.name, dl.age, dl.height, dl.hair_color, dl.gender, 
	dl.plate_number, dl.car_make, dl.car_model, p.ssn, p.address_street_name, p.id
FROM drivers_license AS dl
LEFT JOIN person AS p
ON dl.id = p.license_id
WHERE plate_number LIKE '%H42W%' OR plate_number LIKE 'H42W%' OR plate_number LIKE '%H42W';

-- Jeremy Bowers is the killer

/*
Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, 
try querying the interview transcript of the murderer to find the real villain behind this crime. 
If you feel especially confident in your SQL skills, try to complete this final step with no more 
than 2 queries. Use this same INSERT statement with your new suspect to check your answer.
*/
SELECT * FROM interview
WHERE person_id = 67318;

/*
I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" 
(65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended 
the SQL Symphony Concert 3 times in December 2017.
*/

/*
Breaking it down 
Detail 1 - I was hired by a woman with a lot of money. 
Detail 2 - I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
Detail 3 - She has red hair and she drives a Tesla Model S. 
Detail 4 - I know that she attended the SQL Symphony Concert 3 times in December 2017.
*/

-- Based on Detail 2 and 3 from the murderer's interview. 
SELECT dl.*, p.*
FROM drivers_license AS dl
LEFT JOIN person AS p
	ON dl.id = p.license_id
WHERE height BETWEEN 65 AND 67
	AND hair_color = 'red'
	AND gender = 'female'
	AND car_make = 'Tesla'
	AND car_model = 'Model S'

-- Our new suspects are Red Korb with id 78881, Regina George with  id 90700,
-- and Miranda Priestly with id 99716.

-- From Detail 4
SELECT *
FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
	AND person_id IN ('78881', '90700', '99716');

/* The person with id 99716 attended the SQL Symphony Concert 3 times in December 2017, 
this makes Miranda Priestly the woman who hired Jeremy Bowers to carry out the murder
*/

-- Based Detail 1 
SELECT i.*, p.name, p.id
FROM income AS i
LEFT JOIN person as p
ON i.ssn = p.ssn 
WHERE id = 99716;

-- We find that Miranda Priestly makes 310,000 as her annual income. 

-- Finally, Miranda Priestly hired Jeremy Bowers to carry out the murder.
-- This investigation confirms their direct involvement in the murder case.

