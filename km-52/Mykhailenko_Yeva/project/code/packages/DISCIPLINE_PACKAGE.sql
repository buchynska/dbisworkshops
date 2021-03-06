create PACKAGE DISCIPLINE_PACKAGE AS

FUNCTION check_discipline(
        disc_name DISCIPLINE.DISCIPLINE_NAME%TYPE
    ) RETURN NUMBER;
    
FUNCTION GET_DISCIPLINE_HW(
    DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE
)RETURN SYS_REFCURSOR;

FUNCTION GET_DISCIPLINE_MARKS(
    DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE
)RETURN SYS_REFCURSOR;

FUNCTION GET_DISCIPLINE(
      disc_name DISCIPLINE.DISCIPLINE_NAME%TYPE
    )RETURN SYS_REFCURSOR;

FUNCTION ALL_DISCIPLINE
RETURN SYS_REFCURSOR;

PROCEDURE ADD_DISCIPLINE(
    DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE
);

PROCEDURE DELETE_DISCIPLINE(
    DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE
);

PROCEDURE UPDATE_DISCIPLINE(
    DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE,
    NEW_DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE
);

END DISCIPLINE_PACKAGE;
/

create PACKAGE BODY DISCIPLINE_PACKAGE IS
    
    FUNCTION check_discipline ( disc_name DISCIPLINE.DISCIPLINE_NAME%TYPE
    ) RETURN NUMBER IS
        res   NUMBER(1);
    BEGIN
        SELECT
            COUNT(*)
        INTO res
        FROM
            DISCIPLINE
        WHERE
            DISCIPLINE_NAME = disc_name;

        return(res);
    END check_discipline;


    FUNCTION GET_DISCIPLINE_HW(
    DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE
    )RETURN SYS_REFCURSOR
    IS
      cursorchik SYS_REFCURSOR;
    BEGIN
    OPEN cursorchik FOR
        SELECT DISTINCT TEACHER.TEACHER_NAME, HOMEWORK.HW_DATE, HOMEWORK.HW_DESCRIPTION
        FROM HOMEWORK JOIN TEACHER ON HOMEWORK.CONTRACT_ID = TEACHER.CONTRACT_ID
        WHERE HOMEWORK.DISCIPLINE_NAME = DSCPLN_NAME;
    RETURN cursorchik;
    END GET_DISCIPLINE_HW;

    FUNCTION GET_DISCIPLINE_MARKS(
    DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE
    )RETURN SYS_REFCURSOR
    IS
      cursorchik SYS_REFCURSOR;
    BEGIN
    OPEN cursorchik FOR
        SELECT DISTINCT STUDENT.STUDENT_NAME, MARK.ST_YEAR, MARK.MARK
        FROM MARK JOIN STUDENT ON
        MARK.CARD_ID = STUDENT.CARD_ID
        WHERE MARK.DISCIPLINE_NAME = DSCPLN_NAME AND MARK.DELETED is NULL;
    RETURN cursorchik;
    END GET_DISCIPLINE_MARKS;

    FUNCTION GET_DISCIPLINE(
      disc_name DISCIPLINE.DISCIPLINE_NAME%TYPE
    )
      RETURN SYS_REFCURSOR
    IS
      cursorchik SYS_REFCURSOR;
    BEGIN
      OPEN cursorchik FOR
        SELECT *
        FROM DISCIPLINE
            WHERE DISCIPLINE.DISCIPLINE_NAME = disc_name;
      RETURN cursorchik;
    END GET_DISCIPLINE;

    FUNCTION ALL_DISCIPLINE
      RETURN SYS_REFCURSOR
    IS
      cursorchik SYS_REFCURSOR;
    BEGIN
      OPEN cursorchik FOR
        SELECT *
        FROM DISCIPLINE;
    RETURN cursorchik;
    END ALL_DISCIPLINE;

    PROCEDURE ADD_DISCIPLINE(
    DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE
    )
    IS
    BEGIN
    INSERT INTO DISCIPLINE (DISCIPLINE_NAME)
    VALUES (DSCPLN_NAME);
    COMMIT;
    END ADD_DISCIPLINE;

    PROCEDURE DELETE_DISCIPLINE(
    DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE
    )
    IS
    BEGIN
    DELETE FROM DISCIPLINE
    WHERE DISCIPLINE.DISCIPLINE_NAME  = DSCPLN_NAME;
    COMMIT;
    END DELETE_DISCIPLINE;

    PROCEDURE UPDATE_DISCIPLINE(
    DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE,
    NEW_DSCPLN_NAME IN DISCIPLINE.DISCIPLINE_NAME%TYPE
    )
    IS
    BEGIN
    UPDATE DISCIPLINE 
    SET DISCIPLINE.DISCIPLINE_NAME = NEW_DSCPLN_NAME
    WHERE DISCIPLINE.DISCIPLINE_NAME = DSCPLN_NAME;
    COMMIT;
    END UPDATE_DISCIPLINE;

END DISCIPLINE_PACKAGE;
/

