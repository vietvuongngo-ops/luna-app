CREATE TABLE luna_5c_stress_response_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_5a_stress_response_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);
