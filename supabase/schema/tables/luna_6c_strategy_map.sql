CREATE TABLE luna_6c_strategy_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_6a_core_strategy_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid REFERENCES luna_6a_expression_strategy_types(id)
);
