CREATE TABLE luna_8c_values_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_8a_values_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid REFERENCES luna_8a_coping_strategy_types(id)
);
