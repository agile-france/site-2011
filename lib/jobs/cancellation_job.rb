class CancellationJob
  @queue :cancellation

  def self.perform
    Execution.orphaned.all
  end
end