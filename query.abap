DATA: lt_result TYPE TABLE OF ty_result,
      ls_result TYPE ty_result.

TYPES: BEGIN OF ty_result,
         customer_id TYPE zorders-customer_id,
         name        TYPE zcustomers-name,
         total_amt   TYPE p DECIMALS 2,
       END OF ty_result.

SELECT a~customer_id,
       b~name,
       SUM( a~amount ) AS total_amt
  INTO TABLE lt_result
  FROM zorders AS a
  INNER JOIN zcustomers AS b
    ON a~customer_id = b~customer_id
  WHERE a~status = 'DELIVERED'
  GROUP BY a~customer_id, b~name.

LOOP AT lt_result INTO ls_result.
  WRITE: / ls_result-customer_id, ls_result-name, ls_result-total_amt.
ENDLOOP.
