view: time_view {
  derived_table: {
    explore_source: dialogflow_cleaned_logs {
      column: session_id {field:dialogflow_cleaned_logs.session_id}

      column: timestamp {field:dialogflow_cleaned_logs.time_stamp_raw }
      derived_column: min_timestamp {sql: min(timestamp) over (partition by session_id );;}
      derived_column: max_timestamp {sql: max(timestamp) over (partition by session_id );;}
      bind_all_filters: yes
  }

  }
  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }
  dimension: session_duration_sec {
    type: number
    sql: timestamp_diff(${TABLE}.max_timestamp,${TABLE}.min_timestamp,second) ;;
  }
  dimension: session_duration_min {
    type: number
    sql: timestamp_diff(${TABLE}.max_timestamp,${TABLE}.min_timestamp,minute) ;;
  }

}
