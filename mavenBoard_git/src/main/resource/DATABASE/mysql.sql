CREATE TABLE FREEBOARD(
	NUM INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(20),
    TITLE VARCHAR(100),
    CONTENT VARCHAR(1000),
    REGDATE DATETIME
);

INSERT INTO FREEBOARD(
	NAME,
    TITLE,
    CONTENT,
    REGDATE
)VALUES(
	'TEST1'
	,'TEST1'
	,'TEST1'
	,SYSDATE()
);