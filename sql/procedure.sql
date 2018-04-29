DROP PROCEDURE IF EXISTS deleteProcedure;
DELIMITER //
CREATE  PROCEDURE `deleteProcedure`(IN tab_name VARCHAR(100), IN id INT)
BEGIN
        SET @t1 =CONCAT('DELETE FROM ', tab_name, ' WHERE ID=', id);
        PREPARE stmt3 FROM @t1;
        EXECUTE stmt3;
        DEALLOCATE PREPARE stmt3;
END //
DELIMITER ;
# test call the procedure
CALL deleteProcedure('movie', 5);
