CREATE TABLE USUARIOS (
  ID_U NUMBER(20) CONSTRAINT USUARIOS_PK PRIMARY KEY,
  USUARIO VARCHAR2(30) CONSTRAINT USUARIOS_UK1 UNIQUE
                      CONSTRAINT USUARIOS_NN1 NOT NULL,
  E_MAIL  VARCHAR2(60) CONSTRAINT USUARIOS_UK2 UNIQUE
                      CONSTRAINT USUARIOS_NN2 NOT NULL,
  NOMBRE VARCHAR2(30) CONSTRAINT USUARIOS_NN3 NOT NULL,
  APELLIDO1 VARCHAR(30) CONSTRAINT USUARIOS_NN4 NOT NULL,
  APELLIDO2 VARCHAR2(30),
  PASSW VARCHAR2(100) CONSTRAINT USUARIOS_NN5 NOT NULL
);

CREATE TABLE POST (
  ID_U NUMBER(20) CONSTRAINT POST_FK1 REFERENCES USUARIOS(ID_U) ON DELETE CASCADE
                  CONSTRAINT POST_NN2 NOT NULL,
  PID NUMBER(20) CONSTRAINT POST_PK PRIMARY KEY,
  TEXTO VARCHAR2(1000) CONSTRAINT POST_NN1 NOT NULL,
  PID_REL NUMBER(20) CONSTRAINT POST_FK2 REFERENCES POST ON DELETE SET NULL,
  PUBLICACION DATE CONSTRAINT POST_NN3 NOT NULL,
  DURACION INTERVAL DAY TO SECOND CONSTRAINT POST_NN4 NOT NULL,
  CONSTRAINT POST_CK1 CHECK (PUBLICACION>TO_DATE('02/02/2017','DD/MM/YYYY')  )
);


CREATE TABLE CONTACTOS (
  ID_U NUMBER(20) CONSTRAINT CONTACTOS_FK1 REFERENCES USUARIOS(ID_U) ON DELETE CASCADE,
  CONTACTO NUMBER(20) CONSTRAINT CONSTACTOS_FK2 REFERENCES USUARIOS(ID_U) ON DELETE CASCADE,
  CONSTRAINT CONTACTOS_PK PRIMARY KEY (ID_U,CONTACTO),
  CONSTRAINT CONTACTOS_CK1 CHECK (ID_U != CONTACTO )
);

CREATE TABLE SER_VISIBLE(
  ID_U NUMBER(20),
  CONTACTO NUMBER(20),
  PID NUMBER(20) CONSTRAINT SER_VISIBLE_FK2 REFERENCES POST
                                                ON DELETE CASCADE,
  CONSTRAINT SER_VISIBLE_PK PRIMARY KEY (ID_U,CONTACTO,PID),
  CONSTRAINT SER_VISIBLE_FK1 FOREIGN KEY (ID_U,CONTACTO)
    REFERENCES CONTACTOS(ID_U,CONTACTO)

);
----------------------------------------------EJ2

ALTER TABLE POST ADD (
CONSTRAINT POST_CK2 CHECK ( DURACION >= INTERVAL '30' MINUTE)
  );

RENAME SER_VISIBLE TO COMPARTIR;

ALTER TABLE USUARIOS RENAME CONSTRAINT USUARIOS_PK TO SUPERCLAVE;

ALTER TABLE POST MODIFY (
  PUBLICACION DEFAULT CURRENT_DATE
  );

ALTER TABLE USUARIOS DISABLE CONSTRAINT USUARIOS_NN5;

ALTER TABLE POST ADD(
  VISIBLE CHAR(2) DEFAULT 'SI',
  CONSTRAINT POST_CK3 CHECK ( VISIBLE='NO' OR VISIBLE='SI')
  );

-----------------------------------------------EJ3

INSERT INTO USUARIOS (ID_U, USUARIO, E_MAIL, NOMBRE, APELLIDO1, APELLIDO2, PASSW)
VALUES (1, 'RAMONGAR','RAMON@HOTMAIL.COM', 'RAMON', 'GARCIA', 'ORTIGAL', '1234' );

INSERT INTO USUARIOS (ID_U, USUARIO, E_MAIL, NOMBRE, APELLIDO1, PASSW)
VALUES (2, 'LURDITA','LURDITA@BBC.CO.UK', 'LOURDES', 'ATIENZA', '1234' );

INSERT INTO USUARIOS (ID_U, USUARIO, E_MAIL, NOMBRE, APELLIDO1, APELLIDO2, PASSW)
VALUES (3, 'MARIOSO','MARIOSOL9@YAHOO.COM', 'MARISOL', 'JIMENEZ', 'DEL OSO', '1234' );

INSERT INTO USUARIOS (ID_U, USUARIO, E_MAIL, NOMBRE, APELLIDO1, APELLIDO2, PASSW)
VALUES (4, 'SERCAL','SERCAL1980@GMAIL.COM', 'FRANCISCO', 'SERRANO', 'CALVO', '1234' );

COMMIT;