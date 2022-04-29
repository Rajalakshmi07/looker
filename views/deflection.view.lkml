view: deflection {

  derived_table: {
    explore_source: dialogflow_cleaned_logs {
      column: session_id {field:dialogflow_cleaned_logs.session_id}

      column: fallback_count {field:dialogflow_cleaned_logs.fallback_count }
      column: agent_count {field:dialogflow_cleaned_logs.agent_count}
      bind_all_filters: yes
    }
    }

  dimension:session_id{
    type: string
    primary_key: yes
    sql: ${TABLE}.session_id ;;
  }
  dimension: fallback_count {
    type: number
    sql: ${TABLE}.fallback_count ;;
  }
  dimension: agent_count {
    type: number
    sql: ${TABLE}.agent_count ;;
  }

  dimension: deflection_distribution {
    type: string
    sql:  case
          when ( ${fallback_count}=0 and ${agent_count}=0 ) then "Number of sessions that were successfully handled with bot end to end"
          when (${fallback_count}>=1 and ${agent_count}=0 ) then "Number of sessions that were partially handled by the bot and had atleast one query unanswered but not transfered to live agent"
          when (${fallback_count}>=1 and ${agent_count} >=1) then "Number of sessions that were transferred to live agent and has atleast one fallback query"
          else "Number of sessions that were transferred to live agent as per the expected flow but had not fallback query"
          end ;;
  }

 }
