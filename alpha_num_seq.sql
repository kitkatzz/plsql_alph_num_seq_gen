CREATE OR REPLACE FORCE VIEW alpha_numeric_seq 
AS 
SELECT d1 AS digit_1
,d2 AS digit_2
, lvl AS level_num,
CASE WHEN d1 > 0 AND d2 < 27 THEN 
    CHR(d1 + ASCII('A')-1) || CHR(d2 + ASCII('A')-1)
ELSE
    CHR(d1 + ASCII('A')-1)|| (d2 - 26)
END alpha_num_seq
FROM (
     SELECT MOD((LEVEL-1),36) d2,
            MOD( TRUNC((LEVEL-0.1)/36), 36) d1,
               LEVEL lvl
      FROM DUAL
    CONNECT BY LEVEL <= 974  -- Stop at Z9
          )
    WHERE (d2>0 AND d1>0)   -- don't include anything before AA
      AND d1 < 27            -- quit after Z9
      AND d2 not in (9, 15) -- skip I and O
      AND d1 not in (9, 15) -- skip I and O
/
