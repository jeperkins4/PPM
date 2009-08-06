DELIMITER $$

    
    DROP PROCEDURE IF EXISTS updaterefs$$
    
    CREATE DEFINER=`private`@`%` PROCEDURE `updaterefs`()
    BEGIN
          DECLARE idMaster, indexM, ref_id INT DEFAULT 0;
          DECLARE ref_name CHAR(255);
          DECLARE cur1 CURSOR FOR SELECT id, NAME FROM pppams_references;
          OPEN cur1;
          SET idMaster = (SELECT FOUND_ROWS());
          WHILE indexM<idMaster DO
      FETCH cur1 INTO ref_id, ref_name;
      INSERT INTO pppams_indicators_pppams_references(pppams_indicator_id, pppams_reference_id) SELECT pppams_indicators.id, ref_id FROM pppams_indicators WHERE reference LIKE CONCAT('%', ref_name,'%');
      SET indexM=indexM+1;
          END WHILE;
        END$$
    
DELIMITER ;