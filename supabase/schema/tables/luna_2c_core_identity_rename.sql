-- Rename: luna_2c_core_identity was incorrectly used as an EVENT table.
-- It holds type/classification data and is renamed accordingly.
ALTER TABLE luna_2c_core_identity RENAME TO luna_2c_core_identity_types;
