CREATE TABLE luna_5e_growth_path_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_5a_growth_path_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);
