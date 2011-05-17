class OrphanCleanerJob
  @queue = :cancellation

  def self.perform()
    orphaned = Execution.all.reduce([]) do |acc, e|
      OrphanExecutionJob.perform(e.id.to_s) if e.user.nil?
    end
  end
end