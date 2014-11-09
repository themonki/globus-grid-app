

INSERT INTO usr_user (usr_email, usr_password, usr_status, usr_name, usr_usersystem)
VALUES  ('vagrant@gmail.com',md5('Vagrant123'), true,'Vagrant User','vagrant');

INSERT INTO crt_cert 
VALUES (DEFAULT, 1, '02','/O=Grid/OU=GlobusTest/OU=simpleCA-mg.globustest.org/CN=Globus Simple CA' , 'vagrant',
 '/home/vagrant/.globus/userkey.pem', '/home/vagrant/.globus/usercert.pem', '/home/vagrant/.globus/x509up_u500' );

--INSERT INTO ruc_relationusercert
--VALUES (1,1);
