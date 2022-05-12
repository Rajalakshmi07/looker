view: intent_level_view {
  derived_table: {
    explore_source: dialogflow_cleaned_logs {
      column: session_id {field:dialogflow_cleaned_logs.session_id}

      column: timestamp {field:dialogflow_cleaned_logs.time_stamp_raw }
      column: intents {field:dialogflow_cleaned_logs.intent_triggered}
      bind_all_filters: yes
    }

  }
  dimension: session_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.session_id ;;
  }
  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.timestamp ;;

  }
  dimension: intents {
    type: string
    sql: ${TABLE}.intents ;;
  }

 }
