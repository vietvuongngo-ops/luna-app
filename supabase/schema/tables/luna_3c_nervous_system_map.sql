CREATE TABLE luna_3c_nervous_system_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_3a_nervous_system_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);
