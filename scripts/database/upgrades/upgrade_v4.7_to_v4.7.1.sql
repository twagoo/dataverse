-- Adding new columns for "createdtime", "lastlogintime", and "lastapiusetime" 
-- Default "createdtime" to 1/1/2000
-- Dropping "modificationtime" as it is inconsistent between user auths and best replaced by the new columns.
ALTER TABLE authenticateduser ADD COLUMN createdtime TIMESTAMP NOT NULL DEFAULT '01-01-2000 00:00:00';
ALTER TABLE authenticateduser ADD COLUMN lastlogintime TIMESTAMP DEFAULT NULL;
ALTER TABLE authenticateduser ADD COLUMN lastapiusetime TIMESTAMP DEFAULT NULL;
ALTER TABLE authenticateduser DROP COLUMN modificationtime;

-- Removing authenticated builtin users who do not exist in the builtin table because they were created through faulty validation
-- creates view containing authentication ids that you will be deleting
CREATE TEMP VIEW useridstodelete AS (SELECT DISTINCT a.id FROM authenticateduserlookup al, authenticateduser a WHERE al.authenticateduser_id = a.id AND al.authenticationproviderid = 'builtin'  AND a.useridentifier NOT IN (SELECT username FROM builtinuser));
-- commands to remove the users from the appropriate tables
-- TOOD: does this cascade?
DELETE FROM authenticateduserlookup WHERE authenticateduser_id IN (SELECT * FROM useridstodelete);
DELETE FROM confirmemaildata WHERE authenticateduser_id IN (SELECT * FROM useridstodelete);
DELETE FROM usernotification WHERE user_id IN (SELECT * FROM useridstodelete);
DELETE FROM guestbookresponse WHERE authenticateduser_id IN (SELECT * FROM useridstodelete);
DELETE FROM authenticateduser WHERE id IN (SELECT * FROM useridstodelete);