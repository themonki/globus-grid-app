------------------------------------------------------------------------------------------
-- Users
------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS usr_user CASCADE;
DROP SEQUENCE IF EXISTS usr_user_usr_id_seq;

CREATE SEQUENCE usr_user_usr_id_seq INCREMENT 1 START 1;

CREATE TABLE usr_user (
  usr_id integer DEFAULT NEXTVAL('usr_user_usr_id_seq'::TEXT) NOT NULL,
	usr_email varchar(20)  NOT NULL,
	usr_password varchar(1000) NOT NULL,
	usr_status boolean DEFAULT FALSE,
	usr_name varchar(200),
	usr_usersystem varchar(200)
);

ALTER TABLE usr_user ADD CONSTRAINT PK_usr_user
	PRIMARY KEY (usr_id);
	
ALTER TABLE usr_user
	ADD CONSTRAINT UQ_usr_user_email UNIQUE (usr_email);

------------------------------------------------------------------------------------------
-- Certs
------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS crt_cert CASCADE;
DROP SEQUENCE IF EXISTS crt_cert_crt_id_seq;

CREATE SEQUENCE crt_cert_crt_id_seq INCREMENT 1 START 1;

CREATE TABLE crt_cert (
  crt_id integer DEFAULT NEXTVAL('crt_cert_crt_id_seq'::TEXT) NOT NULL,
  usr_id integer NOT NULL,
	crt_serial varchar(200)  NOT NULL,
	crt_issue varchar(1000) NOT NULL,
	crt_keypass varchar(2000),
	crt_keypath varchar(2000),
	crt_certpath varchar(2000),
	crt_proxypath varchar(2000)
);

ALTER TABLE crt_cert ADD CONSTRAINT PK_crt_cert
	PRIMARY KEY (crt_id);
ALTER TABLE crt_cert ADD CONSTRAINT FK_crt_cert_usr_user 
	FOREIGN KEY (usr_id) REFERENCES usr_user (usr_id)
ON DELETE CASCADE ON UPDATE CASCADE;


------------------------------------------------------------------------------------------
-- Relation Users Certs
------------------------------------------------------------------------------------------

--DROP TABLE IF EXISTS ruc_relationusercert;

--CREATE TABLE ruc_relationusercert (
--  usr_id integer NOT NULL,
--  crt_id integer NOT NULL
--);

--ALTER TABLE ruc_relationusercert ADD CONSTRAINT PK_ruc_relationusercert
--	PRIMARY KEY (usr_id, crt_id);
--ALTER TABLE ruc_relationusercert ADD CONSTRAINT FK_ruc_relationusercert_usr_user 
--	FOREIGN KEY (usr_id) REFERENCES usr_user (usr_id)
--ON DELETE CASCADE ON UPDATE CASCADE;
--ALTER TABLE ruc_relationusercert ADD CONSTRAINT FK_ruc_relationusercert_crt_cert 
--	FOREIGN KEY (crt_id) REFERENCES crt_cert (crt_id)
--ON DELETE CASCADE ON UPDATE CASCADE;

------------------------------------------------------------------------------------------
-- Jobs
------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS job_job CASCADE;
DROP SEQUENCE IF EXISTS job_job_job_id_seq;

CREATE SEQUENCE job_job_job_id_seq INCREMENT 1 START 1;

CREATE TABLE job_job (
  job_id integer DEFAULT NEXTVAL('job_job_job_id_seq'::TEXT) NOT NULL,
  usr_id integer NOT NULL,
	job_name varchar(200)  NOT NULL,
	job_date timestamp,
	job_path varchar(1000),
	job_contact varchar(1000)
);

ALTER TABLE job_job ADD CONSTRAINT PK_job_job
	PRIMARY KEY (job_id);
ALTER TABLE job_job ADD CONSTRAINT FK_job_job_usr_user 
	FOREIGN KEY (usr_id) REFERENCES usr_user (usr_id)
ON DELETE CASCADE ON UPDATE CASCADE;

