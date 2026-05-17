/**
 * Generates and inserts cross-reference seeds for MAP tables whose source
 * TYPE tables were empty at initial seed time (modules 5 and 7).
 *
 * Run after populating the source tables:
 *   npx tsx supabase/seeds/seed_maps_generator.ts
 *
 * Requires NEXT_PUBLIC_SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY in env.
 */

import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

async function seedStressResponseMap() {
  const { data: items } = await supabase
    .from('luna_5c_stress_response')
    .select('id')
    .order('sort_order')

  if (!items?.length) { console.log('luna_5c_stress_response: no rows, skipping'); return }

  const pairs: { left_type_id: number; right_type_id: number; weight: number }[] = []
  for (let i = 0; i < items.length; i++) {
    for (let j = i + 1; j < items.length; j++) {
      pairs.push({ left_type_id: items[i].id, right_type_id: items[j].id, weight: 0.5 })
    }
  }

  const { error } = await supabase.from('luna_5c_stress_response_map').insert(pairs)
  if (error) console.error('luna_5c_stress_response_map:', error.message)
  else console.log(`luna_5c_stress_response_map: inserted ${pairs.length} rows`)
}

async function seedBodySignalMap() {
  const { data: items } = await supabase
    .from('luna_5d_body_signal')
    .select('id')
    .order('sort_order')

  if (!items?.length) { console.log('luna_5d_body_signal: no rows, skipping'); return }

  const pairs: { left_type_id: number; right_type_id: number; weight: number }[] = []
  for (let i = 0; i < items.length; i++) {
    for (let j = i + 1; j < items.length; j++) {
      pairs.push({ left_type_id: items[i].id, right_type_id: items[j].id, weight: 0.5 })
    }
  }

  const { error } = await supabase.from('luna_5d_body_signal_map').insert(pairs)
  if (error) console.error('luna_5d_body_signal_map:', error.message)
  else console.log(`luna_5d_body_signal_map: inserted ${pairs.length} rows`)
}

async function seedGrowthPathMap() {
  const { data: items } = await supabase
    .from('luna_5e_growth_path')
    .select('id, prerequisite_path_id')
    .order('sort_order')

  if (!items?.length) { console.log('luna_5e_growth_path: no rows, skipping'); return }

  // Use declared prerequisites where available, else sequential pairs
  const pairs: { left_type_id: number; right_type_id: number; weight: number }[] = []
  for (const item of items) {
    if (item.prerequisite_path_id) {
      pairs.push({ left_type_id: item.prerequisite_path_id, right_type_id: item.id, weight: 1.0 })
    }
  }

  if (!pairs.length) {
    for (let i = 0; i < items.length - 1; i++) {
      pairs.push({ left_type_id: items[i].id, right_type_id: items[i + 1].id, weight: 0.7 })
    }
  }

  const { error } = await supabase.from('luna_5e_growth_path_map').insert(pairs)
  if (error) console.error('luna_5e_growth_path_map:', error.message)
  else console.log(`luna_5e_growth_path_map: inserted ${pairs.length} rows`)
}

async function seedCorePotentialMap() {
  const { data: core } = await supabase
    .from('luna_7c_core_potential')
    .select('id, coping_id')
    .order('sort_order')

  const { data: deep } = await supabase
    .from('luna_7d_deep_potential')
    .select('id')
    .order('sort_order')

  if (!core?.length || !deep?.length) {
    console.log('luna_7c_core_potential or luna_7d_deep_potential: no rows, skipping')
    return
  }

  // Match by sort position (1:1 where possible, else cross-product sample)
  const pairs: { core_potential_type_id: number; deep_potential_type_id: number; weight: number }[] = []
  const len = Math.min(core.length, deep.length)
  for (let i = 0; i < len; i++) {
    pairs.push({ core_potential_type_id: core[i].id, deep_potential_type_id: deep[i].id, weight: 0.8 })
  }

  const { error } = await supabase.from('luna_7c_potential_map').insert(pairs)
  if (error) console.error('luna_7c_potential_map:', error.message)
  else console.log(`luna_7c_potential_map: inserted ${pairs.length} rows`)
}

async function seedVisionMap() {
  const { data: visions } = await supabase
    .from('luna_9a_vision_archetypes')
    .select('id, potential_id')
    .order('sort_order')

  if (!visions?.length) { console.log('luna_9a_vision_archetypes: no rows, skipping'); return }

  // Map vision archetype → core potential where declared, else omit
  const pairs: { vision_archetype_id: number; right_type_id: number; weight: number }[] = []
  for (const v of visions) {
    if (v.potential_id) {
      pairs.push({ vision_archetype_id: v.id, right_type_id: v.potential_id, weight: 0.8 })
    }
  }

  if (!pairs.length) { console.log('luna_9c_vision_map: no potential_id references found, skipping'); return }

  const { error } = await supabase.from('luna_9c_vision_map').insert(pairs)
  if (error) console.error('luna_9c_vision_map:', error.message)
  else console.log(`luna_9c_vision_map: inserted ${pairs.length} rows`)
}

async function main() {
  console.log('Seeding MAP tables...')
  await seedStressResponseMap()
  await seedBodySignalMap()
  await seedGrowthPathMap()
  await seedCorePotentialMap()
  await seedVisionMap()
  console.log('Done.')
}

main().catch(console.error)
