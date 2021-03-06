/* Copyright (c) 2014, Oracle and/or its affiliates. All rights reserved.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; version 2 of the License.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA */

/*
 * Table: sys_config
 *
 * Stores configuration options for sys objects
 *
 */

CREATE TABLE IF NOT EXISTS sys_config (
    variable VARCHAR(128) PRIMARY KEY,
    value VARCHAR(128),
    set_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    set_by VARCHAR(128)
) ENGINE = InnoDB;

/*
 * Trigger: sys_config_update_set_user
 *
 * Sets the user that updates configuration
 *
 */

DELIMITER //

DROP TRIGGER IF EXISTS sys_config_update_set_user//

CREATE TRIGGER sys_config_update_set_user BEFORE UPDATE on sys_config
    FOR EACH ROW
BEGIN
    IF NEW.set_by IS NULL THEN
        SET NEW.set_by = USER();
    END IF;
END//

DELIMITER ;

/*
 * Trigger: sys_config_insert_set_user
 *
 * Sets the user that inserts configuration
 *
 */

DELIMITER //

DROP TRIGGER IF EXISTS sys_config_insert_set_user//

CREATE TRIGGER sys_config_insert_set_user BEFORE INSERT on sys_config
    FOR EACH ROW
BEGIN
    IF NEW.set_by IS NULL THEN
        SET NEW.set_by = USER();
    END IF;
END//

DELIMITER ;

INSERT IGNORE INTO sys_config (variable, value)
VALUES ('statement_truncate_len', 64);
