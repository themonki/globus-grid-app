DROP DATABASE IF EXISTS globusdatabase;

DROP USER IF EXISTS globus;

CREATE USER globus WITH PASSWORD 'globus';

CREATE DATABASE globusdatabase OWNER globus;
