c = Conference.last
# executions against owner
Execution.where(:user_id.ne => c.owner.id)