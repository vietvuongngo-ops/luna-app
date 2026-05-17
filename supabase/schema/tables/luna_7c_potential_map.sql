CREATE TABLE luna_7c_potential_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_7a_core_potential_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid REFERENCES luna_7a_deep_potential_types(id)
);
