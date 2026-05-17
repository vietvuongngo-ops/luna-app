CREATE TABLE luna_4c_life_phase_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_4a_life_phase_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);
