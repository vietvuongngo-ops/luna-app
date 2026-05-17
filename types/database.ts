export type Json = string | number | boolean | null | { [key: string]: Json | undefined } | Json[]

export interface Database {
  public: {
    Tables: {

      // ── Module 0 ──────────────────────────────────────────────────────────

      luna_0_profiles: {
        Row: {
          id: string
          name: string | null
          email: string | null
          first_name: string | null
          last_name: string | null
          preferred_name: string | null
          birthdate: string | null
          gender: string | null
          language: string | null
          timezone: string | null
          avatar_url: string | null
          onboarding_status: string | null
          current_phase: string | null
          dominant_dimension: string | null
          nervous_system_baseline: string | null
          identity_stage: number | null
          growth_score: number | null
          is_active: boolean | null
          source: string | null
          session_count: number | null
          coaching_goal: string | null
          consent_given: boolean
          old_id: number | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id: string
          name?: string | null
          email?: string | null
          first_name?: string | null
          last_name?: string | null
          preferred_name?: string | null
          birthdate?: string | null
          gender?: string | null
          language?: string | null
          timezone?: string | null
          avatar_url?: string | null
          onboarding_status?: string | null
          current_phase?: string | null
          dominant_dimension?: string | null
          nervous_system_baseline?: string | null
          identity_stage?: number | null
          growth_score?: number | null
          is_active?: boolean | null
          source?: string | null
          session_count?: number | null
          coaching_goal?: string | null
          consent_given: boolean
          old_id?: number | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_0_profiles']['Insert']>
      }

      luna_0a_message: {
        Row: {
          id: string
          profile_id: string | null
          session_id: string | null
          message_text: string
          channel: string | null
          direction: string | null
          sequence_number: number | null
          language: string | null
          audio_url: string | null
          is_voice_message: boolean | null
          audio_duration_ms: number | null
          transcript_confidence: number | null
          message_type: string | null
          emotion_detected: string | null
          topic_tag: string | null
          is_flagged: boolean | null
          metadata: Json | null
          token_count: number | null
          processing_status: string | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          session_id?: string | null
          message_text: string
          channel?: string | null
          direction?: string | null
          sequence_number?: number | null
          language?: string | null
          audio_url?: string | null
          is_voice_message?: boolean | null
          audio_duration_ms?: number | null
          transcript_confidence?: number | null
          message_type?: string | null
          emotion_detected?: string | null
          topic_tag?: string | null
          is_flagged?: boolean | null
          metadata?: Json | null
          token_count?: number | null
          processing_status?: string | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_0a_message']['Insert']>
      }

      luna_0b_context: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          context_text: string | null
          topic: string | null
          urgency: number | null
          location_marker: string | null
          life_phase_snapshot: string | null
          previous_topics: Json | null
          topic_category: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          context_text?: string | null
          topic?: string | null
          urgency?: number | null
          location_marker?: string | null
          life_phase_snapshot?: string | null
          previous_topics?: Json | null
          topic_category?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_0b_context']['Insert']>
      }

      // ── Module 1 ──────────────────────────────────────────────────────────

      luna_1a_emotion_types: {
        Row: {
          id: string
          name: string | null
          description: string | null
          emotion_secondary: string | null
          valence: string | null
          emotion_category: string | null
          metadata: Json | null
          short_label: string | null
          color_hex: string | null
          icon_url: string | null
          famous_examples: Json | null
          intensity_default: number | null
          plutchik_primary: string | null
          plutchik_opposite: string | null
          diagnostic_question: string | null
          koerper_signal: string | null
          kernwunde: string | null
          lichtseite: string | null
          schattenseite: string | null
          wachstumschance: string | null
          stressverhalten: string | null
          ki_prompt_style: string | null
          sort_order: number | null
          created_at: string | null
          updated_at: string | null
        }
        Insert: {
          id?: string
          name?: string | null
          description?: string | null
          emotion_secondary?: string | null
          valence?: string | null
          emotion_category?: string | null
          metadata?: Json | null
          short_label?: string | null
          color_hex?: string | null
          icon_url?: string | null
          famous_examples?: Json | null
          intensity_default?: number | null
          plutchik_primary?: string | null
          plutchik_opposite?: string | null
          diagnostic_question?: string | null
          koerper_signal?: string | null
          kernwunde?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          wachstumschance?: string | null
          stressverhalten?: string | null
          ki_prompt_style?: string | null
          sort_order?: number | null
          created_at?: string | null
          updated_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_1a_emotion_types']['Insert']>
      }

      luna_1a_need_types: {
        Row: {
          id: string
          name: string
          short_label: string
          category: string
          valence: string
          intensity_low: string | null
          intensity_medium: string | null
          intensity_high: string | null
          color_hex: string | null
          icon_url: string | null
          description: string | null
          coaching_hint: string | null
          diagnostic_question: string | null
          koerper_signal: string | null
          kernwunde: string | null
          lichtseite: string | null
          schattenseite: string | null
          wachstumschance: string | null
          stressverhalten: string | null
          ki_prompt_style: string | null
          sdt_category: string | null
          maslow_level: number | null
          rosenberg_category: string | null
          related_needs: Json | null
          sort_order: number | null
          famous_examples: Json | null
          created_at: string | null
          updated_at: string | null
        }
        Insert: {
          id?: string
          name: string
          short_label: string
          category: string
          valence: string
          intensity_low?: string | null
          intensity_medium?: string | null
          intensity_high?: string | null
          color_hex?: string | null
          icon_url?: string | null
          description?: string | null
          coaching_hint?: string | null
          diagnostic_question?: string | null
          koerper_signal?: string | null
          kernwunde?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          wachstumschance?: string | null
          stressverhalten?: string | null
          ki_prompt_style?: string | null
          sdt_category?: string | null
          maslow_level?: number | null
          rosenberg_category?: string | null
          related_needs?: Json | null
          sort_order?: number | null
          famous_examples?: Json | null
          created_at?: string | null
          updated_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_1a_need_types']['Insert']>
      }

      luna_1b_emotion_events: {
        Row: {
          id: string
          profile_id: string
          message_id: string
          session_id: string
          emotion_type_id: string
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          valence: string | null
          is_primary: boolean | null
          body_signal: string | null
          trigger_context: string | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id: string
          message_id: string
          session_id: string
          emotion_type_id: string
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          valence?: string | null
          is_primary?: boolean | null
          body_signal?: string | null
          trigger_context?: string | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_1b_emotion_events']['Insert']>
      }

      luna_1c_emotion_need_map: {
        Row: {
          id: string
          emotion: string
          primary_need: string
          secondary_needs: Json | null
          diagnostic_pattern: string | null
          coaching_strategy: string | null
          emotion_type_id: number | null
          body_bridge: string | null
          sort_order: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          emotion: string
          primary_need: string
          secondary_needs?: Json | null
          diagnostic_pattern?: string | null
          coaching_strategy?: string | null
          emotion_type_id?: number | null
          body_bridge?: string | null
          sort_order?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_1c_emotion_need_map']['Insert']>
      }

      // ── Module 2 ──────────────────────────────────────────────────────────

      luna_2a_archetypes: {
        Row: {
          id: number
          name: string
          description: string | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          typisches_muster: string | null
          kernfrage: string | null
          kernwunde: string | null
          koerper_signal: string | null
          beziehungsmuster: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          pearson_category: string | null
          related_archetypes: Json | null
          sort_order: number | null
          element: string | null
          short_label: string | null
          color_hex: string | null
          icon_url: string | null
          coaching_approach: string | null
          famous_examples: Json | null
        }
        Insert: {
          id?: number
          name: string
          description?: string | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          typisches_muster?: string | null
          kernfrage?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          beziehungsmuster?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          pearson_category?: string | null
          related_archetypes?: Json | null
          sort_order?: number | null
          element?: string | null
          short_label?: string | null
          color_hex?: string | null
          icon_url?: string | null
          coaching_approach?: string | null
          famous_examples?: Json | null
        }
        Update: Partial<Database['public']['Tables']['luna_2a_archetypes']['Insert']>
      }

      luna_2a_user_archetypes: {
        Row: {
          id: string
          profile_id: string
          archetype_id: number
          type: string | null
          intensity: number | null
          profile_id_new: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          profile_id: string
          archetype_id: number
          type?: string | null
          intensity?: number | null
          profile_id_new?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_2a_user_archetypes']['Insert']>
      }

      luna_2b_core_motivation: {
        Row: {
          id: number
          name: string
          description: string | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          typisches_muster: string | null
          beziehungsmuster: string | null
          kernfrage: string | null
          avoided_value: string | null
          sdt_category: string | null
          enneagramm_type: string | null
          related_motivations: Json | null
          sort_order: number | null
          short_label: string | null
          color_hex: string | null
          icon_url: string | null
          coaching_approach: string | null
          famous_examples: Json | null
          opposite_motivation: string | null
          intensity_default: number | null
        }
        Insert: {
          id?: number
          name: string
          description?: string | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          typisches_muster?: string | null
          beziehungsmuster?: string | null
          kernfrage?: string | null
          avoided_value?: string | null
          sdt_category?: string | null
          enneagramm_type?: string | null
          related_motivations?: Json | null
          sort_order?: number | null
          short_label?: string | null
          color_hex?: string | null
          icon_url?: string | null
          coaching_approach?: string | null
          famous_examples?: Json | null
          opposite_motivation?: string | null
          intensity_default?: number | null
        }
        Update: Partial<Database['public']['Tables']['luna_2b_core_motivation']['Insert']>
      }

      luna_2b_need_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          need: string
          priority: number | null
          need_secondary: string | null
          need_category: string | null
          emotion_id: string | null
          fulfillment_level: number | null
          profile_id_new: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          need: string
          priority?: number | null
          need_secondary?: string | null
          need_category?: string | null
          emotion_id?: string | null
          fulfillment_level?: number | null
          profile_id_new?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_2b_need_events']['Insert']>
      }

      luna_2b_user_motivations: {
        Row: {
          id: string
          profile_id: string
          motivation_id: number
          intensity: number | null
          avoided_value: string | null
          profile_id_new: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          profile_id: string
          motivation_id: number
          intensity?: number | null
          avoided_value?: string | null
          profile_id_new?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_2b_user_motivations']['Insert']>
      }

      luna_2c_core_identity_types: {
        Row: {
          id: string
          profile_id: string | null
          identity_statement: string
          archetype_id: number | null
          motivation_id: number | null
          version: number
          is_current: boolean
          confidence_level: number | null
          derived_from_session: string | null
          shadow_aspect: string | null
          growth_edge: string | null
          statement_source: string | null
          coach_note: string | null
          created_at: string | null
          updated_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          identity_statement: string
          archetype_id?: number | null
          motivation_id?: number | null
          version: number
          is_current: boolean
          confidence_level?: number | null
          derived_from_session?: string | null
          shadow_aspect?: string | null
          growth_edge?: string | null
          statement_source?: string | null
          coach_note?: string | null
          created_at?: string | null
          updated_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_2c_core_identity_types']['Insert']>
      }

      luna_2c_core_identity_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          identity_type_id: string | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          identity_type_id?: string | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_2c_core_identity_events']['Insert']>
      }

      luna_2c_core_identity_map: {
        Row: {
          id: string
          left_type_id: string | null
          right_type_id: string | null
          weight: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          left_type_id?: string | null
          right_type_id?: string | null
          weight?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_2c_core_identity_map']['Insert']>
      }

      luna_2c_identity_templates: {
        Row: {
          id: number
          name: string
          identity_statement: string
        }
        Insert: {
          id?: number
          name: string
          identity_statement: string
        }
        Update: Partial<Database['public']['Tables']['luna_2c_identity_templates']['Insert']>
      }

      // ── Module 3 ──────────────────────────────────────────────────────────

      luna_3a_nervous_system: {
        Row: {
          id: number
          name: string
          description: string
          system_state: string
          coaching_possible: boolean
          polyvagal_level: string | null
          activation_level: number | null
          somatic_markers: Json | null
          ki_response_strategy: string | null
          intervention_type: string | null
          sort_order: number | null
        }
        Insert: {
          id?: number
          name: string
          description: string
          system_state: string
          coaching_possible: boolean
          polyvagal_level?: string | null
          activation_level?: number | null
          somatic_markers?: Json | null
          ki_response_strategy?: string | null
          intervention_type?: string | null
          sort_order?: number | null
        }
        Update: Partial<Database['public']['Tables']['luna_3a_nervous_system']['Insert']>
      }

      luna_3b_nervous_system_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          nervous_system_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          nervous_system_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_3b_nervous_system_events']['Insert']>
      }

      luna_3c_nervous_system_map: {
        Row: {
          id: string
          left_type_id: number | null
          right_type_id: number | null
          weight: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          left_type_id?: number | null
          right_type_id?: number | null
          weight?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_3c_nervous_system_map']['Insert']>
      }

      // ── Module 4 ──────────────────────────────────────────────────────────

      luna_4a_life_phase: {
        Row: {
          id: number
          name: string
          description: string | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          typische_dauer: string | null
          coaching_fokus: string | null
          nervous_system_state: string | null
          phase_type: string | null
          age_range: string | null
          core_need: string | null
          typisches_muster: string | null
          kernfrage: string | null
          beziehungsmuster: string | null
          sort_order: number | null
          erikson_stage: string | null
          levinson_stage: string | null
          related_phases: Json | null
          transition_triggers: Json | null
          crisis_indicators: Json | null
          phase_archetype: string | null
        }
        Insert: {
          id?: number
          name: string
          description?: string | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          typische_dauer?: string | null
          coaching_fokus?: string | null
          nervous_system_state?: string | null
          phase_type?: string | null
          age_range?: string | null
          core_need?: string | null
          typisches_muster?: string | null
          kernfrage?: string | null
          beziehungsmuster?: string | null
          sort_order?: number | null
          erikson_stage?: string | null
          levinson_stage?: string | null
          related_phases?: Json | null
          transition_triggers?: Json | null
          crisis_indicators?: Json | null
          phase_archetype?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_4a_life_phase']['Insert']>
      }

      luna_4b_user_life_phase: {
        Row: {
          id: string
          profile_id: string
          life_phase_id: number
          session_id: string | null
          is_current: boolean | null
          transition_note: string | null
          crisis_level: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          profile_id: string
          life_phase_id: number
          session_id?: string | null
          is_current?: boolean | null
          transition_note?: string | null
          crisis_level?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_4b_user_life_phase']['Insert']>
      }

      luna_4c_life_phase_map: {
        Row: {
          id: string
          left_type_id: number | null
          right_type_id: number | null
          weight: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          left_type_id?: number | null
          right_type_id?: number | null
          weight?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_4c_life_phase_map']['Insert']>
      }

      // ── Module 5 ──────────────────────────────────────────────────────────

      luna_5a_protective_pattern: {
        Row: {
          id: number
          name: string
          description: string | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          nervous_system_state: string | null
          kernwunde_beschreibung: string | null
          kernwunde_ursprung: string | null
        }
        Insert: {
          id?: number
          name: string
          description?: string | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          nervous_system_state?: string | null
          kernwunde_beschreibung?: string | null
          kernwunde_ursprung?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_5a_protective_pattern']['Insert']>
      }

      luna_5c_stress_response: {
        Row: {
          id: number
          name: string
          description: string
          protective_pattern_id: number | null
          nervous_system_state_id: number | null
          response_type: string | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          somatic_markers: Json | null
          regulation_strategy: string | null
          trigger_patterns: Json | null
          activation_speed: string | null
          duration_typical: string | null
          related_responses: Json | null
          sort_order: number | null
          coaching_fokus: string | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name: string
          description: string
          protective_pattern_id?: number | null
          nervous_system_state_id?: number | null
          response_type?: string | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          somatic_markers?: Json | null
          regulation_strategy?: string | null
          trigger_patterns?: Json | null
          activation_speed?: string | null
          duration_typical?: string | null
          related_responses?: Json | null
          sort_order?: number | null
          coaching_fokus?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_5c_stress_response']['Insert']>
      }

      luna_5c_stress_response_map: {
        Row: {
          id: string
          left_type_id: number | null
          right_type_id: number | null
          weight: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          left_type_id?: number | null
          right_type_id?: number | null
          weight?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_5c_stress_response_map']['Insert']>
      }

      luna_5d_body_signal: {
        Row: {
          id: number
          name: string
          description: string | null
          body_area: string | null
          protective_pattern_id: number | null
          nervous_system_state_id: number | null
          stress_response_id: number | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          sensation_type: string | null
          intensity_typical: number | null
          emotion_connection: string | null
          damasio_marker_type: string | null
          awareness_cue: string | null
          regulation_technique: string | null
          related_signals: Json | null
          sort_order: number | null
          coaching_fokus: string | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name: string
          description?: string | null
          body_area?: string | null
          protective_pattern_id?: number | null
          nervous_system_state_id?: number | null
          stress_response_id?: number | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          sensation_type?: string | null
          intensity_typical?: number | null
          emotion_connection?: string | null
          damasio_marker_type?: string | null
          awareness_cue?: string | null
          regulation_technique?: string | null
          related_signals?: Json | null
          sort_order?: number | null
          coaching_fokus?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_5d_body_signal']['Insert']>
      }

      luna_5d_body_signal_map: {
        Row: {
          id: string
          left_type_id: number | null
          right_type_id: number | null
          weight: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          left_type_id?: number | null
          right_type_id?: number | null
          weight?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_5d_body_signal_map']['Insert']>
      }

      luna_5e_growth_path: {
        Row: {
          id: number
          name: string
          description: string
          micro_practice: string | null
          protective_pattern_id: number | null
          shadow_pattern_id: number | null
          stress_response_id: number | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          difficulty_level: number | null
          duration_weeks: number | null
          success_indicator: string | null
          vision_connection: string | null
          prerequisite_path_id: number | null
          related_growth_paths: Json | null
          sort_order: number | null
          nervous_system_state: string | null
          coaching_fokus: string | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name: string
          description: string
          micro_practice?: string | null
          protective_pattern_id?: number | null
          shadow_pattern_id?: number | null
          stress_response_id?: number | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          difficulty_level?: number | null
          duration_weeks?: number | null
          success_indicator?: string | null
          vision_connection?: string | null
          prerequisite_path_id?: number | null
          related_growth_paths?: Json | null
          sort_order?: number | null
          nervous_system_state?: string | null
          coaching_fokus?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_5e_growth_path']['Insert']>
      }

      luna_5e_growth_path_map: {
        Row: {
          id: string
          left_type_id: number | null
          right_type_id: number | null
          weight: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          left_type_id?: number | null
          right_type_id?: number | null
          weight?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_5e_growth_path_map']['Insert']>
      }

      // ── Module 6 ──────────────────────────────────────────────────────────

      luna_6a_core_drive: {
        Row: {
          id: number
          name: string | null
          description: string | null
          archetype_id: number | null
          motivation_id: number | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          drive_category: string | null
          flow_trigger: string | null
          energy_source: string | null
          blind_spot: string | null
          overuse_risk: string | null
          ki_prompt_style: string | null
          related_drives: Json | null
          sort_order: number | null
          nervous_system_state: string | null
          coaching_fokus: string | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          description?: string | null
          archetype_id?: number | null
          motivation_id?: number | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          drive_category?: string | null
          flow_trigger?: string | null
          energy_source?: string | null
          blind_spot?: string | null
          overuse_risk?: string | null
          ki_prompt_style?: string | null
          related_drives?: Json | null
          sort_order?: number | null
          nervous_system_state?: string | null
          coaching_fokus?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_6a_core_drive']['Insert']>
      }

      luna_6b_core_strategy: {
        Row: {
          id: number
          name: string
          description: string | null
          archetype_id: number | null
          motivation_id: number | null
          core_drive_id: number | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          strategy_category: string | null
          application_context: string | null
          overuse_pattern: string | null
          blind_spot: string | null
          energy_source: string | null
          failure_mode: string | null
          integration_path: string | null
          ki_prompt_style: string | null
          related_strategies: Json | null
          nervous_system_state: string | null
          coaching_fokus: string | null
          sort_order: number | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name: string
          description?: string | null
          archetype_id?: number | null
          motivation_id?: number | null
          core_drive_id?: number | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          strategy_category?: string | null
          application_context?: string | null
          overuse_pattern?: string | null
          blind_spot?: string | null
          energy_source?: string | null
          failure_mode?: string | null
          integration_path?: string | null
          ki_prompt_style?: string | null
          related_strategies?: Json | null
          nervous_system_state?: string | null
          coaching_fokus?: string | null
          sort_order?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_6b_core_strategy']['Insert']>
      }

      luna_6b_core_strategy_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          core_strategy_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          core_strategy_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_6b_core_strategy_events']['Insert']>
      }

      luna_6c_expression_strategy: {
        Row: {
          id: number
          name: string
          description: string | null
          drive_id: number | null
          strategy_id: number | null
          archetype_id: number | null
          motivation_id: number | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          expression_channel: string | null
          context_variation: string | null
          shadow_expression: string | null
          ki_communication_style: string | null
          related_expressions: Json | null
          sort_order: number | null
          nervous_system_state: string | null
          coaching_fokus: string | null
          famous_examples: Json | null
          short_label: string | null
          color_hex: string | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name: string
          description?: string | null
          drive_id?: number | null
          strategy_id?: number | null
          archetype_id?: number | null
          motivation_id?: number | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          expression_channel?: string | null
          context_variation?: string | null
          shadow_expression?: string | null
          ki_communication_style?: string | null
          related_expressions?: Json | null
          sort_order?: number | null
          nervous_system_state?: string | null
          coaching_fokus?: string | null
          famous_examples?: Json | null
          short_label?: string | null
          color_hex?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_6c_expression_strategy']['Insert']>
      }

      luna_6c_expression_strategy_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          expression_strategy_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          expression_strategy_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_6c_expression_strategy_events']['Insert']>
      }

      luna_6c_strategy_map: {
        Row: {
          id: string
          core_strategy_type_id: number | null
          expression_strategy_type_id: number | null
          weight: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          core_strategy_type_id?: number | null
          expression_strategy_type_id?: number | null
          weight?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_6c_strategy_map']['Insert']>
      }

      luna_6d_effect_space: {
        Row: {
          id: number
          name: string | null
          description: string | null
          drive_id: number | null
          strategy_id: number | null
          expression_id: number | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          sort_order: number | null
          nervous_system_state: string | null
          coaching_fokus: string | null
          effect_type: string | null
          unintended_effect: string | null
          context_dependency: string | null
          relationship_impact: string | null
          leadership_impact: string | null
          ki_awareness_prompt: string | null
          related_effects: Json | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          description?: string | null
          drive_id?: number | null
          strategy_id?: number | null
          expression_id?: number | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          sort_order?: number | null
          nervous_system_state?: string | null
          coaching_fokus?: string | null
          effect_type?: string | null
          unintended_effect?: string | null
          context_dependency?: string | null
          relationship_impact?: string | null
          leadership_impact?: string | null
          ki_awareness_prompt?: string | null
          related_effects?: Json | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_6d_effect_space']['Insert']>
      }

      luna_6d_effect_space_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          effect_space_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          effect_space_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_6d_effect_space_events']['Insert']>
      }

      // ── Module 7 ──────────────────────────────────────────────────────────

      luna_7a_core_need: {
        Row: {
          id: number
          name: string
          description: string | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          need_category: string | null
          unmet_pattern: string | null
          fulfillment_path: string | null
          shadow_need: string | null
          emotional_signature: string | null
          somatic_signature: string | null
          behavioral_marker: string | null
          related_needs: Json | null
          ki_prompt_style: string | null
          famous_examples: Json | null
          short_label: string | null
          color_hex: string | null
          icon_url: string | null
          archetype_id: number | null
          motivation_id: number | null
          core_drive_id: number | null
          core_strategy_id: number | null
          expression_id: number | null
          effect_id: number | null
          nervous_system_state: string | null
          coaching_fokus: string | null
          sort_order: number | null
          sdt_category: string | null
          maslow_level: number | null
          fulfillment_level: number | null
          violation_impact: string | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name: string
          description?: string | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          need_category?: string | null
          unmet_pattern?: string | null
          fulfillment_path?: string | null
          shadow_need?: string | null
          emotional_signature?: string | null
          somatic_signature?: string | null
          behavioral_marker?: string | null
          related_needs?: Json | null
          ki_prompt_style?: string | null
          famous_examples?: Json | null
          short_label?: string | null
          color_hex?: string | null
          icon_url?: string | null
          archetype_id?: number | null
          motivation_id?: number | null
          core_drive_id?: number | null
          core_strategy_id?: number | null
          expression_id?: number | null
          effect_id?: number | null
          nervous_system_state?: string | null
          coaching_fokus?: string | null
          sort_order?: number | null
          sdt_category?: string | null
          maslow_level?: number | null
          fulfillment_level?: number | null
          violation_impact?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_7a_core_need']['Insert']>
      }

      luna_7b_coping_strategy: {
        Row: {
          id: number
          name: string
          description: string | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          coping_category: string | null
          trigger_pattern: string | null
          short_term_effect: string | null
          long_term_cost: string | null
          emotional_signature: string | null
          somatic_signature: string | null
          behavioral_marker: string | null
          transformation_path: string | null
          related_coping: Json | null
          ki_prompt_style: string | null
          famous_examples: Json | null
          short_label: string | null
          color_hex: string | null
          archetype_id: number | null
          motivation_id: number | null
          core_drive_id: number | null
          core_strategy_id: number | null
          expression_id: number | null
          effect_id: number | null
          need_id: number | null
          nervous_system_state: string | null
          coaching_fokus: string | null
          sort_order: number | null
          adaptivity: string | null
          stress_level_trigger: number | null
          sdt_impact: string | null
          icon_url: string | null
          maslow_level: number | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name: string
          description?: string | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          coping_category?: string | null
          trigger_pattern?: string | null
          short_term_effect?: string | null
          long_term_cost?: string | null
          emotional_signature?: string | null
          somatic_signature?: string | null
          behavioral_marker?: string | null
          transformation_path?: string | null
          related_coping?: Json | null
          ki_prompt_style?: string | null
          famous_examples?: Json | null
          short_label?: string | null
          color_hex?: string | null
          archetype_id?: number | null
          motivation_id?: number | null
          core_drive_id?: number | null
          core_strategy_id?: number | null
          expression_id?: number | null
          effect_id?: number | null
          need_id?: number | null
          nervous_system_state?: string | null
          coaching_fokus?: string | null
          sort_order?: number | null
          adaptivity?: string | null
          stress_level_trigger?: number | null
          sdt_impact?: string | null
          icon_url?: string | null
          maslow_level?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_7b_coping_strategy']['Insert']>
      }

      luna_7b_coping_strategy_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          coping_strategy_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          coping_strategy_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_7b_coping_strategy_events']['Insert']>
      }

      luna_7c_core_potential_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          core_potential_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          core_potential_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_7c_core_potential_events']['Insert']>
      }

      luna_7c_potential_map: {
        Row: {
          id: string
          core_potential_type_id: number | null
          deep_potential_type_id: number | null
          weight: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          core_potential_type_id?: number | null
          deep_potential_type_id?: number | null
          weight?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_7c_potential_map']['Insert']>
      }

      luna_7d_deep_potential_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          deep_potential_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          deep_potential_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_7d_deep_potential_events']['Insert']>
      }

      luna_7e_being_potential_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          being_potential_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          being_potential_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_7e_being_potential_events']['Insert']>
      }

      // ── Module 8 ──────────────────────────────────────────────────────────

      luna_8a_core_values: {
        Row: {
          id: number
          name: string
          description: string
          opposite: string | null
          pattern_conflict: string | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          emotional_signature: string | null
          somatic_signature: string | null
          behavioral_marker: string | null
          development_stage: string | null
          adaptivity: string | null
          sdt_connection: string | null
          maslow_level: number | null
          vision_connection: string | null
          short_label: string | null
          color_hex: string | null
          icon_url: string | null
          sort_order: number | null
          ki_prompt_style: string | null
          famous_examples: Json | null
          archetype_id: number | null
          motivation_id: number | null
          core_drive_id: number | null
          core_strategy_id: number | null
          expression_id: number | null
          effect_id: number | null
          need_id: number | null
          coping_id: number | null
          potential_id: number | null
          deep_potential_id: number | null
          being_id: number | null
          nervous_system_state: string | null
          coaching_fokus: string | null
          value_category: string | null
          fulfillment_level: number | null
          violation_signal: string | null
          behavioral_expression: string | null
          shadow_value: string | null
          cultural_variation: string | null
          related_values: Json | null
          flow_conditions: string | null
          integration_level: number | null
          value_conflict_pair: Json | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name: string
          description: string
          opposite?: string | null
          pattern_conflict?: string | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          emotional_signature?: string | null
          somatic_signature?: string | null
          behavioral_marker?: string | null
          development_stage?: string | null
          adaptivity?: string | null
          sdt_connection?: string | null
          maslow_level?: number | null
          vision_connection?: string | null
          short_label?: string | null
          color_hex?: string | null
          icon_url?: string | null
          sort_order?: number | null
          ki_prompt_style?: string | null
          famous_examples?: Json | null
          archetype_id?: number | null
          motivation_id?: number | null
          core_drive_id?: number | null
          core_strategy_id?: number | null
          expression_id?: number | null
          effect_id?: number | null
          need_id?: number | null
          coping_id?: number | null
          potential_id?: number | null
          deep_potential_id?: number | null
          being_id?: number | null
          nervous_system_state?: string | null
          coaching_fokus?: string | null
          value_category?: string | null
          fulfillment_level?: number | null
          violation_signal?: string | null
          behavioral_expression?: string | null
          shadow_value?: string | null
          cultural_variation?: string | null
          related_values?: Json | null
          flow_conditions?: string | null
          integration_level?: number | null
          value_conflict_pair?: Json | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8a_core_values']['Insert']>
      }

      luna_8a_user_values: {
        Row: {
          id: string
          profile_id: string | null
          value_id: number | null
          fulfillment_level: number | null
          conflict_notes: string | null
          session_id: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          value_id?: number | null
          fulfillment_level?: number | null
          conflict_notes?: string | null
          session_id?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8a_user_values']['Insert']>
      }

      luna_8b_coping_strategy: {
        Row: {
          id: number
          name: string | null
          description: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          description?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8b_coping_strategy']['Insert']>
      }

      luna_8b_coping_strategy_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          coping_strategy_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          coping_strategy_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8b_coping_strategy_events']['Insert']>
      }

      luna_8b_relationship_pattern: {
        Row: {
          id: number
          name: string
          description: string
          attachment_style: string | null
          core_fear: string | null
          protective_pattern: string | null
          coaching_note: string | null
        }
        Insert: {
          id?: number
          name: string
          description: string
          attachment_style?: string | null
          core_fear?: string | null
          protective_pattern?: string | null
          coaching_note?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8b_relationship_pattern']['Insert']>
      }

      luna_8b_relationship_pattern_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          relationship_pattern_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          relationship_pattern_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8b_relationship_pattern_events']['Insert']>
      }

      luna_8c_core_potential_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          core_potential_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          core_potential_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8c_core_potential_events']['Insert']>
      }

      luna_8c_resources: {
        Row: {
          id: number
          name: string
          description: string
          resource_type: string | null
          coaching_impact: string | null
          resource_category: string | null
          activation_path: string | null
          depletion_signal: string | null
          renewal_method: string | null
          related_resources: Json | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          emotional_signature: string | null
          somatic_signature: string | null
          behavioral_marker: string | null
          development_stage: string | null
          adaptivity: string | null
          sdt_connection: string | null
          maslow_level: number | null
          flow_conditions: string | null
          integration_level: number | null
          short_label: string | null
          color_hex: string | null
          icon_url: string | null
          sort_order: number | null
          ki_prompt_style: string | null
          famous_examples: Json | null
          archetype_id: number | null
          motivation_id: number | null
          core_drive_id: number | null
          core_strategy_id: number | null
          expression_id: number | null
          effect_id: number | null
          need_id: number | null
          coping_id: number | null
          potential_id: number | null
          deep_potential_id: number | null
          being_id: number | null
          nervous_system_state: string | null
          coaching_fokus: string | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name: string
          description: string
          resource_type?: string | null
          coaching_impact?: string | null
          resource_category?: string | null
          activation_path?: string | null
          depletion_signal?: string | null
          renewal_method?: string | null
          related_resources?: Json | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          emotional_signature?: string | null
          somatic_signature?: string | null
          behavioral_marker?: string | null
          development_stage?: string | null
          adaptivity?: string | null
          sdt_connection?: string | null
          maslow_level?: number | null
          flow_conditions?: string | null
          integration_level?: number | null
          short_label?: string | null
          color_hex?: string | null
          icon_url?: string | null
          sort_order?: number | null
          ki_prompt_style?: string | null
          famous_examples?: Json | null
          archetype_id?: number | null
          motivation_id?: number | null
          core_drive_id?: number | null
          core_strategy_id?: number | null
          expression_id?: number | null
          effect_id?: number | null
          need_id?: number | null
          coping_id?: number | null
          potential_id?: number | null
          deep_potential_id?: number | null
          being_id?: number | null
          nervous_system_state?: string | null
          coaching_fokus?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8c_resources']['Insert']>
      }

      luna_8c_resources_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          resources_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          resources_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8c_resources_events']['Insert']>
      }

      luna_8c_values_map: {
        Row: {
          id: string
          core_values_type_id: number | null
          coping_strategy_type_id: number | null
          weight: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          core_values_type_id?: number | null
          coping_strategy_type_id?: number | null
          weight?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8c_values_map']['Insert']>
      }

      luna_8d_deep_potential: {
        Row: {
          id: number
          name: string
          description: string | null
          diagnostic_question: string | null
          state: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          aktivierung: string | null
          blockade: string | null
        }
        Insert: {
          id?: number
          name: string
          description?: string | null
          diagnostic_question?: string | null
          state?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          aktivierung?: string | null
          blockade?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8d_deep_potential']['Insert']>
      }

      luna_8d_deep_potential_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          deep_potential_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          deep_potential_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8d_deep_potential_events']['Insert']>
      }

      luna_8e_being_potential: {
        Row: {
          id: number
          name: string | null
          description: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          description?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8e_being_potential']['Insert']>
      }

      luna_8e_being_potential_events: {
        Row: {
          id: string
          profile_id: string | null
          message_id: string | null
          session_id: string | null
          being_potential_type_id: number | null
          intensity: number | null
          confidence_primary: number | null
          confidence_secondary: number | null
          model_source: string | null
          processing_status: string | null
          token_count: number | null
          metadata: Json | null
          is_primary: boolean | null
          created_at: string | null
          updated_at: string | null
          deleted_at: string | null
        }
        Insert: {
          id?: string
          profile_id?: string | null
          message_id?: string | null
          session_id?: string | null
          being_potential_type_id?: number | null
          intensity?: number | null
          confidence_primary?: number | null
          confidence_secondary?: number | null
          model_source?: string | null
          processing_status?: string | null
          token_count?: number | null
          metadata?: Json | null
          is_primary?: boolean | null
          created_at?: string | null
          updated_at?: string | null
          deleted_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_8e_being_potential_events']['Insert']>
      }

      // ── Module 9 ──────────────────────────────────────────────────────────

      luna_9a_vision_archetypes: {
        Row: {
          id: number
          name: string
          description: string
          vision_type: string | null
          guiding_question: string | null
          pattern_released: string | null
          vision_category: string | null
          embodiment_marker: string | null
          transcendence_path: string | null
          shadow_vision: string | null
          related_visions: Json | null
          vision_archetype: string | null
          vision_expression: string | null
          diagnostic_question: string | null
          lichtseite: string | null
          schattenseite: string | null
          kernwunde: string | null
          koerper_signal: string | null
          stressverhalten: string | null
          wachstumschance: string | null
          emotional_signature: string | null
          somatic_signature: string | null
          behavioral_marker: string | null
          development_stage: string | null
          adaptivity: string | null
          sdt_connection: string | null
          maslow_level: number | null
          flow_conditions: string | null
          integration_level: number | null
          short_label: string | null
          color_hex: string | null
          icon_url: string | null
          sort_order: number | null
          ki_prompt_style: string | null
          famous_examples: Json | null
          archetype_id: number | null
          motivation_id: number | null
          core_drive_id: number | null
          core_strategy_id: number | null
          expression_id: number | null
          effect_id: number | null
          need_id: number | null
          coping_id: number | null
          potential_id: number | null
          deep_potential_id: number | null
          being_id: number | null
          value_id: number | null
          resource_id: number | null
          vision_core_id: number | null
          deep_vision_id: number | null
          being_vision_id: number | null
          nervous_system_state: string | null
          coaching_fokus: string | null
          created_at: string | null
        }
        Insert: {
          id?: number
          name: string
          description: string
          vision_type?: string | null
          guiding_question?: string | null
          pattern_released?: string | null
          vision_category?: string | null
          embodiment_marker?: string | null
          transcendence_path?: string | null
          shadow_vision?: string | null
          related_visions?: Json | null
          vision_archetype?: string | null
          vision_expression?: string | null
          diagnostic_question?: string | null
          lichtseite?: string | null
          schattenseite?: string | null
          kernwunde?: string | null
          koerper_signal?: string | null
          stressverhalten?: string | null
          wachstumschance?: string | null
          emotional_signature?: string | null
          somatic_signature?: string | null
          behavioral_marker?: string | null
          development_stage?: string | null
          adaptivity?: string | null
          sdt_connection?: string | null
          maslow_level?: number | null
          flow_conditions?: string | null
          integration_level?: number | null
          short_label?: string | null
          color_hex?: string | null
          icon_url?: string | null
          sort_order?: number | null
          ki_prompt_style?: string | null
          famous_examples?: Json | null
          archetype_id?: number | null
          motivation_id?: number | null
          core_drive_id?: number | null
          core_strategy_id?: number | null
          expression_id?: number | null
          effect_id?: number | null
          need_id?: number | null
          coping_id?: number | null
          potential_id?: number | null
          deep_potential_id?: number | null
          being_id?: number | null
          value_id?: number | null
          resource_id?: number | null
          vision_core_id?: number | null
          deep_vision_id?: number | null
          being_vision_id?: number | null
          nervous_system_state?: string | null
          coaching_fokus?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_9a_vision_archetypes']['Insert']>
      }

      luna_9b_user_vision: {
        Row: {
          id: string
          profile_id: string
          vision_archetype_id: number | null
          vision_statement: string
          life_area: string | null
          vision_horizon: string | null
          current_reality: string | null
          first_step: string | null
          success_indicator: string | null
          confidence_level: number | null
          values_alignment: string | null
          growth_path_id: number | null
          relationship_id: number | null
          version: number | null
          is_current: boolean | null
          session_id: string | null
          created_at: string | null
          updated_at: string | null
        }
        Insert: {
          id?: string
          profile_id: string
          vision_archetype_id?: number | null
          vision_statement: string
          life_area?: string | null
          vision_horizon?: string | null
          current_reality?: string | null
          first_step?: string | null
          success_indicator?: string | null
          confidence_level?: number | null
          values_alignment?: string | null
          growth_path_id?: number | null
          relationship_id?: number | null
          version?: number | null
          is_current?: boolean | null
          session_id?: string | null
          created_at?: string | null
          updated_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_9b_user_vision']['Insert']>
      }

      luna_9c_vision_map: {
        Row: {
          id: string
          vision_archetype_id: number | null
          right_type_id: number | null
          weight: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          vision_archetype_id?: number | null
          right_type_id?: number | null
          weight?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_9c_vision_map']['Insert']>
      }

      // ── Utility / Program tables ──────────────────────────────────────────

      luna_programs: {
        Row: {
          id: string
          title: string
          description: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          title: string
          description?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_programs']['Insert']>
      }

      luna_map_program_modules: {
        Row: {
          id: string
          program_id: string | null
          title: string
          description: string | null
          position: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          program_id?: string | null
          title: string
          description?: string | null
          position?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_map_program_modules']['Insert']>
      }

      luna_module_lessons: {
        Row: {
          id: string
          module_id: string | null
          title: string
          content: string | null
          position: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          module_id?: string | null
          title: string
          content?: string | null
          position?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_module_lessons']['Insert']>
      }

      luna_user_journal: {
        Row: {
          id: string
          user_id: string | null
          entry: string
          created_at: string | null
        }
        Insert: {
          id?: string
          user_id?: string | null
          entry: string
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_user_journal']['Insert']>
      }

      luna_user_progress: {
        Row: {
          id: string
          user_id: string | null
          program_id: string | null
          progress: number | null
          created_at: string | null
        }
        Insert: {
          id?: string
          user_id?: string | null
          program_id?: string | null
          progress?: number | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_user_progress']['Insert']>
      }

      luna_user_scores: {
        Row: {
          id: string
          user_id: string | null
          dimension: string
          score: number
          label: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          user_id?: string | null
          dimension: string
          score: number
          label?: string | null
          created_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_user_scores']['Insert']>
      }

      luna_user_profiles: {
        Row: {
          id: string
          display_name: string | null
          avatar_url: string | null
          bio: string | null
          updated_at: string | null
        }
        Insert: {
          id: string
          display_name?: string | null
          avatar_url?: string | null
          bio?: string | null
          updated_at?: string | null
        }
        Update: Partial<Database['public']['Tables']['luna_user_profiles']['Insert']>
      }

    }
    Views: Record<string, never>
    Functions: Record<string, never>
    Enums: Record<string, never>
  }
}

// Convenience row type helpers
export type Tables<T extends keyof Database['public']['Tables']> =
  Database['public']['Tables'][T]['Row']

export type InsertDto<T extends keyof Database['public']['Tables']> =
  Database['public']['Tables'][T]['Insert']

export type UpdateDto<T extends keyof Database['public']['Tables']> =
  Database['public']['Tables'][T]['Update']
