connection: "bigquery"
label: "Customer Service"

include: "*_zendesk_block.view"
include: "*_zendesk_variables.view"
include: "*.dashboard"
include: "/views/*.view"

explore: ticket {
  label: "Ticketing Analytics"
  join: assignee {
    sql_on: ${ticket.assignee_id} = ${assignee.id} ;;
    relationship: many_to_one
  }

  join: requester {
    sql_on: ${ticket.requester_id} = ${requester.id} ;;
    relationship: many_to_one
  }

  join: group_member {
    sql_on: ${assignee.id} = ${group_member.user_id} ;;
    relationship: many_to_one
  }

  join: group {
    sql_on: ${group_member.group_id} = ${group.id} ;;
    relationship: many_to_one
  }

  join: brand {
    type: left_outer
    sql_on: ${ticket.brand_id} = ${brand.id} ;;
    relationship: many_to_one
  }

  join: ticket_comment {
    type: left_outer
    sql_on: ${ticket.id} = ${ticket_comment.ticket_id} ;;
    relationship: one_to_many
  }

  join: commenter {
    sql_on: ${ticket_comment.user_id} = ${commenter.id} ;;
    relationship: many_to_one
  }

  join: ticket_assignee_facts {
    type: left_outer
    sql_on: ${ticket.assignee_id} = ${ticket_assignee_facts.assignee_id} ;;
    relationship: many_to_one
  }

  join: ticket_tag {
    view_label: "Ticket tags"
    type: left_outer
    sql_on: ${ticket.id} = ${ticket_tag.ticket_id} ;;
    relationship: one_to_many
  }

  join: ticket_tag_history {
    view_label: "Ticket tags history"
    type: left_outer
    sql_on: ${ticket.id} = ${ticket_tag_history.ticket_id} ;;
    relationship: one_to_many
  }

  join: zendesk_user {
    view_label: "All Users"
    type: left_outer
    sql_on: ${ticket_tag_history.user_id} = ${zendesk_user.id} ;;
    relationship: many_to_one
  }

  join: ticket_detail_data {
    view_label: "Ticket"
    type: left_outer
    sql_on: ${ticket_detail_data.ticket_id} =  ${ticket.id} ;;
    relationship: one_to_one
  }

  join: ticket_comments {
    view_label: "Ticket"
    type: left_outer
    sql_on: ${ticket_comments.ticket_id} =  ${ticket.id} ;;
    relationship: one_to_one
  }

  join: satisfaction_rating {
    view_label: "Satisfaction Rating"
    type: left_outer
    sql_on: ${satisfaction_rating.ticket_id} =  ${ticket.id} ;;
    relationship: one_to_one
  }

  # metric queries

  join: ticket_history_facts {
    sql_on: ${ticket.id} = ${ticket_history_facts.ticket_id} ;;
    relationship: one_to_one
  }

  join: number_of_reopens {
    sql_on: ${ticket.id} = ${number_of_reopens.ticket_id} ;;
    relationship: one_to_one
  }
}
