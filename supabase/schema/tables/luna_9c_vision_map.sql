CREATE TABLE luna_9c_vision_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_9a_vision_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);
