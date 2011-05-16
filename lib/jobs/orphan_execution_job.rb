class OrphanExecutionJob
  @queue = :cancellation

  def self.perform(id)
    e = Execution.find(id)
    puts "cancelling #{e.id.to_s} : #{e.quantity} #{e.product.ref}"
    e.destroy
  end
end